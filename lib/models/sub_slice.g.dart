// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sub_slice.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SubSlice _$SubSliceFromJson(Map<String, dynamic> json) => _SubSlice(
  brand: json['brand'] == null
      ? null
      : Brand.fromJson(json['brand'] as Map<String, dynamic>),
  name: json['name'] as String,
  amount: (json['amount'] as num).toDouble(),
  color: (json['color'] as num).toInt(),
  startDate: DateTime.parse(json['startDate'] as String),
);

Map<String, dynamic> _$SubSliceToJson(_SubSlice instance) => <String, dynamic>{
  'brand': instance.brand,
  'name': instance.name,
  'amount': instance.amount,
  'color': instance.color,
  'startDate': instance.startDate.toIso8601String(),
};
