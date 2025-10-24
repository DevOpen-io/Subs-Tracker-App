// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_slice.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SettingsSlice _$SettingsSliceFromJson(Map<String, dynamic> json) =>
    _SettingsSlice(
      theme: $enumDecode(_$ThemeModeEnumMap, json['theme']),
      profilePicture: const NullableFileConverter().fromJson(
        json['profilePicture'] as String?,
      ),
      userName: json['userName'] as String,
      email: json['email'] as String,
    );

Map<String, dynamic> _$SettingsSliceToJson(_SettingsSlice instance) =>
    <String, dynamic>{
      'theme': _$ThemeModeEnumMap[instance.theme]!,
      'profilePicture': const NullableFileConverter().toJson(
        instance.profilePicture,
      ),
      'userName': instance.userName,
      'email': instance.email,
    };

const _$ThemeModeEnumMap = {
  ThemeMode.system: 'system',
  ThemeMode.light: 'light',
  ThemeMode.dark: 'dark',
};
