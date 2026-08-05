// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'planning_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

PlanningEntry _$PlanningEntryFromJson(Map<String, dynamic> json) {
  return _PlanningEntry.fromJson(json);
}

/// @nodoc
mixin _$PlanningEntry {
  String get id => throw _privateConstructorUsedError;
  String get companyId => throw _privateConstructorUsedError;
  String? get missionId => throw _privateConstructorUsedError;
  DateTime get startAt => throw _privateConstructorUsedError;
  DateTime get endAt => throw _privateConstructorUsedError;
  int get durationMinutes => throw _privateConstructorUsedError;
  String get artisan => throw _privateConstructorUsedError;
  String get team => throw _privateConstructorUsedError;
  String get vehicle => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  bool get isTerminal => throw _privateConstructorUsedError;
  List<dynamic> get history => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this PlanningEntry to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PlanningEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PlanningEntryCopyWith<PlanningEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlanningEntryCopyWith<$Res> {
  factory $PlanningEntryCopyWith(
    PlanningEntry value,
    $Res Function(PlanningEntry) then,
  ) = _$PlanningEntryCopyWithImpl<$Res, PlanningEntry>;
  @useResult
  $Res call({
    String id,
    String companyId,
    String? missionId,
    DateTime startAt,
    DateTime endAt,
    int durationMinutes,
    String artisan,
    String team,
    String vehicle,
    String status,
    bool isTerminal,
    List<dynamic> history,
    DateTime createdAt,
    DateTime updatedAt,
  });
}

/// @nodoc
class _$PlanningEntryCopyWithImpl<$Res, $Val extends PlanningEntry>
    implements $PlanningEntryCopyWith<$Res> {
  _$PlanningEntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PlanningEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? companyId = null,
    Object? missionId = freezed,
    Object? startAt = null,
    Object? endAt = null,
    Object? durationMinutes = null,
    Object? artisan = null,
    Object? team = null,
    Object? vehicle = null,
    Object? status = null,
    Object? isTerminal = null,
    Object? history = null,
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
            missionId: freezed == missionId
                ? _value.missionId
                : missionId // ignore: cast_nullable_to_non_nullable
                      as String?,
            startAt: null == startAt
                ? _value.startAt
                : startAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            endAt: null == endAt
                ? _value.endAt
                : endAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            durationMinutes: null == durationMinutes
                ? _value.durationMinutes
                : durationMinutes // ignore: cast_nullable_to_non_nullable
                      as int,
            artisan: null == artisan
                ? _value.artisan
                : artisan // ignore: cast_nullable_to_non_nullable
                      as String,
            team: null == team
                ? _value.team
                : team // ignore: cast_nullable_to_non_nullable
                      as String,
            vehicle: null == vehicle
                ? _value.vehicle
                : vehicle // ignore: cast_nullable_to_non_nullable
                      as String,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            isTerminal: null == isTerminal
                ? _value.isTerminal
                : isTerminal // ignore: cast_nullable_to_non_nullable
                      as bool,
            history: null == history
                ? _value.history
                : history // ignore: cast_nullable_to_non_nullable
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
abstract class _$$PlanningEntryImplCopyWith<$Res>
    implements $PlanningEntryCopyWith<$Res> {
  factory _$$PlanningEntryImplCopyWith(
    _$PlanningEntryImpl value,
    $Res Function(_$PlanningEntryImpl) then,
  ) = __$$PlanningEntryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String companyId,
    String? missionId,
    DateTime startAt,
    DateTime endAt,
    int durationMinutes,
    String artisan,
    String team,
    String vehicle,
    String status,
    bool isTerminal,
    List<dynamic> history,
    DateTime createdAt,
    DateTime updatedAt,
  });
}

