// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_slice.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SettingsSlice _$SettingsSliceFromJson(Map<String, dynamic> json) =>
    _SettingsSlice(
      theme: $enumDecodeNullable(_$ThemeModeEnumMap, json['theme']),
      currency: $enumDecodeNullable(_$CurrencyEnumMap, json['currency']),
      profilePicture: const NullableFileConverter().fromJson(
        json['profilePicture'] as String?,
      ),
      userName: json['userName'] as String?,
      email: json['email'] as String?,
      isFirstTime: json['isFirstTime'] as bool?,
    );

Map<String, dynamic> _$SettingsSliceToJson(_SettingsSlice instance) =>
    <String, dynamic>{
      'theme': _$ThemeModeEnumMap[instance.theme],
      'currency': _$CurrencyEnumMap[instance.currency],
      'profilePicture': const NullableFileConverter().toJson(
        instance.profilePicture,
      ),
      'userName': instance.userName,
      'email': instance.email,
      'isFirstTime': instance.isFirstTime,
    };

const _$ThemeModeEnumMap = {
  ThemeMode.system: 'system',
  ThemeMode.light: 'light',
  ThemeMode.dark: 'dark',
};

const _$CurrencyEnumMap = {
  Currency.try_: 'try_',
  Currency.usd: 'usd',
  Currency.eur: 'eur',
  Currency.gbp: 'gbp',
  Currency.jpy: 'jpy',
  Currency.cad: 'cad',
  Currency.aud: 'aud',
};
