// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mission_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Mission _$MissionFromJson(Map<String, dynamic> json) {
  return _Mission.fromJson(json);
}

/// @nodoc
mixin _$Mission {
  String get id => throw _privateConstructorUsedError;
  String get companyId => throw _privateConstructorUsedError;
  String get customerId => throw _privateConstructorUsedError;
  String? get siteId => throw _privateConstructorUsedError;
  String? get workflowInstanceId => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  int get progress => throw _privateConstructorUsedError;
  bool get isTerminal => throw _privateConstructorUsedError;
  List<dynamic> get attachments => throw _privateConstructorUsedError;
  List<dynamic> get timeline => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this Mission to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Mission
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MissionCopyWith<Mission> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MissionCopyWith<$Res> {
  factory $MissionCopyWith(Mission value, $Res Function(Mission) then) =
      _$MissionCopyWithImpl<$Res, Mission>;
  @useResult
  $Res call({
    String id,
    String companyId,
    String customerId,
    String? siteId,
    String? workflowInstanceId,
    String title,
    String status,
    int progress,
    bool isTerminal,
    List<dynamic> attachments,
    List<dynamic> timeline,
    DateTime createdAt,
    DateTime updatedAt,
  });
}

/// @nodoc
class _$MissionCopyWithImpl<$Res, $Val extends Mission>
    implements $MissionCopyWith<$Res> {
  _$MissionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Mission
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? companyId = null,
    Object? customerId = null,
    Object? siteId = freezed,
    Object? workflowInstanceId = freezed,
    Object? title = null,
    Object? status = null,
    Object? progress = null,
    Object? isTerminal = null,
    Object? attachments = null,
    Object? timeline = null,
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
            customerId: null == customerId
                ? _value.customerId
                : customerId // ignore: cast_nullable_to_non_nullable
                      as String,
            siteId: freezed == siteId
                ? _value.siteId
                : siteId // ignore: cast_nullable_to_non_nullable
                      as String?,
            workflowInstanceId: freezed == workflowInstanceId
                ? _value.workflowInstanceId
                : workflowInstanceId // ignore: cast_nullable_to_non_nullable
                      as String?,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            progress: null == progress
                ? _value.progress
                : progress // ignore: cast_nullable_to_non_nullable
                      as int,
            isTerminal: null == isTerminal
                ? _value.isTerminal
                : isTerminal // ignore: cast_nullable_to_non_nullable
                      as bool,
            attachments: null == attachments
                ? _value.attachments
                : attachments // ignore: cast_nullable_to_non_nullable
                      as List<dynamic>,
            timeline: null == timeline
                ? _value.timeline
                : timeline // ignore: cast_nullable_to_non_nullable
                      as List<dynamic>,
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
abstract class _$$MissionImplCopyWith<$Res> implements $MissionCopyWith<$Res> {
  factory _$$MissionImplCopyWith(
    _$MissionImpl value,
    $Res Function(_$MissionImpl) then,
  ) = __$$MissionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String companyId,
    String customerId,
    String? siteId,
    String? workflowInstanceId,
    String title,
    String status,
    int progress,
    bool isTerminal,
    List<dynamic> attachments,
    List<dynamic> timeline,
    DateTime createdAt,
    DateTime updatedAt,
  });
}

