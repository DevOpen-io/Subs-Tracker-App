import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:subs_tracker/models/brand.dart';

part 'sub_slice.freezed.dart';
part 'sub_slice.g.dart';

@freezed
abstract class SubSlice with _$SubSlice {
  const factory SubSlice({
    Brand? brand,
    required String name,
    required double amount,
    required int color,
    required DateTime startDate,
  }) = _SubSlice;

  factory SubSlice.fromJson(Map<String, dynamic> json) =>
      _$SubSliceFromJson(json);
}
