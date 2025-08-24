// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sub_slice.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SubSlice _$SubSliceFromJson(Map<String, dynamic> json) => _SubSlice(
  name: json['name'] as String,
  amount: (json['amount'] as num).toDouble(),
  color: (json['color'] as num).toInt(),
  startDate: DateTime.parse(json['startDate'] as String),
);

Map<String, dynamic> _$SubSliceToJson(_SubSlice instance) => <String, dynamic>{
  'name': instance.name,
  'amount': instance.amount,
  'color': instance.color,
  'startDate': instance.startDate.toIso8601String(),
};
