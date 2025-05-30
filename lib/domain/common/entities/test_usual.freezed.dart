// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'test_usual.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TestUsual {
  String get id;
  bool get isSelected;
  String? get content;

  /// Create a copy of TestUsual
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TestUsualCopyWith<TestUsual> get copyWith =>
      _$TestUsualCopyWithImpl<TestUsual>(this as TestUsual, _$identity);

  /// Serializes this TestUsual to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TestUsual &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.isSelected, isSelected) || other.isSelected == isSelected) &&
            (identical(other.content, content) || other.content == content));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, isSelected, content);

  @override
  String toString() {
    return 'TestUsual(id: $id, isSelected: $isSelected, content: $content)';
  }
}

/// @nodoc
abstract mixin class $TestUsualCopyWith<$Res> {
  factory $TestUsualCopyWith(TestUsual value, $Res Function(TestUsual) _then) =
      _$TestUsualCopyWithImpl;
  @useResult
  $Res call({String id, bool isSelected, String? content});
}

/// @nodoc
class _$TestUsualCopyWithImpl<$Res> implements $TestUsualCopyWith<$Res> {
  _$TestUsualCopyWithImpl(this._self, this._then);

  final TestUsual _self;
  final $Res Function(TestUsual) _then;

  /// Create a copy of TestUsual
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? isSelected = null,
    Object? content = freezed,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      isSelected: null == isSelected
          ? _self.isSelected
          : isSelected // ignore: cast_nullable_to_non_nullable
              as bool,
      content: freezed == content
          ? _self.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _TestUsual implements TestUsual {
  const _TestUsual({required this.id, required this.isSelected, this.content});
  factory _TestUsual.fromJson(Map<String, dynamic> json) => _$TestUsualFromJson(json);

  @override
  final String id;
  @override
  final bool isSelected;
  @override
  final String? content;

  /// Create a copy of TestUsual
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$TestUsualCopyWith<_TestUsual> get copyWith =>
      __$TestUsualCopyWithImpl<_TestUsual>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$TestUsualToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _TestUsual &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.isSelected, isSelected) || other.isSelected == isSelected) &&
            (identical(other.content, content) || other.content == content));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, isSelected, content);

  @override
  String toString() {
    return 'TestUsual(id: $id, isSelected: $isSelected, content: $content)';
  }
}

/// @nodoc
abstract mixin class _$TestUsualCopyWith<$Res> implements $TestUsualCopyWith<$Res> {
  factory _$TestUsualCopyWith(_TestUsual value, $Res Function(_TestUsual) _then) =
      __$TestUsualCopyWithImpl;
  @override
  @useResult
  $Res call({String id, bool isSelected, String? content});
}

/// @nodoc
class __$TestUsualCopyWithImpl<$Res> implements _$TestUsualCopyWith<$Res> {
  __$TestUsualCopyWithImpl(this._self, this._then);

  final _TestUsual _self;
  final $Res Function(_TestUsual) _then;

  /// Create a copy of TestUsual
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? isSelected = null,
    Object? content = freezed,
  }) {
    return _then(_TestUsual(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      isSelected: null == isSelected
          ? _self.isSelected
          : isSelected // ignore: cast_nullable_to_non_nullable
              as bool,
      content: freezed == content
          ? _self.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
