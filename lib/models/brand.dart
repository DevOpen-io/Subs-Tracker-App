import 'package:freezed_annotation/freezed_annotation.dart';

part 'brand.freezed.dart';
part 'brand.g.dart';

@freezed
abstract class Brand with _$Brand {
  const factory Brand({
    required String text,
    String? logo,
    String? category,
    String? name,
    String? country,
    String? desc,
    bool? isNative,
  }) = _Brand;

  factory Brand.fromJson(Map<String, dynamic> json) => _$BrandFromJson(json);
}
