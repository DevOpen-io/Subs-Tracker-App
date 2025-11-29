import 'dart:typed_data';

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
    @Uint8ListConverter() Uint8List? profilePicture,
    String? userName,
    String? email,
    bool? isFirstTime,
  }) = _SettingsViewModel;

  factory SettingsViewModel.fromJson(Map<String, dynamic> json) =>
      _$SettingsViewModelFromJson(json);

}

/// Converts to and from [Uint8List] and [List]<[int]>.
class Uint8ListConverter implements JsonConverter<Uint8List?, List<int>?> {
  /// Create a new instance of [Uint8ListConverter].
  const Uint8ListConverter();

  @override
  Uint8List? fromJson(List<int>? json) {
    if (json == null) return null;

    return Uint8List.fromList(json);
  }

  @override
  List<int>? toJson(Uint8List? object) {
    if (object == null) return null;

    return object.toList();
  }
}
