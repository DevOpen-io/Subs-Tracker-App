import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:subs_tracker/data/settings_slice_data.dart';
import 'package:subs_tracker/models/settings_slice.dart';

class SettingsSliceNotifier extends StateNotifier<SettingsSlice> {
  SettingsSliceNotifier() : super(settingsData);

  void updateTheme(ThemeMode mode) {
    state = state.copyWith(
      theme: mode,
    );
  }
}

final settingsSliceProvider =
    StateNotifierProvider<SettingsSliceNotifier, SettingsSlice>(
      (ref) => SettingsSliceNotifier(),
    );
