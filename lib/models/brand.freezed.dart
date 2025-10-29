// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'brand.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Brand {

 String get text; String? get logo; String? get category; String? get name; String? get country; String? get desc; bool? get isNative;
/// Create a copy of Brand
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BrandCopyWith<Brand> get copyWith => _$BrandCopyWithImpl<Brand>(this as Brand, _$identity);

  /// Serializes this Brand to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Brand&&(identical(other.text, text) || other.text == text)&&(identical(other.logo, logo) || other.logo == logo)&&(identical(other.category, category) || other.category == category)&&(identical(other.name, name) || other.name == name)&&(identical(other.country, country) || other.country == country)&&(identical(other.desc, desc) || other.desc == desc)&&(identical(other.isNative, isNative) || other.isNative == isNative));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,text,logo,category,name,country,desc,isNative);

@override
String toString() {
  return 'Brand(text: $text, logo: $logo, category: $category, name: $name, country: $country, desc: $desc, isNative: $isNative)';
}


}

/// @nodoc
abstract mixin class $BrandCopyWith<$Res>  {
  factory $BrandCopyWith(Brand value, $Res Function(Brand) _then) = _$BrandCopyWithImpl;
@useResult
$Res call({
 String text, String? logo, String? category, String? name, String? country, String? desc, bool? isNative
});




}
/// @nodoc
class _$BrandCopyWithImpl<$Res>
    implements $BrandCopyWith<$Res> {
  _$BrandCopyWithImpl(this._self, this._then);

  final Brand _self;
  final $Res Function(Brand) _then;

/// Create a copy of Brand
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? text = null,Object? logo = freezed,Object? category = freezed,Object? name = freezed,Object? country = freezed,Object? desc = freezed,Object? isNative = freezed,}) {
  return _then(_self.copyWith(
text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,logo: freezed == logo ? _self.logo : logo // ignore: cast_nullable_to_non_nullable
as String?,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,country: freezed == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String?,desc: freezed == desc ? _self.desc : desc // ignore: cast_nullable_to_non_nullable
as String?,isNative: freezed == isNative ? _self.isNative : isNative // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// Adds pattern-matching-related methods to [Brand].
extension BrandPatterns on Brand {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Brand value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Brand() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Brand value)  $default,){
final _that = this;
switch (_that) {
case _Brand():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Brand value)?  $default,){
final _that = this;
switch (_that) {
case _Brand() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String text,  String? logo,  String? category,  String? name,  String? country,  String? desc,  bool? isNative)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Brand() when $default != null:
return $default(_that.text,_that.logo,_that.category,_that.name,_that.country,_that.desc,_that.isNative);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String text,  String? logo,  String? category,  String? name,  String? country,  String? desc,  bool? isNative)  $default,) {final _that = this;
switch (_that) {
case _Brand():
return $default(_that.text,_that.logo,_that.category,_that.name,_that.country,_that.desc,_that.isNative);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String text,  String? logo,  String? category,  String? name,  String? country,  String? desc,  bool? isNative)?  $default,) {final _that = this;
switch (_that) {
case _Brand() when $default != null:
return $default(_that.text,_that.logo,_that.category,_that.name,_that.country,_that.desc,_that.isNative);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Brand implements Brand {
  const _Brand({required this.text, this.logo, this.category, this.name, this.country, this.desc, this.isNative});
  factory _Brand.fromJson(Map<String, dynamic> json) => _$BrandFromJson(json);

@override final  String text;
@override final  String? logo;
@override final  String? category;
@override final  String? name;
@override final  String? country;
@override final  String? desc;
@override final  bool? isNative;

/// Create a copy of Brand
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BrandCopyWith<_Brand> get copyWith => __$BrandCopyWithImpl<_Brand>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BrandToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Brand&&(identical(other.text, text) || other.text == text)&&(identical(other.logo, logo) || other.logo == logo)&&(identical(other.category, category) || other.category == category)&&(identical(other.name, name) || other.name == name)&&(identical(other.country, country) || other.country == country)&&(identical(other.desc, desc) || other.desc == desc)&&(identical(other.isNative, isNative) || other.isNative == isNative));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,text,logo,category,name,country,desc,isNative);

@override
String toString() {
  return 'Brand(text: $text, logo: $logo, category: $category, name: $name, country: $country, desc: $desc, isNative: $isNative)';
}


}

/// @nodoc
abstract mixin class _$BrandCopyWith<$Res> implements $BrandCopyWith<$Res> {
  factory _$BrandCopyWith(_Brand value, $Res Function(_Brand) _then) = __$BrandCopyWithImpl;
@override @useResult
$Res call({
 String text, String? logo, String? category, String? name, String? country, String? desc, bool? isNative
});




}
/// @nodoc
class __$BrandCopyWithImpl<$Res>
    implements _$BrandCopyWith<$Res> {
  __$BrandCopyWithImpl(this._self, this._then);

  final _Brand _self;
  final $Res Function(_Brand) _then;

/// Create a copy of Brand
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? text = null,Object? logo = freezed,Object? category = freezed,Object? name = freezed,Object? country = freezed,Object? desc = freezed,Object? isNative = freezed,}) {
  return _then(_Brand(
text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,logo: freezed == logo ? _self.logo : logo // ignore: cast_nullable_to_non_nullable
as String?,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,country: freezed == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String?,desc: freezed == desc ? _self.desc : desc // ignore: cast_nullable_to_non_nullable
as String?,isNative: freezed == isNative ? _self.isNative : isNative // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}

// dart format on
