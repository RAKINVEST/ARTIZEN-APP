// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'site_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Site _$SiteFromJson(Map<String, dynamic> json) {
  return _Site.fromJson(json);
}

/// @nodoc
mixin _$Site {
  String get id => throw _privateConstructorUsedError;
  String get companyId => throw _privateConstructorUsedError;
  String get customerId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get address => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this Site to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Site
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SiteCopyWith<Site> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SiteCopyWith<$Res> {
  factory $SiteCopyWith(Site value, $Res Function(Site) then) =
      _$SiteCopyWithImpl<$Res, Site>;
  @useResult
  $Res call({
    String id,
    String companyId,
    String customerId,
    String name,
    String? address,
    String status,
    DateTime createdAt,
    DateTime updatedAt,
  });
}

/// @nodoc
class _$SiteCopyWithImpl<$Res, $Val extends Site>
    implements $SiteCopyWith<$Res> {
  _$SiteCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Site
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? companyId = null,
    Object? customerId = null,
    Object? name = null,
    Object? address = freezed,
    Object? status = null,
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
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            address: freezed == address
                ? _value.address
                : address // ignore: cast_nullable_to_non_nullable
                      as String?,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
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
abstract class _$$SiteImplCopyWith<$Res> implements $SiteCopyWith<$Res> {
  factory _$$SiteImplCopyWith(
    _$SiteImpl value,
    $Res Function(_$SiteImpl) then,
  ) = __$$SiteImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String companyId,
    String customerId,
    String name,
    String? address,
    String status,
    DateTime createdAt,
    DateTime updatedAt,
  });
}

/// @nodoc
class __$$SiteImplCopyWithImpl<$Res>
    extends _$SiteCopyWithImpl<$Res, _$SiteImpl>
    implements _$$SiteImplCopyWith<$Res> {
  __$$SiteImplCopyWithImpl(_$SiteImpl _value, $Res Function(_$SiteImpl) _then)
    : super(_value, _then);

  /// Create a copy of Site
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? companyId = null,
    Object? customerId = null,
    Object? name = null,
    Object? address = freezed,
    Object? status = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _$SiteImpl(
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
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        address: freezed == address
            ? _value.address
            : address // ignore: cast_nullable_to_non_nullable
                  as String?,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
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
class _$SiteImpl extends _Site {
  const _$SiteImpl({
    required this.id,
    required this.companyId,
    required this.customerId,
    required this.name,
    this.address,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  }) : super._();

  factory _$SiteImpl.fromJson(Map<String, dynamic> json) =>
      _$$SiteImplFromJson(json);

  @override
  final String id;
  @override
  final String companyId;
  @override
  final String customerId;
  @override
  final String name;
  @override
  final String? address;
  @override
  final String status;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'Site(id: $id, companyId: $companyId, customerId: $customerId, name: $name, address: $address, status: $status, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SiteImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.companyId, companyId) ||
                other.companyId == companyId) &&
            (identical(other.customerId, customerId) ||
                other.customerId == customerId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.status, status) || other.status == status) &&
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
    name,
    address,
    status,
    createdAt,
    updatedAt,
  );

  /// Create a copy of Site
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SiteImplCopyWith<_$SiteImpl> get copyWith =>
      __$$SiteImplCopyWithImpl<_$SiteImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SiteImplToJson(this);
  }
}

abstract class _Site extends Site {
  const factory _Site({
    required final String id,
    required final String companyId,
    required final String customerId,
    required final String name,
    final String? address,
    required final String status,
    required final DateTime createdAt,
    required final DateTime updatedAt,
  }) = _$SiteImpl;
  const _Site._() : super._();

  factory _Site.fromJson(Map<String, dynamic> json) = _$SiteImpl.fromJson;

  @override
  String get id;
  @override
  String get companyId;
  @override
  String get customerId;
  @override
  String get name;
  @override
  String? get address;
  @override
  String get status;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;

