// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'test_person.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TestPerson {
  String get firstName;
  String get lastName;
  int get age;

  /// Create a copy of TestPerson
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TestPersonCopyWith<TestPerson> get copyWith =>
      _$TestPersonCopyWithImpl<TestPerson>(this as TestPerson, _$identity);

  /// Serializes this TestPerson to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TestPerson &&
            (identical(other.firstName, firstName) || other.firstName == firstName) &&
            (identical(other.lastName, lastName) || other.lastName == lastName) &&
            (identical(other.age, age) || other.age == age));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, firstName, lastName, age);

  @override
  String toString() {
    return 'TestPerson(firstName: $firstName, lastName: $lastName, age: $age)';
  }
}

/// @nodoc
abstract mixin class $TestPersonCopyWith<$Res> {
  factory $TestPersonCopyWith(TestPerson value, $Res Function(TestPerson) _then) =
      _$TestPersonCopyWithImpl;
  @useResult
  $Res call({String firstName, String lastName, int age});
}

/// @nodoc
class _$TestPersonCopyWithImpl<$Res> implements $TestPersonCopyWith<$Res> {
  _$TestPersonCopyWithImpl(this._self, this._then);

  final TestPerson _self;
  final $Res Function(TestPerson) _then;

  /// Create a copy of TestPerson
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? firstName = null,
    Object? lastName = null,
    Object? age = null,
  }) {
    return _then(_self.copyWith(
      firstName: null == firstName
          ? _self.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      lastName: null == lastName
          ? _self.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
      age: null == age
          ? _self.age
          : age // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _TestPerson implements TestPerson {
  const _TestPerson({required this.firstName, required this.lastName, required this.age});
  factory _TestPerson.fromJson(Map<String, dynamic> json) => _$TestPersonFromJson(json);

  @override
  final String firstName;
  @override
  final String lastName;
  @override
  final int age;

  /// Create a copy of TestPerson
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$TestPersonCopyWith<_TestPerson> get copyWith =>
      __$TestPersonCopyWithImpl<_TestPerson>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$TestPersonToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _TestPerson &&
            (identical(other.firstName, firstName) || other.firstName == firstName) &&
            (identical(other.lastName, lastName) || other.lastName == lastName) &&
            (identical(other.age, age) || other.age == age));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, firstName, lastName, age);

  @override
  String toString() {
    return 'TestPerson(firstName: $firstName, lastName: $lastName, age: $age)';
  }
}

/// @nodoc
abstract mixin class _$TestPersonCopyWith<$Res> implements $TestPersonCopyWith<$Res> {
  factory _$TestPersonCopyWith(_TestPerson value, $Res Function(_TestPerson) _then) =
      __$TestPersonCopyWithImpl;
  @override
  @useResult
  $Res call({String firstName, String lastName, int age});
}

/// @nodoc
class __$TestPersonCopyWithImpl<$Res> implements _$TestPersonCopyWith<$Res> {
  __$TestPersonCopyWithImpl(this._self, this._then);

  final _TestPerson _self;
  final $Res Function(_TestPerson) _then;

  /// Create a copy of TestPerson
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? firstName = null,
    Object? lastName = null,
    Object? age = null,
  }) {
    return _then(_TestPerson(
      firstName: null == firstName
          ? _self.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      lastName: null == lastName
          ? _self.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
      age: null == age
          ? _self.age
          : age // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

// dart format on
