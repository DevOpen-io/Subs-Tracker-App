// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'settings_slice.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SettingsSlice {

 ThemeMode? get theme; Currency? get currency;@NullableFileConverter() Uint8List? get profilePicture; String? get userName; String? get email; bool? get isFirstTime;
/// Create a copy of SettingsSlice
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SettingsSliceCopyWith<SettingsSlice> get copyWith => _$SettingsSliceCopyWithImpl<SettingsSlice>(this as SettingsSlice, _$identity);

  /// Serializes this SettingsSlice to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SettingsSlice&&(identical(other.theme, theme) || other.theme == theme)&&(identical(other.currency, currency) || other.currency == currency)&&const DeepCollectionEquality().equals(other.profilePicture, profilePicture)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.email, email) || other.email == email)&&(identical(other.isFirstTime, isFirstTime) || other.isFirstTime == isFirstTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,theme,currency,const DeepCollectionEquality().hash(profilePicture),userName,email,isFirstTime);

@override
String toString() {
  return 'SettingsSlice(theme: $theme, currency: $currency, profilePicture: $profilePicture, userName: $userName, email: $email, isFirstTime: $isFirstTime)';
}


}

/// @nodoc
abstract mixin class $SettingsSliceCopyWith<$Res>  {
  factory $SettingsSliceCopyWith(SettingsSlice value, $Res Function(SettingsSlice) _then) = _$SettingsSliceCopyWithImpl;
@useResult
$Res call({
 ThemeMode? theme, Currency? currency,@NullableFileConverter() Uint8List? profilePicture, String? userName, String? email, bool? isFirstTime
});




}
/// @nodoc
class _$SettingsSliceCopyWithImpl<$Res>
    implements $SettingsSliceCopyWith<$Res> {
  _$SettingsSliceCopyWithImpl(this._self, this._then);

  final SettingsSlice _self;
  final $Res Function(SettingsSlice) _then;

/// Create a copy of SettingsSlice
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? theme = freezed,Object? currency = freezed,Object? profilePicture = freezed,Object? userName = freezed,Object? email = freezed,Object? isFirstTime = freezed,}) {
  return _then(_self.copyWith(
theme: freezed == theme ? _self.theme : theme // ignore: cast_nullable_to_non_nullable
as ThemeMode?,currency: freezed == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as Currency?,profilePicture: freezed == profilePicture ? _self.profilePicture : profilePicture // ignore: cast_nullable_to_non_nullable
as Uint8List?,userName: freezed == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,isFirstTime: freezed == isFirstTime ? _self.isFirstTime : isFirstTime // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// Adds pattern-matching-related methods to [SettingsSlice].
extension SettingsSlicePatterns on SettingsSlice {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SettingsSlice value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SettingsSlice() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SettingsSlice value)  $default,){
final _that = this;
switch (_that) {
case _SettingsSlice():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SettingsSlice value)?  $default,){
final _that = this;
switch (_that) {
case _SettingsSlice() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ThemeMode? theme,  Currency? currency, @NullableFileConverter()  Uint8List? profilePicture,  String? userName,  String? email,  bool? isFirstTime)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SettingsSlice() when $default != null:
return $default(_that.theme,_that.currency,_that.profilePicture,_that.userName,_that.email,_that.isFirstTime);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ThemeMode? theme,  Currency? currency, @NullableFileConverter()  Uint8List? profilePicture,  String? userName,  String? email,  bool? isFirstTime)  $default,) {final _that = this;
switch (_that) {
case _SettingsSlice():
return $default(_that.theme,_that.currency,_that.profilePicture,_that.userName,_that.email,_that.isFirstTime);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ThemeMode? theme,  Currency? currency, @NullableFileConverter()  Uint8List? profilePicture,  String? userName,  String? email,  bool? isFirstTime)?  $default,) {final _that = this;
switch (_that) {
case _SettingsSlice() when $default != null:
return $default(_that.theme,_that.currency,_that.profilePicture,_that.userName,_that.email,_that.isFirstTime);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SettingsSlice implements SettingsSlice {
  const _SettingsSlice({this.theme, this.currency, @NullableFileConverter() this.profilePicture, this.userName, this.email, this.isFirstTime});
  factory _SettingsSlice.fromJson(Map<String, dynamic> json) => _$SettingsSliceFromJson(json);

@override final  ThemeMode? theme;
@override final  Currency? currency;
@override@NullableFileConverter() final  Uint8List? profilePicture;
@override final  String? userName;
@override final  String? email;
@override final  bool? isFirstTime;

/// Create a copy of SettingsSlice
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SettingsSliceCopyWith<_SettingsSlice> get copyWith => __$SettingsSliceCopyWithImpl<_SettingsSlice>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SettingsSliceToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SettingsSlice&&(identical(other.theme, theme) || other.theme == theme)&&(identical(other.currency, currency) || other.currency == currency)&&const DeepCollectionEquality().equals(other.profilePicture, profilePicture)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.email, email) || other.email == email)&&(identical(other.isFirstTime, isFirstTime) || other.isFirstTime == isFirstTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,theme,currency,const DeepCollectionEquality().hash(profilePicture),userName,email,isFirstTime);

@override
String toString() {
  return 'SettingsSlice(theme: $theme, currency: $currency, profilePicture: $profilePicture, userName: $userName, email: $email, isFirstTime: $isFirstTime)';
}


}

/// @nodoc
abstract mixin class _$SettingsSliceCopyWith<$Res> implements $SettingsSliceCopyWith<$Res> {
  factory _$SettingsSliceCopyWith(_SettingsSlice value, $Res Function(_SettingsSlice) _then) = __$SettingsSliceCopyWithImpl;
@override @useResult
$Res call({
 ThemeMode? theme, Currency? currency,@NullableFileConverter() Uint8List? profilePicture, String? userName, String? email, bool? isFirstTime
});




}
/// @nodoc
class __$SettingsSliceCopyWithImpl<$Res>
    implements _$SettingsSliceCopyWith<$Res> {
  __$SettingsSliceCopyWithImpl(this._self, this._then);

  final _SettingsSlice _self;
  final $Res Function(_SettingsSlice) _then;

/// Create a copy of SettingsSlice
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? theme = freezed,Object? currency = freezed,Object? profilePicture = freezed,Object? userName = freezed,Object? email = freezed,Object? isFirstTime = freezed,}) {
  return _then(_SettingsSlice(
theme: freezed == theme ? _self.theme : theme // ignore: cast_nullable_to_non_nullable
as ThemeMode?,currency: freezed == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as Currency?,profilePicture: freezed == profilePicture ? _self.profilePicture : profilePicture // ignore: cast_nullable_to_non_nullable
as Uint8List?,userName: freezed == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,isFirstTime: freezed == isFirstTime ? _self.isFirstTime : isFirstTime // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}

// dart format on