/// @nodoc
class __$$PlanningEntryImplCopyWithImpl<$Res>
    extends _$PlanningEntryCopyWithImpl<$Res, _$PlanningEntryImpl>
    implements _$$PlanningEntryImplCopyWith<$Res> {
  __$$PlanningEntryImplCopyWithImpl(
    _$PlanningEntryImpl _value,
    $Res Function(_$PlanningEntryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PlanningEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? companyId = null,
    Object? missionId = freezed,
    Object? startAt = null,
    Object? endAt = null,
    Object? durationMinutes = null,
    Object? artisan = null,
    Object? team = null,
    Object? vehicle = null,
    Object? status = null,
    Object? isTerminal = null,
    Object? history = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _$PlanningEntryImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        companyId: null == companyId
            ? _value.companyId
            : companyId // ignore: cast_nullable_to_non_nullable
                  as String,
        missionId: freezed == missionId
            ? _value.missionId
            : missionId // ignore: cast_nullable_to_non_nullable
                  as String?,
        startAt: null == startAt
            ? _value.startAt
            : startAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        endAt: null == endAt
            ? _value.endAt
            : endAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        durationMinutes: null == durationMinutes
            ? _value.durationMinutes
            : durationMinutes // ignore: cast_nullable_to_non_nullable
                  as int,
        artisan: null == artisan
            ? _value.artisan
            : artisan // ignore: cast_nullable_to_non_nullable
                  as String,
        team: null == team
            ? _value.team
            : team // ignore: cast_nullable_to_non_nullable
                  as String,
        vehicle: null == vehicle
            ? _value.vehicle
            : vehicle // ignore: cast_nullable_to_non_nullable
                  as String,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        isTerminal: null == isTerminal
            ? _value.isTerminal
            : isTerminal // ignore: cast_nullable_to_non_nullable
                  as bool,
        history: null == history
            ? _value._history
            : history // ignore: cast_nullable_to_non_nullable
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
class _$PlanningEntryImpl implements _PlanningEntry {
  const _$PlanningEntryImpl({
    required this.id,
    required this.companyId,
    this.missionId,
    required this.startAt,
    required this.endAt,
    required this.durationMinutes,
    this.artisan = '',
    this.team = '',
    this.vehicle = '',
    required this.status,
    required this.isTerminal,
    final List<dynamic> history = const <dynamic>[],
    required this.createdAt,
    required this.updatedAt,
  }) : _history = history;

  factory _$PlanningEntryImpl.fromJson(Map<String, dynamic> json) =>
      _$$PlanningEntryImplFromJson(json);

  @override
  final String id;
  @override
  final String companyId;
  @override
  final String? missionId;
  @override
  final DateTime startAt;
  @override
  final DateTime endAt;
  @override
  final int durationMinutes;
  @override
  @JsonKey()
  final String artisan;
  @override
  @JsonKey()
  final String team;
  @override
  @JsonKey()
  final String vehicle;
  @override
  final String status;
  @override
  final bool isTerminal;
  final List<dynamic> _history;
  @override
  @JsonKey()
  List<dynamic> get history {
    if (_history is EqualUnmodifiableListView) return _history;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_history);
  }

  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'PlanningEntry(id: $id, companyId: $companyId, missionId: $missionId, startAt: $startAt, endAt: $endAt, durationMinutes: $durationMinutes, artisan: $artisan, team: $team, vehicle: $vehicle, status: $status, isTerminal: $isTerminal, history: $history, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlanningEntryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.companyId, companyId) ||
                other.companyId == companyId) &&
            (identical(other.missionId, missionId) ||
                other.missionId == missionId) &&
            (identical(other.startAt, startAt) || other.startAt == startAt) &&
            (identical(other.endAt, endAt) || other.endAt == endAt) &&
            (identical(other.durationMinutes, durationMinutes) ||
                other.durationMinutes == durationMinutes) &&
            (identical(other.artisan, artisan) || other.artisan == artisan) &&
            (identical(other.team, team) || other.team == team) &&
            (identical(other.vehicle, vehicle) || other.vehicle == vehicle) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.isTerminal, isTerminal) ||
                other.isTerminal == isTerminal) &&
            const DeepCollectionEquality().equals(other._history, _history) &&
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
    missionId,
    startAt,
    endAt,
    durationMinutes,
    artisan,
    team,
    vehicle,
    status,
    isTerminal,
    const DeepCollectionEquality().hash(_history),
    createdAt,
    updatedAt,
  );

  /// Create a copy of PlanningEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PlanningEntryImplCopyWith<_$PlanningEntryImpl> get copyWith =>
      __$$PlanningEntryImplCopyWithImpl<_$PlanningEntryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PlanningEntryImplToJson(this);
  }
}

abstract class _PlanningEntry implements PlanningEntry {
  const factory _PlanningEntry({
    required final String id,
    required final String companyId,
    final String? missionId,
    required final DateTime startAt,
    required final DateTime endAt,
    required final int durationMinutes,
    final String artisan,
    final String team,
    final String vehicle,
    required final String status,
    required final bool isTerminal,
    final List<dynamic> history,
    required final DateTime createdAt,
    required final DateTime updatedAt,
  }) = _$PlanningEntryImpl;