  /// Create a copy of Site
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SiteImplCopyWith<_$SiteImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SiteCreateInput _$SiteCreateInputFromJson(Map<String, dynamic> json) {
  return _SiteCreateInput.fromJson(json);
}

/// @nodoc
mixin _$SiteCreateInput {
  String get customerId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  @JsonKey(includeIfNull: true)
  String? get address => throw _privateConstructorUsedError;

  /// Serializes this SiteCreateInput to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SiteCreateInput
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SiteCreateInputCopyWith<SiteCreateInput> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SiteCreateInputCopyWith<$Res> {
  factory $SiteCreateInputCopyWith(
    SiteCreateInput value,
    $Res Function(SiteCreateInput) then,
  ) = _$SiteCreateInputCopyWithImpl<$Res, SiteCreateInput>;
  @useResult
  $Res call({
    String customerId,
    String name,
    @JsonKey(includeIfNull: true) String? address,
  });
}

/// @nodoc
class _$SiteCreateInputCopyWithImpl<$Res, $Val extends SiteCreateInput>
    implements $SiteCreateInputCopyWith<$Res> {
  _$SiteCreateInputCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SiteCreateInput
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? customerId = null,
    Object? name = null,
    Object? address = freezed,
  }) {
    return _then(
      _value.copyWith(
            customerId: null == customerId
                ? _value.customerId
                : customerId // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            address: freezed == address
                ? _value.address
                : address // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SiteCreateInputImplCopyWith<$Res>
    implements $SiteCreateInputCopyWith<$Res> {
  factory _$$SiteCreateInputImplCopyWith(
    _$SiteCreateInputImpl value,
    $Res Function(_$SiteCreateInputImpl) then,
  ) = __$$SiteCreateInputImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String customerId,
    String name,
    @JsonKey(includeIfNull: true) String? address,
  });
}

/// @nodoc
class __$$SiteCreateInputImplCopyWithImpl<$Res>
    extends _$SiteCreateInputCopyWithImpl<$Res, _$SiteCreateInputImpl>
    implements _$$SiteCreateInputImplCopyWith<$Res> {
  __$$SiteCreateInputImplCopyWithImpl(
    _$SiteCreateInputImpl _value,
    $Res Function(_$SiteCreateInputImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SiteCreateInput
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? customerId = null,
    Object? name = null,
    Object? address = freezed,
  }) {
    return _then(
      _$SiteCreateInputImpl(
        customerId: null == customerId
            ? _value.customerId
            : customerId // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        address: freezed == address
            ? _value.address
            : address // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SiteCreateInputImpl implements _SiteCreateInput {
  const _$SiteCreateInputImpl({
    required this.customerId,
    required this.name,
    @JsonKey(includeIfNull: true) this.address,
  });

  factory _$SiteCreateInputImpl.fromJson(Map<String, dynamic> json) =>
      _$$SiteCreateInputImplFromJson(json);

  @override
  final String customerId;
  @override
  final String name;
  @override
  @JsonKey(includeIfNull: true)
  final String? address;

  @override
  String toString() {
    return 'SiteCreateInput(customerId: $customerId, name: $name, address: $address)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SiteCreateInputImpl &&
            (identical(other.customerId, customerId) ||
                other.customerId == customerId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.address, address) || other.address == address));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, customerId, name, address);

  /// Create a copy of SiteCreateInput
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SiteCreateInputImplCopyWith<_$SiteCreateInputImpl> get copyWith =>
      __$$SiteCreateInputImplCopyWithImpl<_$SiteCreateInputImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$SiteCreateInputImplToJson(this);
  }
}

abstract class _SiteCreateInput implements SiteCreateInput {
  const factory _SiteCreateInput({
    required final String customerId,
    required final String name,
    @JsonKey(includeIfNull: true) final String? address,
  }) = _$SiteCreateInputImpl;

  factory _SiteCreateInput.fromJson(Map<String, dynamic> json) =
      _$SiteCreateInputImpl.fromJson;

  @override
  String get customerId;
  @override
  String get name;
  @override
  @JsonKey(includeIfNull: true)
  String? get address;

  /// Create a copy of SiteCreateInput
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SiteCreateInputImplCopyWith<_$SiteCreateInputImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SiteUpdateInput _$SiteUpdateInputFromJson(Map<String, dynamic> json) {
  return _SiteUpdateInput.fromJson(json);
}

/// @nodoc
mixin _$SiteUpdateInput {
  @JsonKey(includeIfNull: true)
  String? get name => throw _privateConstructorUsedError;
  @JsonKey(includeIfNull: true)
  String? get address => throw _privateConstructorUsedError;

  /// Serializes this SiteUpdateInput to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SiteUpdateInput
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SiteUpdateInputCopyWith<SiteUpdateInput> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SiteUpdateInputCopyWith<$Res> {
  factory $SiteUpdateInputCopyWith(
    SiteUpdateInput value,
    $Res Function(SiteUpdateInput) then,
  ) = _$SiteUpdateInputCopyWithImpl<$Res, SiteUpdateInput>;
  @useResult
  $Res call({
    @JsonKey(includeIfNull: true) String? name,
    @JsonKey(includeIfNull: true) String? address,
  });
}

/// @nodoc
class _$SiteUpdateInputCopyWithImpl<$Res, $Val extends SiteUpdateInput>
    implements $SiteUpdateInputCopyWith<$Res> {
  _$SiteUpdateInputCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SiteUpdateInput
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? name = freezed, Object? address = freezed}) {
    return _then(
      _value.copyWith(
            name: freezed == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String?,
            address: freezed == address
                ? _value.address
                : address // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SiteUpdateInputImplCopyWith<$Res>
    implements $SiteUpdateInputCopyWith<$Res> {
  factory _$$SiteUpdateInputImplCopyWith(
    _$SiteUpdateInputImpl value,
    $Res Function(_$SiteUpdateInputImpl) then,
  ) = __$$SiteUpdateInputImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(includeIfNull: true) String? name,
    @JsonKey(includeIfNull: true) String? address,
  });
}

/// @nodoc
class __$$SiteUpdateInputImplCopyWithImpl<$Res>
    extends _$SiteUpdateInputCopyWithImpl<$Res, _$SiteUpdateInputImpl>
    implements _$$SiteUpdateInputImplCopyWith<$Res> {
  __$$SiteUpdateInputImplCopyWithImpl(
    _$SiteUpdateInputImpl _value,
    $Res Function(_$SiteUpdateInputImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SiteUpdateInput
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? name = freezed, Object? address = freezed}) {
    return _then(
      _$SiteUpdateInputImpl(
        name: freezed == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String?,
        address: freezed == address
            ? _value.address
            : address // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SiteUpdateInputImpl implements _SiteUpdateInput {
  const _$SiteUpdateInputImpl({
    @JsonKey(includeIfNull: true) this.name,
    @JsonKey(includeIfNull: true) this.address,
  });

  factory _$SiteUpdateInputImpl.fromJson(Map<String, dynamic> json) =>
      _$$SiteUpdateInputImplFromJson(json);

  @override
  @JsonKey(includeIfNull: true)
  final String? name;
  @override
  @JsonKey(includeIfNull: true)
  final String? address;

  @override
  String toString() {
    return 'SiteUpdateInput(name: $name, address: $address)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SiteUpdateInputImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.address, address) || other.address == address));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, address);

  /// Create a copy of SiteUpdateInput
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SiteUpdateInputImplCopyWith<_$SiteUpdateInputImpl> get copyWith =>
      __$$SiteUpdateInputImplCopyWithImpl<_$SiteUpdateInputImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$SiteUpdateInputImplToJson(this);
  }
}

abstract class _SiteUpdateInput implements SiteUpdateInput {
  const factory _SiteUpdateInput({
    @JsonKey(includeIfNull: true) final String? name,
    @JsonKey(includeIfNull: true) final String? address,
  }) = _$SiteUpdateInputImpl;

  factory _SiteUpdateInput.fromJson(Map<String, dynamic> json) =
      _$SiteUpdateInputImpl.fromJson;

  @override
  @JsonKey(includeIfNull: true)
  String? get name;
  @override
  @JsonKey(includeIfNull: true)
  String? get address;

  /// Create a copy of SiteUpdateInput
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SiteUpdateInputImplCopyWith<_$SiteUpdateInputImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
