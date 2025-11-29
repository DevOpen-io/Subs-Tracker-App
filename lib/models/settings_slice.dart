import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'settings_slice.freezed.dart';
part 'settings_slice.g.dart';


enum Currency {
  try_('₺', 'Turkish Lira'),
  usd('\$', 'US Dollar'),
  eur('€', 'Euro'),
  gbp('£', 'British Pound'),
  jpy('¥', 'Japanese Yen'),
  cad('C\$', 'Canadian Dollar'),
  aud('A\$', 'Australian Dollar');

  final String symbol;
  final String label;

  const Currency(this.symbol, this.label);
}

@freezed
abstract class SettingsSlice with _$SettingsSlice {
  const factory SettingsSlice({
  ThemeMode? theme,
  Currency? currency,
  @NullableFileConverter() Uint8List? profilePicture,
  String? userName,
  String? email,
  bool? isFirstTime,
  }) = _SettingsSlice;

    factory SettingsSlice.fromJson(Map<String, dynamic> json) =>
      _$SettingsSliceFromJson(json);
}

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
