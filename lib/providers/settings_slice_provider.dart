import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:subs_tracker/data/settings_slice_data.dart';
import 'package:subs_tracker/models/settings_slice.dart';

class SettingsSliceNotifier extends StateNotifier<SettingsSlice> {
  SettingsSliceNotifier() : super(settingsData);

  void updateSettingsSliceData({ThemeMode? theme, File? profilePicture , String? userName, String? email}) {
    state = state.copyWith(
      theme: theme ?? state.theme,
      profilePicture: profilePicture ?? state.profilePicture,
      userName: userName ?? state.userName,
      email : email ?? state.email
    );
  }
}

final settingsSliceProvider =
    StateNotifierProvider<SettingsSliceNotifier, SettingsSlice>(
      (ref) => SettingsSliceNotifier(),
    );
