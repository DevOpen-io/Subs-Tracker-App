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

 ThemeMode get theme;@NullableFileConverter() File? get profilePicture; String get userName; String get email;
/// Create a copy of SettingsSlice
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SettingsSliceCopyWith<SettingsSlice> get copyWith => _$SettingsSliceCopyWithImpl<SettingsSlice>(this as SettingsSlice, _$identity);

  /// Serializes this SettingsSlice to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SettingsSlice&&(identical(other.theme, theme) || other.theme == theme)&&(identical(other.profilePicture, profilePicture) || other.profilePicture == profilePicture)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.email, email) || other.email == email));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,theme,profilePicture,userName,email);

@override
String toString() {
  return 'SettingsSlice(theme: $theme, profilePicture: $profilePicture, userName: $userName, email: $email)';
}


}

/// @nodoc
abstract mixin class $SettingsSliceCopyWith<$Res>  {
  factory $SettingsSliceCopyWith(SettingsSlice value, $Res Function(SettingsSlice) _then) = _$SettingsSliceCopyWithImpl;
@useResult
$Res call({
 ThemeMode theme,@NullableFileConverter() File? profilePicture, String userName, String email
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
@pragma('vm:prefer-inline') @override $Res call({Object? theme = null,Object? profilePicture = freezed,Object? userName = null,Object? email = null,}) {
  return _then(_self.copyWith(
theme: null == theme ? _self.theme : theme // ignore: cast_nullable_to_non_nullable
as ThemeMode,profilePicture: freezed == profilePicture ? _self.profilePicture : profilePicture // ignore: cast_nullable_to_non_nullable
as File?,userName: null == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ThemeMode theme, @NullableFileConverter()  File? profilePicture,  String userName,  String email)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SettingsSlice() when $default != null:
return $default(_that.theme,_that.profilePicture,_that.userName,_that.email);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ThemeMode theme, @NullableFileConverter()  File? profilePicture,  String userName,  String email)  $default,) {final _that = this;
switch (_that) {
case _SettingsSlice():
return $default(_that.theme,_that.profilePicture,_that.userName,_that.email);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ThemeMode theme, @NullableFileConverter()  File? profilePicture,  String userName,  String email)?  $default,) {final _that = this;
switch (_that) {
case _SettingsSlice() when $default != null:
return $default(_that.theme,_that.profilePicture,_that.userName,_that.email);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SettingsSlice implements SettingsSlice {
  const _SettingsSlice({required this.theme, @NullableFileConverter() this.profilePicture, required this.userName, required this.email});
  factory _SettingsSlice.fromJson(Map<String, dynamic> json) => _$SettingsSliceFromJson(json);

@override final  ThemeMode theme;
@override@NullableFileConverter() final  File? profilePicture;
@override final  String userName;
@override final  String email;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SettingsSlice&&(identical(other.theme, theme) || other.theme == theme)&&(identical(other.profilePicture, profilePicture) || other.profilePicture == profilePicture)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.email, email) || other.email == email));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,theme,profilePicture,userName,email);

@override
String toString() {
  return 'SettingsSlice(theme: $theme, profilePicture: $profilePicture, userName: $userName, email: $email)';
}


}

/// @nodoc
abstract mixin class _$SettingsSliceCopyWith<$Res> implements $SettingsSliceCopyWith<$Res> {
  factory _$SettingsSliceCopyWith(_SettingsSlice value, $Res Function(_SettingsSlice) _then) = __$SettingsSliceCopyWithImpl;
@override @useResult
$Res call({
 ThemeMode theme,@NullableFileConverter() File? profilePicture, String userName, String email
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
@override @pragma('vm:prefer-inline') $Res call({Object? theme = null,Object? profilePicture = freezed,Object? userName = null,Object? email = null,}) {
  return _then(_SettingsSlice(
theme: null == theme ? _self.theme : theme // ignore: cast_nullable_to_non_nullable
as ThemeMode,profilePicture: freezed == profilePicture ? _self.profilePicture : profilePicture // ignore: cast_nullable_to_non_nullable
as File?,userName: null == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
