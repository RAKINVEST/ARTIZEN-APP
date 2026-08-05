// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'orchestration_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

OrchestrationInstance _$OrchestrationInstanceFromJson(
  Map<String, dynamic> json,
) {
  return _OrchestrationInstance.fromJson(json);
}

/// @nodoc
mixin _$OrchestrationInstance {
  String get id => throw _privateConstructorUsedError;
  String get companyId => throw _privateConstructorUsedError;
  String get correlationId => throw _privateConstructorUsedError;
  String get planKind => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  bool get isTerminal => throw _privateConstructorUsedError;
  Map<String, dynamic> get context => throw _privateConstructorUsedError;
  List<dynamic> get plan => throw _privateConstructorUsedError;
  List<dynamic> get timeline => throw _privateConstructorUsedError;
  Map<String, dynamic> get results => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this OrchestrationInstance to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OrchestrationInstance
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OrchestrationInstanceCopyWith<OrchestrationInstance> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrchestrationInstanceCopyWith<$Res> {
  factory $OrchestrationInstanceCopyWith(
    OrchestrationInstance value,
    $Res Function(OrchestrationInstance) then,
  ) = _$OrchestrationInstanceCopyWithImpl<$Res, OrchestrationInstance>;
  @useResult
  $Res call({
    String id,
    String companyId,
    String correlationId,
    String planKind,
    String status,
    bool isTerminal,
    Map<String, dynamic> context,
    List<dynamic> plan,
    List<dynamic> timeline,
    Map<String, dynamic> results,
    DateTime createdAt,
    DateTime updatedAt,
  });
}

/// @nodoc
class _$OrchestrationInstanceCopyWithImpl<
  $Res,
  $Val extends OrchestrationInstance
>
    implements $OrchestrationInstanceCopyWith<$Res> {
  _$OrchestrationInstanceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OrchestrationInstance
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? companyId = null,
    Object? correlationId = null,
    Object? planKind = null,
    Object? status = null,
    Object? isTerminal = null,
    Object? context = null,
    Object? plan = null,
    Object? timeline = null,
    Object? results = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            companyId: null == companyId
                ? _value.companyId
                : companyId // ignore: cast_nullable_to_non_nullable
                      as String,
            correlationId: null == correlationId
                ? _value.correlationId
                : correlationId // ignore: cast_nullable_to_non_nullable
                      as String,
            planKind: null == planKind
                ? _value.planKind
                : planKind // ignore: cast_nullable_to_non_nullable
                      as String,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            isTerminal: null == isTerminal
                ? _value.isTerminal
                : isTerminal // ignore: cast_nullable_to_non_nullable
                      as bool,
            context: null == context
                ? _value.context
                : context // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>,
            plan: null == plan
                ? _value.plan
                : plan // ignore: cast_nullable_to_non_nullable
                      as List<dynamic>,
            timeline: null == timeline
                ? _value.timeline
                : timeline // ignore: cast_nullable_to_non_nullable
                      as List<dynamic>,
            results: null == results
                ? _value.results
                : results // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            updatedAt: null == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$OrchestrationInstanceImplCopyWith<$Res>
    implements $OrchestrationInstanceCopyWith<$Res> {
  factory _$$OrchestrationInstanceImplCopyWith(
    _$OrchestrationInstanceImpl value,
    $Res Function(_$OrchestrationInstanceImpl) then,
  ) = __$$OrchestrationInstanceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String companyId,
    String correlationId,
    String planKind,
    String status,
    bool isTerminal,
    Map<String, dynamic> context,
    List<dynamic> plan,
    List<dynamic> timeline,
    Map<String, dynamic> results,
    DateTime createdAt,
    DateTime updatedAt,
  });
}

