// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'brand.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Brand _$BrandFromJson(Map<String, dynamic> json) => _Brand(
  text: json['text'] as String,
  logo: json['logo'] as String?,
  category: json['category'] as String?,
  name: json['name'] as String?,
  country: json['country'] as String?,
  desc: json['desc'] as String?,
  isNative: json['isNative'] as bool?,
);

Map<String, dynamic> _$BrandToJson(_Brand instance) => <String, dynamic>{
  'text': instance.text,
  'logo': instance.logo,
  'category': instance.category,
  'name': instance.name,
  'country': instance.country,
  'desc': instance.desc,
  'isNative': instance.isNative,
};
