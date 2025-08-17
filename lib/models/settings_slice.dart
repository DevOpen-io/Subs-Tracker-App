import 'package:flutter/material.dart';

class SettingsSlice {
  final ThemeMode theme;

  const SettingsSlice({required this.theme});

  SettingsSlice copyWith({ThemeMode? theme}) {
    return SettingsSlice(theme: theme ?? this.theme);
  }
}
