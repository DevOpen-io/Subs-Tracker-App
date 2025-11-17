import 'package:flutter/material.dart';

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

class SettingsSlice {
  final ThemeMode theme;
  final Currency currency;

  const SettingsSlice({
    required this.theme,
    this.currency = Currency.try_,
  });

  SettingsSlice copyWith({
    ThemeMode? theme,
    Currency? currency,
  }) {
    return SettingsSlice(
      theme: theme ?? this.theme,
      currency: currency ?? this.currency,
    );
  }
}
