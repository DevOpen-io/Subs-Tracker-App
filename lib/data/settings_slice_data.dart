import 'package:flutter/material.dart';
import 'package:subs_tracker/models/settings_slice.dart';

SettingsSlice settingsData = SettingsSlice(
  theme: ThemeMode.system,
  profilePicture: null,
  userName: "Acme",
  email: "VeryCoolMail@acme.com",
  isFirstTime: true,
);
