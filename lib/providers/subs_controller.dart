import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:riverpod_annotation/experimental/json_persist.dart';
import 'package:riverpod_annotation/experimental/persist.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_sqflite/riverpod_sqflite.dart';
import 'package:sqflite/sqflite.dart';
import 'package:subs_tracker/models/sub_slice.dart';
import 'package:subs_tracker/utils/notification_service.dart';
import 'package:timezone/timezone.dart' as tz;

part 'subs_controller.g.dart';

/// There is a limit imposed by iOS where it will only keep the 64 notifications
/// that were last set on any iOS versions newer than 9. On iOS versions 9 and older,
/// the 64 notifications that fire soonest are kept.
/// See https://developer.apple.com/documentation/uikit/uilocalnotification.
int maxNotifications = 64;

@riverpod
Future<JsonSqFliteStorage> subsStorage(Ref ref) async {
  JsonSqFliteStorage storage = await JsonSqFliteStorage.open(
    join(await getDatabasesPath(), 'subs.db'),
  );
  ref
    ..onDispose(storage.close)
    ..keepAlive();
  return storage;
}

@Riverpod(keepAlive: true)
@JsonPersist()
class SubsController extends _$SubsController {
  @override
  FutureOr<List<SubSlice>> build() async {
    await persist(
      ref.watch(subsStorageProvider.future),
      options: StorageOptions(
        cacheTime: StorageCacheTime.unsafe_forever,
        destroyKey: "v1",
      ),
    ).future;
    scheduleNotification();
    return state.value ?? [];
  }

  void addSlice(SubSlice slice) {
    state = AsyncValue.data(List.of(state.value ?? [])..add(slice));
  }

  void scheduleNotification() {
    debugPrint("Cancelling all notifications and scheduling new ones.");
    LocalNotificationService.instance.cancelAllNotifications();
    debugPrint(
      "Scheduling notifications for ${state.value?.length} subscriptions.",
    );
    for (final slice in state.value ?? []) {
      scheduleMonthlyRepeatingNotification(slice, state.value?.length ?? 0);
    }
  }

  Future<void> scheduleMonthlyRepeatingNotification(
    SubSlice slice,
    int sliceCount,
  ) async {
    if (sliceCount == 0) return;
    final now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      slice.startDate.day,
      12, // 12 PM
      0,
      0,
    );

    // If the scheduled date is before now, move it to the next month
    if (scheduledDate.isBefore(now)) {
      scheduledDate = tz.TZDateTime(
        tz.local,
        now.year,
        now.month + 1,
        slice.startDate.day,
        12, // 12 PM
        0,
        0,
      );
    }

    /// slice count -> 20
    /// 64/20 = 3.2 - 64 ~/ 20 = 3
    /// 64 max means 64 ~/ 20 = 3 notifications per slice
    int countPerSlice = maxNotifications ~/ sliceCount ~/ 2;

    /// Schedule the all monthly notifications
    for (int i = 0; i < countPerSlice; i++) {
      /// Unique IDs for each notification
      final id1 = slice.hashCode + i;
      final id2 = slice.hashCode + i + countPerSlice;
      LocalNotificationService.instance.scheduleNotification(
        id: id1,
        title: "Subscription Reminder",
        body: "Your subscription for ${slice.name} is due tomorrow.",
        scheduledDate: scheduledDate.copyWith(
          month: scheduledDate.month + i,
          day: scheduledDate.day - 1,
        ),
      );
      LocalNotificationService.instance.scheduleNotification(
        id: id2,
        title: "Subscription Reminder",
        body: "Your subscription for ${slice.name} is due.",
        scheduledDate: scheduledDate.copyWith(month: scheduledDate.month + i),
      );
    }
  }

  void removeAt(int index) {
    state = AsyncValue.data(List.of(state.value ?? [])..removeAt(index));
  }

  void updateAt(int index, SubSlice updated) {
    state = AsyncValue.data(List.of(state.value ?? [])..[index] = updated);
  }

  void clear() {
    state = AsyncValue.data([]);
  }

  /// Export subscriptions to JSON format
  Future<String> exportToJson() async {
    final subs = state.value ?? [];
    final jsonList = subs.map((sub) => sub.toJson()).toList();
    return jsonEncode({
      'version': 1,
      'exportDate': DateTime.now().toIso8601String(),
      'subscriptions': jsonList,
    });
  }

  /// Import subscriptions from JSON format
  Future<bool> importFromJson(String jsonString) async {
    if (!ref.mounted) return false;
    try {
      final decoded = jsonDecode(jsonString) as Map<String, dynamic>;
      final subscriptionsList = decoded['subscriptions'] as List<dynamic>;

      final importedSubs = subscriptionsList
          .map((json) => SubSlice.fromJson(json as Map<String, dynamic>))
          .toList();
      // Replace current subscriptions with imported ones
      state = AsyncValue.data(importedSubs);
      scheduleNotification();
      return true;
    } catch (e) {
      debugPrint('Error importing subscriptions: $e');
      return false;
    }
  }

  /// Export to file and return the file path
  Future<File?> exportToFile(String filePath) async {
    try {
      final jsonString = await exportToJson();
      final file = File(filePath);
      await file.writeAsString(jsonString);
      return file;
    } catch (e) {
      debugPrint('Error exporting to file: $e');
      return null;
    }
  }

  /// Import from file
  Future<bool> importFromFile(String filePath) async {
    try {
      final file = File(filePath);
      final jsonString = await file.readAsString();
      return await importFromJson(jsonString);
    } catch (e) {
      debugPrint('Error importing from file: $e');
      return false;
    }
  }
}