/// @nodoc
class __$$MissionImplCopyWithImpl<$Res>
    extends _$MissionCopyWithImpl<$Res, _$MissionImpl>
    implements _$$MissionImplCopyWith<$Res> {
  __$$MissionImplCopyWithImpl(
    _$MissionImpl _value,
    $Res Function(_$MissionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Mission
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? companyId = null,
    Object? customerId = null,
    Object? siteId = freezed,
    Object? workflowInstanceId = freezed,
    Object? title = null,
    Object? status = null,
    Object? progress = null,
    Object? isTerminal = null,
    Object? attachments = null,
    Object? timeline = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _$MissionImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        companyId: null == companyId
            ? _value.companyId
            : companyId // ignore: cast_nullable_to_non_nullable
                  as String,
        customerId: null == customerId
            ? _value.customerId
            : customerId // ignore: cast_nullable_to_non_nullable
                  as String,
        siteId: freezed == siteId
            ? _value.siteId
            : siteId // ignore: cast_nullable_to_non_nullable
                  as String?,
        workflowInstanceId: freezed == workflowInstanceId
            ? _value.workflowInstanceId
            : workflowInstanceId // ignore: cast_nullable_to_non_nullable
                  as String?,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        progress: null == progress
            ? _value.progress
            : progress // ignore: cast_nullable_to_non_nullable
                  as int,
        isTerminal: null == isTerminal
            ? _value.isTerminal
            : isTerminal // ignore: cast_nullable_to_non_nullable
                  as bool,
        attachments: null == attachments
            ? _value._attachments
            : attachments // ignore: cast_nullable_to_non_nullable
                  as List<dynamic>,
        timeline: null == timeline
            ? _value._timeline
            : timeline // ignore: cast_nullable_to_non_nullable
                  as List<dynamic>,
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
class _$MissionImpl implements _Mission {
  const _$MissionImpl({
    required this.id,
    required this.companyId,
    required this.customerId,
    this.siteId,
    this.workflowInstanceId,
    required this.title,
    required this.status,
    required this.progress,
    required this.isTerminal,
    final List<dynamic> attachments = const <dynamic>[],
    final List<dynamic> timeline = const <dynamic>[],
    required this.createdAt,
    required this.updatedAt,
  }) : _attachments = attachments,
       _timeline = timeline;

  factory _$MissionImpl.fromJson(Map<String, dynamic> json) =>
      _$$MissionImplFromJson(json);

  @override
  final String id;
  @override
  final String companyId;
  @override
  final String customerId;
  @override
  final String? siteId;
  @override
  final String? workflowInstanceId;
  @override
  final String title;
  @override
  final String status;
  @override
  final int progress;
  @override
  final bool isTerminal;
  final List<dynamic> _attachments;
  @override
  @JsonKey()
  List<dynamic> get attachments {
    if (_attachments is EqualUnmodifiableListView) return _attachments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_attachments);
  }

  final List<dynamic> _timeline;
  @override
  @JsonKey()
  List<dynamic> get timeline {
    if (_timeline is EqualUnmodifiableListView) return _timeline;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_timeline);
  }

  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'Mission(id: $id, companyId: $companyId, customerId: $customerId, siteId: $siteId, workflowInstanceId: $workflowInstanceId, title: $title, status: $status, progress: $progress, isTerminal: $isTerminal, attachments: $attachments, timeline: $timeline, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MissionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.companyId, companyId) ||
                other.companyId == companyId) &&
            (identical(other.customerId, customerId) ||
                other.customerId == customerId) &&
            (identical(other.siteId, siteId) || other.siteId == siteId) &&
            (identical(other.workflowInstanceId, workflowInstanceId) ||
                other.workflowInstanceId == workflowInstanceId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.progress, progress) ||
                other.progress == progress) &&
            (identical(other.isTerminal, isTerminal) ||
                other.isTerminal == isTerminal) &&
            const DeepCollectionEquality().equals(
              other._attachments,
              _attachments,
            ) &&
            const DeepCollectionEquality().equals(other._timeline, _timeline) &&
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
    customerId,
    siteId,
    workflowInstanceId,
    title,
    status,
    progress,
    isTerminal,
    const DeepCollectionEquality().hash(_attachments),
    const DeepCollectionEquality().hash(_timeline),
    createdAt,
    updatedAt,
  );

  /// Create a copy of Mission
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MissionImplCopyWith<_$MissionImpl> get copyWith =>
      __$$MissionImplCopyWithImpl<_$MissionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MissionImplToJson(this);
  }
}

abstract class _Mission implements Mission {
  const factory _Mission({
    required final String id,
    required final String companyId,
    required final String customerId,
    final String? siteId,
    final String? workflowInstanceId,
    required final String title,
    required final String status,
    required final int progress,
    required final bool isTerminal,
    final List<dynamic> attachments,
    final List<dynamic> timeline,
    required final DateTime createdAt,
    required final DateTime updatedAt,
  }) = _$MissionImpl;

  factory _Mission.fromJson(Map<String, dynamic> json) = _$MissionImpl.fromJson;

  @override
  String get id;
  @override
  String get companyId;
  @override
  String get customerId;
  @override
  String? get siteId;
  @override
  String? get workflowInstanceId;
  @override
  String get title;
  @override
  String get status;
  @override
  int get progress;
  @override
  bool get isTerminal;
  @override
  List<dynamic> get attachments;
  @override
  List<dynamic> get timeline;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;

  /// Create a copy of Mission
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MissionImplCopyWith<_$MissionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
