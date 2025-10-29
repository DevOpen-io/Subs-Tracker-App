import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:path/path.dart';
import 'package:riverpod_annotation/experimental/json_persist.dart';
import 'package:riverpod_annotation/experimental/persist.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_sqflite/riverpod_sqflite.dart';
import 'package:sqflite/sqflite.dart';
import 'package:subs_tracker/data/settings_slice_data.dart';
import 'package:subs_tracker/models/settings_slice.dart';

part 'settings_controller.g.dart';

@riverpod
Future<JsonSqFliteStorage> settingsStorage(Ref ref) async {
  JsonSqFliteStorage storage = await JsonSqFliteStorage.open(
    join(await getDatabasesPath(), 'settings.db'),
  );

  ref
    ..onDispose(storage.close)
    ..keepAlive();
  return storage;
}

@riverpod
@JsonPersist()
class SettingsController extends _$SettingsController {
  @override
  FutureOr<SettingsSlice> build() async {
    await persist(
      ref.watch(settingsStorageProvider.future),
      options: StorageOptions(
        cacheTime: StorageCacheTime.unsafe_forever,
        destroyKey: "v1",
      ),
    ).future;
    return state.value ?? SettingsSlice();
  }

  void updateSettingsSliceData({
    ThemeMode? theme,
    Uint8List? profilePicture,
    String? userName,
    String? email,
  }) {
    if (state.value == null) return;
    state = AsyncValue.data(
      state.value!.copyWith(
        theme: theme ?? state.value?.theme,
        profilePicture: profilePicture ?? state.value?.profilePicture,
        userName: userName ?? state.value?.userName,
        email: email ?? state.value?.email,
      ),
    );
  }
}
