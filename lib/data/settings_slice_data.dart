import 'package:flutter/material.dart';
import 'package:subs_tracker/models/settings_view_model.dart';

SettingsViewModel settingsData = SettingsViewModel(
  theme: ThemeMode.system,
  currency: Currency.try_,
  profilePicture: null,
  userName: "Acme",
  email: "VeryCoolMail@acme.com",
  isFirstTime: true,
);
