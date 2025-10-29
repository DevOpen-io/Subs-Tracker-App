import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'settings_slice.freezed.dart';
part 'settings_slice.g.dart';

// A JsonConverter for File? <-> String? conversion
class NullableFileConverter implements JsonConverter<Uint8List?, String?> {
  const NullableFileConverter();

  // Convert from JSON (String?) to a File? when reading
  @override
  Uint8List? fromJson(String? json) {
    return json == null ? null : base64Decode(json);
  }

  // Convert a File? to JSON (String?) when writing
  @override
  String? toJson(Uint8List? bytes) {
    return bytes == null ? null : base64Encode(bytes);
  }
}

@freezed
abstract class SettingsSlice with _$SettingsSlice {
  const factory SettingsSlice({
    ThemeMode? theme,
    @NullableFileConverter() Uint8List? profilePicture,
    String? userName,
    String? email,
  }) = _SettingsSlice;

  factory SettingsSlice.fromJson(Map<String, dynamic> json) =>
      _$SettingsSliceFromJson(json);
}
