// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'quote_readiness.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ReadinessIssue _$ReadinessIssueFromJson(Map<String, dynamic> json) {
  return _ReadinessIssue.fromJson(json);
}

/// @nodoc
mixin _$ReadinessIssue {
  String get code => throw _privateConstructorUsedError;
  String get label => throw _privateConstructorUsedError;
  @JsonKey(unknownEnumValue: ReadinessTarget.unknown)
  ReadinessTarget get target => throw _privateConstructorUsedError;
  String? get field => throw _privateConstructorUsedError;

  /// Serializes this ReadinessIssue to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ReadinessIssue
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReadinessIssueCopyWith<ReadinessIssue> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReadinessIssueCopyWith<$Res> {
  factory $ReadinessIssueCopyWith(
    ReadinessIssue value,
    $Res Function(ReadinessIssue) then,
  ) = _$ReadinessIssueCopyWithImpl<$Res, ReadinessIssue>;
  @useResult
  $Res call({
    String code,
    String label,
    @JsonKey(unknownEnumValue: ReadinessTarget.unknown) ReadinessTarget target,
    String? field,
  });
}

/// @nodoc
class _$ReadinessIssueCopyWithImpl<$Res, $Val extends ReadinessIssue>
    implements $ReadinessIssueCopyWith<$Res> {
  _$ReadinessIssueCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ReadinessIssue
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? label = null,
    Object? target = null,
    Object? field = freezed,
  }) {
    return _then(
      _value.copyWith(
            code: null == code
                ? _value.code
                : code // ignore: cast_nullable_to_non_nullable
                      as String,
            label: null == label
                ? _value.label
                : label // ignore: cast_nullable_to_non_nullable
                      as String,
            target: null == target
                ? _value.target
                : target // ignore: cast_nullable_to_non_nullable
                      as ReadinessTarget,
            field: freezed == field
                ? _value.field
                : field // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ReadinessIssueImplCopyWith<$Res>
    implements $ReadinessIssueCopyWith<$Res> {
  factory _$$ReadinessIssueImplCopyWith(
    _$ReadinessIssueImpl value,
    $Res Function(_$ReadinessIssueImpl) then,
  ) = __$$ReadinessIssueImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String code,
    String label,
    @JsonKey(unknownEnumValue: ReadinessTarget.unknown) ReadinessTarget target,
    String? field,
  });
}

/// @nodoc
class __$$ReadinessIssueImplCopyWithImpl<$Res>
    extends _$ReadinessIssueCopyWithImpl<$Res, _$ReadinessIssueImpl>
    implements _$$ReadinessIssueImplCopyWith<$Res> {
  __$$ReadinessIssueImplCopyWithImpl(
    _$ReadinessIssueImpl _value,
    $Res Function(_$ReadinessIssueImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ReadinessIssue
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? label = null,
    Object? target = null,
    Object? field = freezed,
  }) {
    return _then(
      _$ReadinessIssueImpl(
        code: null == code
            ? _value.code
            : code // ignore: cast_nullable_to_non_nullable
                  as String,
        label: null == label
            ? _value.label
            : label // ignore: cast_nullable_to_non_nullable
                  as String,
        target: null == target
            ? _value.target
            : target // ignore: cast_nullable_to_non_nullable
                  as ReadinessTarget,
        field: freezed == field
            ? _value.field
            : field // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ReadinessIssueImpl implements _ReadinessIssue {
  const _$ReadinessIssueImpl({
    required this.code,
    required this.label,
    @JsonKey(unknownEnumValue: ReadinessTarget.unknown) required this.target,
    this.field,
  });

  factory _$ReadinessIssueImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReadinessIssueImplFromJson(json);

  @override
  final String code;
  @override
  final String label;
  @override
  @JsonKey(unknownEnumValue: ReadinessTarget.unknown)
  final ReadinessTarget target;
  @override
  final String? field;

  @override
  String toString() {
    return 'ReadinessIssue(code: $code, label: $label, target: $target, field: $field)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReadinessIssueImpl &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.target, target) || other.target == target) &&
            (identical(other.field, field) || other.field == field));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, code, label, target, field);

  /// Create a copy of ReadinessIssue
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReadinessIssueImplCopyWith<_$ReadinessIssueImpl> get copyWith =>
      __$$ReadinessIssueImplCopyWithImpl<_$ReadinessIssueImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ReadinessIssueImplToJson(this);
  }
}

abstract class _ReadinessIssue implements ReadinessIssue {
  const factory _ReadinessIssue({
    required final String code,
    required final String label,
    @JsonKey(unknownEnumValue: ReadinessTarget.unknown)
    required final ReadinessTarget target,
    final String? field,
  }) = _$ReadinessIssueImpl;

  factory _ReadinessIssue.fromJson(Map<String, dynamic> json) =
      _$ReadinessIssueImpl.fromJson;

  @override
  String get code;
  @override
  String get label;
  @override
  @JsonKey(unknownEnumValue: ReadinessTarget.unknown)
  ReadinessTarget get target;
  @override
  String? get field;

  /// Create a copy of ReadinessIssue
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReadinessIssueImplCopyWith<_$ReadinessIssueImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

QuoteReadiness _$QuoteReadinessFromJson(Map<String, dynamic> json) {
  return _QuoteReadiness.fromJson(json);
}

/// @nodoc
mixin _$QuoteReadiness {
  bool get ready => throw _privateConstructorUsedError;
  List<ReadinessIssue> get issues => throw _privateConstructorUsedError;

  /// Serializes this QuoteReadiness to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of QuoteReadiness
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QuoteReadinessCopyWith<QuoteReadiness> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuoteReadinessCopyWith<$Res> {
  factory $QuoteReadinessCopyWith(
    QuoteReadiness value,
    $Res Function(QuoteReadiness) then,
  ) = _$QuoteReadinessCopyWithImpl<$Res, QuoteReadiness>;
  @useResult
  $Res call({bool ready, List<ReadinessIssue> issues});
}

/// @nodoc
class _$QuoteReadinessCopyWithImpl<$Res, $Val extends QuoteReadiness>
    implements $QuoteReadinessCopyWith<$Res> {
  _$QuoteReadinessCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of QuoteReadiness
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? ready = null, Object? issues = null}) {
    return _then(
      _value.copyWith(
            ready: null == ready
                ? _value.ready
                : ready // ignore: cast_nullable_to_non_nullable
                      as bool,
            issues: null == issues
                ? _value.issues
                : issues // ignore: cast_nullable_to_non_nullable
                      as List<ReadinessIssue>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$QuoteReadinessImplCopyWith<$Res>
    implements $QuoteReadinessCopyWith<$Res> {
  factory _$$QuoteReadinessImplCopyWith(
    _$QuoteReadinessImpl value,
    $Res Function(_$QuoteReadinessImpl) then,
  ) = __$$QuoteReadinessImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool ready, List<ReadinessIssue> issues});
}

/// @nodoc
class __$$QuoteReadinessImplCopyWithImpl<$Res>
    extends _$QuoteReadinessCopyWithImpl<$Res, _$QuoteReadinessImpl>
    implements _$$QuoteReadinessImplCopyWith<$Res> {
  __$$QuoteReadinessImplCopyWithImpl(
    _$QuoteReadinessImpl _value,
    $Res Function(_$QuoteReadinessImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of QuoteReadiness
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? ready = null, Object? issues = null}) {
    return _then(
      _$QuoteReadinessImpl(
        ready: null == ready
            ? _value.ready
            : ready // ignore: cast_nullable_to_non_nullable
                  as bool,
        issues: null == issues
            ? _value._issues
            : issues // ignore: cast_nullable_to_non_nullable
                  as List<ReadinessIssue>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$QuoteReadinessImpl implements _QuoteReadiness {
  const _$QuoteReadinessImpl({
    required this.ready,
    final List<ReadinessIssue> issues = const <ReadinessIssue>[],
  }) : _issues = issues;

  factory _$QuoteReadinessImpl.fromJson(Map<String, dynamic> json) =>
      _$$QuoteReadinessImplFromJson(json);

  @override
  final bool ready;
  final List<ReadinessIssue> _issues;
  @override
  @JsonKey()
  List<ReadinessIssue> get issues {
    if (_issues is EqualUnmodifiableListView) return _issues;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_issues);
  }

  @override
  String toString() {
    return 'QuoteReadiness(ready: $ready, issues: $issues)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuoteReadinessImpl &&
            (identical(other.ready, ready) || other.ready == ready) &&
            const DeepCollectionEquality().equals(other._issues, _issues));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    ready,
    const DeepCollectionEquality().hash(_issues),
  );

  /// Create a copy of QuoteReadiness
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QuoteReadinessImplCopyWith<_$QuoteReadinessImpl> get copyWith =>
      __$$QuoteReadinessImplCopyWithImpl<_$QuoteReadinessImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$QuoteReadinessImplToJson(this);
  }
}

abstract class _QuoteReadiness implements QuoteReadiness {
  const factory _QuoteReadiness({
    required final bool ready,
    final List<ReadinessIssue> issues,
  }) = _$QuoteReadinessImpl;

  factory _QuoteReadiness.fromJson(Map<String, dynamic> json) =
      _$QuoteReadinessImpl.fromJson;

  @override
  bool get ready;
  @override
  List<ReadinessIssue> get issues;

  /// Create a copy of QuoteReadiness
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QuoteReadinessImplCopyWith<_$QuoteReadinessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
