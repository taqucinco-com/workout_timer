// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'command_analyzer_schema.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CommandAnalyzerSchema {

 String get command; String? get parameter;
/// Create a copy of CommandAnalyzerSchema
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CommandAnalyzerSchemaCopyWith<CommandAnalyzerSchema> get copyWith => _$CommandAnalyzerSchemaCopyWithImpl<CommandAnalyzerSchema>(this as CommandAnalyzerSchema, _$identity);

  /// Serializes this CommandAnalyzerSchema to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommandAnalyzerSchema&&(identical(other.command, command) || other.command == command)&&(identical(other.parameter, parameter) || other.parameter == parameter));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,command,parameter);

@override
String toString() {
  return 'CommandAnalyzerSchema(command: $command, parameter: $parameter)';
}


}

/// @nodoc
abstract mixin class $CommandAnalyzerSchemaCopyWith<$Res>  {
  factory $CommandAnalyzerSchemaCopyWith(CommandAnalyzerSchema value, $Res Function(CommandAnalyzerSchema) _then) = _$CommandAnalyzerSchemaCopyWithImpl;
@useResult
$Res call({
 String command, String? parameter
});




}
/// @nodoc
class _$CommandAnalyzerSchemaCopyWithImpl<$Res>
    implements $CommandAnalyzerSchemaCopyWith<$Res> {
  _$CommandAnalyzerSchemaCopyWithImpl(this._self, this._then);

  final CommandAnalyzerSchema _self;
  final $Res Function(CommandAnalyzerSchema) _then;

/// Create a copy of CommandAnalyzerSchema
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? command = null,Object? parameter = freezed,}) {
  return _then(_self.copyWith(
command: null == command ? _self.command : command // ignore: cast_nullable_to_non_nullable
as String,parameter: freezed == parameter ? _self.parameter : parameter // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CommandAnalyzerSchema].
extension CommandAnalyzerSchemaPatterns on CommandAnalyzerSchema {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CommandAnalyzerSchema value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CommandAnalyzerSchema() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CommandAnalyzerSchema value)  $default,){
final _that = this;
switch (_that) {
case _CommandAnalyzerSchema():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CommandAnalyzerSchema value)?  $default,){
final _that = this;
switch (_that) {
case _CommandAnalyzerSchema() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String command,  String? parameter)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CommandAnalyzerSchema() when $default != null:
return $default(_that.command,_that.parameter);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String command,  String? parameter)  $default,) {final _that = this;
switch (_that) {
case _CommandAnalyzerSchema():
return $default(_that.command,_that.parameter);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String command,  String? parameter)?  $default,) {final _that = this;
switch (_that) {
case _CommandAnalyzerSchema() when $default != null:
return $default(_that.command,_that.parameter);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CommandAnalyzerSchema implements CommandAnalyzerSchema {
  const _CommandAnalyzerSchema({this.command = '', this.parameter});
  factory _CommandAnalyzerSchema.fromJson(Map<String, dynamic> json) => _$CommandAnalyzerSchemaFromJson(json);

@override@JsonKey() final  String command;
@override final  String? parameter;

/// Create a copy of CommandAnalyzerSchema
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CommandAnalyzerSchemaCopyWith<_CommandAnalyzerSchema> get copyWith => __$CommandAnalyzerSchemaCopyWithImpl<_CommandAnalyzerSchema>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CommandAnalyzerSchemaToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CommandAnalyzerSchema&&(identical(other.command, command) || other.command == command)&&(identical(other.parameter, parameter) || other.parameter == parameter));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,command,parameter);

@override
String toString() {
  return 'CommandAnalyzerSchema(command: $command, parameter: $parameter)';
}


}

/// @nodoc
abstract mixin class _$CommandAnalyzerSchemaCopyWith<$Res> implements $CommandAnalyzerSchemaCopyWith<$Res> {
  factory _$CommandAnalyzerSchemaCopyWith(_CommandAnalyzerSchema value, $Res Function(_CommandAnalyzerSchema) _then) = __$CommandAnalyzerSchemaCopyWithImpl;
@override @useResult
$Res call({
 String command, String? parameter
});




}
/// @nodoc
class __$CommandAnalyzerSchemaCopyWithImpl<$Res>
    implements _$CommandAnalyzerSchemaCopyWith<$Res> {
  __$CommandAnalyzerSchemaCopyWithImpl(this._self, this._then);

  final _CommandAnalyzerSchema _self;
  final $Res Function(_CommandAnalyzerSchema) _then;

/// Create a copy of CommandAnalyzerSchema
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? command = null,Object? parameter = freezed,}) {
  return _then(_CommandAnalyzerSchema(
command: null == command ? _self.command : command // ignore: cast_nullable_to_non_nullable
as String,parameter: freezed == parameter ? _self.parameter : parameter // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