  factory _PlanningEntry.fromJson(Map<String, dynamic> json) =
      _$PlanningEntryImpl.fromJson;

  @override
  String get id;
  @override
  String get companyId;
  @override
  String? get missionId;
  @override
  DateTime get startAt;
  @override
  DateTime get endAt;
  @override
  int get durationMinutes;
  @override
  String get artisan;
  @override
  String get team;
  @override
  String get vehicle;
  @override
  String get status;
  @override
  bool get isTerminal;
  @override
  List<dynamic> get history;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;

  /// Create a copy of PlanningEntry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PlanningEntryImplCopyWith<_$PlanningEntryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PlanningConflict _$PlanningConflictFromJson(Map<String, dynamic> json) {
  return _PlanningConflict.fromJson(json);
}

/// @nodoc
mixin _$PlanningConflict {
  String get type => throw _privateConstructorUsedError;
  String get detail => throw _privateConstructorUsedError;
  String get entryId => throw _privateConstructorUsedError;

  /// Serializes this PlanningConflict to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PlanningConflict
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PlanningConflictCopyWith<PlanningConflict> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlanningConflictCopyWith<$Res> {
  factory $PlanningConflictCopyWith(
    PlanningConflict value,
    $Res Function(PlanningConflict) then,
  ) = _$PlanningConflictCopyWithImpl<$Res, PlanningConflict>;
  @useResult
  $Res call({String type, String detail, String entryId});
}

/// @nodoc
class _$PlanningConflictCopyWithImpl<$Res, $Val extends PlanningConflict>
    implements $PlanningConflictCopyWith<$Res> {
  _$PlanningConflictCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PlanningConflict
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? detail = null,
    Object? entryId = null,
  }) {
    return _then(
      _value.copyWith(
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as String,
            detail: null == detail
                ? _value.detail
                : detail // ignore: cast_nullable_to_non_nullable
                      as String,
            entryId: null == entryId
                ? _value.entryId
                : entryId // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PlanningConflictImplCopyWith<$Res>
    implements $PlanningConflictCopyWith<$Res> {
  factory _$$PlanningConflictImplCopyWith(
    _$PlanningConflictImpl value,
    $Res Function(_$PlanningConflictImpl) then,
  ) = __$$PlanningConflictImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String type, String detail, String entryId});
}

/// @nodoc
class __$$PlanningConflictImplCopyWithImpl<$Res>
    extends _$PlanningConflictCopyWithImpl<$Res, _$PlanningConflictImpl>
    implements _$$PlanningConflictImplCopyWith<$Res> {
  __$$PlanningConflictImplCopyWithImpl(
    _$PlanningConflictImpl _value,
    $Res Function(_$PlanningConflictImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PlanningConflict
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? detail = null,
    Object? entryId = null,
  }) {
    return _then(
      _$PlanningConflictImpl(
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String,
        detail: null == detail
            ? _value.detail
            : detail // ignore: cast_nullable_to_non_nullable
                  as String,
        entryId: null == entryId
            ? _value.entryId
            : entryId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PlanningConflictImpl implements _PlanningConflict {
  const _$PlanningConflictImpl({
    required this.type,
    required this.detail,
    this.entryId = '',
  });

  factory _$PlanningConflictImpl.fromJson(Map<String, dynamic> json) =>
      _$$PlanningConflictImplFromJson(json);

  @override
  final String type;
  @override
  final String detail;
  @override
  @JsonKey()
  final String entryId;

  @override
  String toString() {
    return 'PlanningConflict(type: $type, detail: $detail, entryId: $entryId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlanningConflictImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.detail, detail) || other.detail == detail) &&
            (identical(other.entryId, entryId) || other.entryId == entryId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, type, detail, entryId);

  /// Create a copy of PlanningConflict
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PlanningConflictImplCopyWith<_$PlanningConflictImpl> get copyWith =>
      __$$PlanningConflictImplCopyWithImpl<_$PlanningConflictImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PlanningConflictImplToJson(this);
  }
}

abstract class _PlanningConflict implements PlanningConflict {
  const factory _PlanningConflict({
    required final String type,
    required final String detail,
    final String entryId,
  }) = _$PlanningConflictImpl;

  factory _PlanningConflict.fromJson(Map<String, dynamic> json) =
      _$PlanningConflictImpl.fromJson;

  @override
  String get type;
  @override
  String get detail;
  @override
  String get entryId;

  /// Create a copy of PlanningConflict
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PlanningConflictImplCopyWith<_$PlanningConflictImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Availability _$AvailabilityFromJson(Map<String, dynamic> json) {
  return _Availability.fromJson(json);
}

/// @nodoc
mixin _$Availability {
  bool get available => throw _privateConstructorUsedError;
  List<PlanningConflict> get conflicts => throw _privateConstructorUsedError;

  /// Serializes this Availability to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Availability
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AvailabilityCopyWith<Availability> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AvailabilityCopyWith<$Res> {
  factory $AvailabilityCopyWith(
    Availability value,
    $Res Function(Availability) then,
  ) = _$AvailabilityCopyWithImpl<$Res, Availability>;
  @useResult
  $Res call({bool available, List<PlanningConflict> conflicts});
}

/// @nodoc
class _$AvailabilityCopyWithImpl<$Res, $Val extends Availability>
    implements $AvailabilityCopyWith<$Res> {
  _$AvailabilityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Availability
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? available = null, Object? conflicts = null}) {
    return _then(
      _value.copyWith(
            available: null == available
                ? _value.available
                : available // ignore: cast_nullable_to_non_nullable
                      as bool,
            conflicts: null == conflicts
                ? _value.conflicts
                : conflicts // ignore: cast_nullable_to_non_nullable
                      as List<PlanningConflict>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AvailabilityImplCopyWith<$Res>
    implements $AvailabilityCopyWith<$Res> {
  factory _$$AvailabilityImplCopyWith(
    _$AvailabilityImpl value,
    $Res Function(_$AvailabilityImpl) then,
  ) = __$$AvailabilityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool available, List<PlanningConflict> conflicts});
}

/// @nodoc
class __$$AvailabilityImplCopyWithImpl<$Res>
    extends _$AvailabilityCopyWithImpl<$Res, _$AvailabilityImpl>
    implements _$$AvailabilityImplCopyWith<$Res> {
  __$$AvailabilityImplCopyWithImpl(
    _$AvailabilityImpl _value,
    $Res Function(_$AvailabilityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Availability
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? available = null, Object? conflicts = null}) {
    return _then(
      _$AvailabilityImpl(
        available: null == available
            ? _value.available
            : available // ignore: cast_nullable_to_non_nullable
                  as bool,
        conflicts: null == conflicts
            ? _value._conflicts
            : conflicts // ignore: cast_nullable_to_non_nullable
                  as List<PlanningConflict>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AvailabilityImpl implements _Availability {
  const _$AvailabilityImpl({
    required this.available,
    final List<PlanningConflict> conflicts = const <PlanningConflict>[],
  }) : _conflicts = conflicts;

  factory _$AvailabilityImpl.fromJson(Map<String, dynamic> json) =>
      _$$AvailabilityImplFromJson(json);

  @override
  final bool available;
  final List<PlanningConflict> _conflicts;
  @override
  @JsonKey()
  List<PlanningConflict> get conflicts {
    if (_conflicts is EqualUnmodifiableListView) return _conflicts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_conflicts);
  }

  @override
  String toString() {
    return 'Availability(available: $available, conflicts: $conflicts)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AvailabilityImpl &&
            (identical(other.available, available) ||
                other.available == available) &&
            const DeepCollectionEquality().equals(
              other._conflicts,
              _conflicts,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    available,
    const DeepCollectionEquality().hash(_conflicts),
  );

  /// Create a copy of Availability
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AvailabilityImplCopyWith<_$AvailabilityImpl> get copyWith =>
      __$$AvailabilityImplCopyWithImpl<_$AvailabilityImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AvailabilityImplToJson(this);
  }
}

abstract class _Availability implements Availability {
  const factory _Availability({
    required final bool available,
    final List<PlanningConflict> conflicts,
  }) = _$AvailabilityImpl;

  factory _Availability.fromJson(Map<String, dynamic> json) =
      _$AvailabilityImpl.fromJson;

  @override
  bool get available;
  @override
  List<PlanningConflict> get conflicts;

  /// Create a copy of Availability
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AvailabilityImplCopyWith<_$AvailabilityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
