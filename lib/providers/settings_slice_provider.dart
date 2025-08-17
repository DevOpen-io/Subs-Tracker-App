import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:subs_tracker/data/settings_slice_data.dart';
import 'package:subs_tracker/models/settings_slice.dart';

class SettingsSliceNotifier extends StateNotifier<SettingsSlice> {
  SettingsSliceNotifier() : super(settingsData);

  void updateTheme() {
    state = state.copyWith(
      theme: state.theme == ThemeMode.light ? ThemeMode.dark : ThemeMode.light,
    );
  }
}

final settingsSliceProvider =
    StateNotifierProvider<SettingsSliceNotifier, SettingsSlice>(
      (ref) => SettingsSliceNotifier(),
    );
