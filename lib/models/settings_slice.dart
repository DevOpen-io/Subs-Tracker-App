import 'dart:io';

import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'settings_slice.freezed.dart';
part 'settings_slice.g.dart';

// A JsonConverter for File? <-> String? conversion
class NullableFileConverter implements JsonConverter<File?, String?> {
  const NullableFileConverter();

  // Convert from JSON (String?) to a File? when reading
  @override
  File? fromJson(String? json) {
    return json == null ? null : File(json);
  }

  // Convert a File? to JSON (String?) when writing
  @override
  String? toJson(File? file) {
    return file?.path;
  }
}

@freezed
abstract class SettingsSlice with _$SettingsSlice {
  const factory SettingsSlice({
    required ThemeMode theme,
    @NullableFileConverter() File? profilePicture,
    required String userName,
    required String email,
  }) = _SettingsSlice;

  factory SettingsSlice.fromJson(Map<String, dynamic> json) =>
      _$SettingsSliceFromJson(json);
}