/// @nodoc
class __$$OrchestrationInstanceImplCopyWithImpl<$Res>
    extends
        _$OrchestrationInstanceCopyWithImpl<$Res, _$OrchestrationInstanceImpl>
    implements _$$OrchestrationInstanceImplCopyWith<$Res> {
  __$$OrchestrationInstanceImplCopyWithImpl(
    _$OrchestrationInstanceImpl _value,
    $Res Function(_$OrchestrationInstanceImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OrchestrationInstance
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? companyId = null,
    Object? correlationId = null,
    Object? planKind = null,
    Object? status = null,
    Object? isTerminal = null,
    Object? context = null,
    Object? plan = null,
    Object? timeline = null,
    Object? results = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _$OrchestrationInstanceImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        companyId: null == companyId
            ? _value.companyId
            : companyId // ignore: cast_nullable_to_non_nullable
                  as String,
        correlationId: null == correlationId
            ? _value.correlationId
            : correlationId // ignore: cast_nullable_to_non_nullable
                  as String,
        planKind: null == planKind
            ? _value.planKind
            : planKind // ignore: cast_nullable_to_non_nullable
                  as String,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        isTerminal: null == isTerminal
            ? _value.isTerminal
            : isTerminal // ignore: cast_nullable_to_non_nullable
                  as bool,
        context: null == context
            ? _value._context
            : context // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>,
        plan: null == plan
            ? _value._plan
            : plan // ignore: cast_nullable_to_non_nullable
                  as List<dynamic>,
        timeline: null == timeline
            ? _value._timeline
            : timeline // ignore: cast_nullable_to_non_nullable
                  as List<dynamic>,
        results: null == results
            ? _value._results
            : results // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        updatedAt: null == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$OrchestrationInstanceImpl implements _OrchestrationInstance {
  const _$OrchestrationInstanceImpl({
    required this.id,
    required this.companyId,
    required this.correlationId,
    required this.planKind,
    required this.status,
    required this.isTerminal,
    final Map<String, dynamic> context = const <String, dynamic>{},
    final List<dynamic> plan = const <dynamic>[],
    final List<dynamic> timeline = const <dynamic>[],
    final Map<String, dynamic> results = const <String, dynamic>{},
    required this.createdAt,
    required this.updatedAt,
  }) : _context = context,
       _plan = plan,
       _timeline = timeline,
       _results = results;

  factory _$OrchestrationInstanceImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrchestrationInstanceImplFromJson(json);

  @override
  final String id;
  @override
  final String companyId;
  @override
  final String correlationId;
  @override
  final String planKind;
  @override
  final String status;
  @override
  final bool isTerminal;
  final Map<String, dynamic> _context;
  @override
  @JsonKey()
  Map<String, dynamic> get context {
    if (_context is EqualUnmodifiableMapView) return _context;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_context);
  }

  final List<dynamic> _plan;
  @override
  @JsonKey()
  List<dynamic> get plan {
    if (_plan is EqualUnmodifiableListView) return _plan;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_plan);
  }

  final List<dynamic> _timeline;
  @override
  @JsonKey()
  List<dynamic> get timeline {
    if (_timeline is EqualUnmodifiableListView) return _timeline;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_timeline);
  }

  final Map<String, dynamic> _results;
  @override
  @JsonKey()
  Map<String, dynamic> get results {
    if (_results is EqualUnmodifiableMapView) return _results;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_results);
  }

  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'OrchestrationInstance(id: $id, companyId: $companyId, correlationId: $correlationId, planKind: $planKind, status: $status, isTerminal: $isTerminal, context: $context, plan: $plan, timeline: $timeline, results: $results, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrchestrationInstanceImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.companyId, companyId) ||
                other.companyId == companyId) &&
            (identical(other.correlationId, correlationId) ||
                other.correlationId == correlationId) &&
            (identical(other.planKind, planKind) ||
                other.planKind == planKind) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.isTerminal, isTerminal) ||
                other.isTerminal == isTerminal) &&
            const DeepCollectionEquality().equals(other._context, _context) &&
            const DeepCollectionEquality().equals(other._plan, _plan) &&
            const DeepCollectionEquality().equals(other._timeline, _timeline) &&
            const DeepCollectionEquality().equals(other._results, _results) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    companyId,
    correlationId,
    planKind,
    status,
    isTerminal,
    const DeepCollectionEquality().hash(_context),
    const DeepCollectionEquality().hash(_plan),
    const DeepCollectionEquality().hash(_timeline),
    const DeepCollectionEquality().hash(_results),
    createdAt,
    updatedAt,
  );

  /// Create a copy of OrchestrationInstance
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrchestrationInstanceImplCopyWith<_$OrchestrationInstanceImpl>
  get copyWith =>
      __$$OrchestrationInstanceImplCopyWithImpl<_$OrchestrationInstanceImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$OrchestrationInstanceImplToJson(this);
  }
}

abstract class _OrchestrationInstance implements OrchestrationInstance {
  const factory _OrchestrationInstance({
    required final String id,
    required final String companyId,
    required final String correlationId,
    required final String planKind,
    required final String status,
    required final bool isTerminal,
    final Map<String, dynamic> context,
    final List<dynamic> plan,
    final List<dynamic> timeline,
    final Map<String, dynamic> results,
    required final DateTime createdAt,
    required final DateTime updatedAt,
  }) = _$OrchestrationInstanceImpl;

  factory _OrchestrationInstance.fromJson(Map<String, dynamic> json) =
      _$OrchestrationInstanceImpl.fromJson;

  @override
  String get id;
  @override
  String get companyId;
  @override
  String get correlationId;
  @override
  String get planKind;
  @override
  String get status;
  @override
  bool get isTerminal;
  @override
  Map<String, dynamic> get context;
  @override
  List<dynamic> get plan;
  @override
  List<dynamic> get timeline;
  @override
  Map<String, dynamic> get results;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;

  /// Create a copy of OrchestrationInstance
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrchestrationInstanceImplCopyWith<_$OrchestrationInstanceImpl>
  get copyWith => throw _privateConstructorUsedError;
}
