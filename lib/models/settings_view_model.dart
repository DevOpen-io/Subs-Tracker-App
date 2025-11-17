import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:subs_tracker/models/settings_slice.dart';

part 'settings_view_model.freezed.dart';
part 'settings_view_model.g.dart';

@freezed
abstract class SettingsViewModel with _$SettingsViewModel {
  const factory SettingsViewModel({
    required ThemeMode theme,
    required Currency currency,
  }) = _SettingsViewModel;

  factory SettingsViewModel.fromJson(Map<String, dynamic> json) =>
      _$SettingsViewModelFromJson(json);
}
