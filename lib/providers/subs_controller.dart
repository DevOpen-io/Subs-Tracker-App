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

@riverpod
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
    DateTime scheduledDate = DateTime(
      now.year,
      now.month,
      slice.startDate.day,
      12, // 12 PM
      0,
      0,
    );
  
    // If the scheduled date is before now, move it to the next month
    if (scheduledDate.isBefore(now)) {
      scheduledDate = DateTime(
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
}
