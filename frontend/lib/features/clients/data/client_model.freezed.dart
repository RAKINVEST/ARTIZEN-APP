// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'client_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Client _$ClientFromJson(Map<String, dynamic> json) {
  return _Client.fromJson(json);
}

/// @nodoc
mixin _$Client {
  String get id => throw _privateConstructorUsedError;
  String get companyId => throw _privateConstructorUsedError;
  String get lastName => throw _privateConstructorUsedError;
  String? get firstName => throw _privateConstructorUsedError;
  String? get companyName => throw _privateConstructorUsedError;
  String? get address => throw _privateConstructorUsedError;
  String? get phone => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this Client to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Client
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ClientCopyWith<Client> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClientCopyWith<$Res> {
  factory $ClientCopyWith(Client value, $Res Function(Client) then) =
      _$ClientCopyWithImpl<$Res, Client>;
  @useResult
  $Res call({
    String id,
    String companyId,
    String lastName,
    String? firstName,
    String? companyName,
    String? address,
    String? phone,
    String? email,
    String? notes,
    DateTime createdAt,
    DateTime updatedAt,
  });
}

/// @nodoc
class _$ClientCopyWithImpl<$Res, $Val extends Client>
    implements $ClientCopyWith<$Res> {
  _$ClientCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Client
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? companyId = null,
    Object? lastName = null,
    Object? firstName = freezed,
    Object? companyName = freezed,
    Object? address = freezed,
    Object? phone = freezed,
    Object? email = freezed,
    Object? notes = freezed,
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
            lastName: null == lastName
                ? _value.lastName
                : lastName // ignore: cast_nullable_to_non_nullable
                      as String,
            firstName: freezed == firstName
                ? _value.firstName
                : firstName // ignore: cast_nullable_to_non_nullable
                      as String?,
            companyName: freezed == companyName
                ? _value.companyName
                : companyName // ignore: cast_nullable_to_non_nullable
                      as String?,
            address: freezed == address
                ? _value.address
                : address // ignore: cast_nullable_to_non_nullable
                      as String?,
            phone: freezed == phone
                ? _value.phone
                : phone // ignore: cast_nullable_to_non_nullable
                      as String?,
            email: freezed == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                      as String?,
            notes: freezed == notes
                ? _value.notes
                : notes // ignore: cast_nullable_to_non_nullable
                      as String?,
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
abstract class _$$ClientImplCopyWith<$Res> implements $ClientCopyWith<$Res> {
  factory _$$ClientImplCopyWith(
    _$ClientImpl value,
    $Res Function(_$ClientImpl) then,
  ) = __$$ClientImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String companyId,
    String lastName,
    String? firstName,
    String? companyName,
    String? address,
    String? phone,
    String? email,
    String? notes,
    DateTime createdAt,
    DateTime updatedAt,
  });
}

/// @nodoc
class __$$ClientImplCopyWithImpl<$Res>
    extends _$ClientCopyWithImpl<$Res, _$ClientImpl>
    implements _$$ClientImplCopyWith<$Res> {
  __$$ClientImplCopyWithImpl(
    _$ClientImpl _value,
    $Res Function(_$ClientImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Client
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? companyId = null,
    Object? lastName = null,
    Object? firstName = freezed,
    Object? companyName = freezed,
    Object? address = freezed,
    Object? phone = freezed,
    Object? email = freezed,
    Object? notes = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _$ClientImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        companyId: null == companyId
            ? _value.companyId
            : companyId // ignore: cast_nullable_to_non_nullable
                  as String,
        lastName: null == lastName
            ? _value.lastName
            : lastName // ignore: cast_nullable_to_non_nullable
                  as String,
        firstName: freezed == firstName
            ? _value.firstName
            : firstName // ignore: cast_nullable_to_non_nullable
                  as String?,
        companyName: freezed == companyName
            ? _value.companyName
            : companyName // ignore: cast_nullable_to_non_nullable
                  as String?,
        address: freezed == address
            ? _value.address
            : address // ignore: cast_nullable_to_non_nullable
                  as String?,
        phone: freezed == phone
            ? _value.phone
            : phone // ignore: cast_nullable_to_non_nullable
                  as String?,
        email: freezed == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String?,
        notes: freezed == notes
            ? _value.notes
            : notes // ignore: cast_nullable_to_non_nullable
                  as String?,
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
class _$ClientImpl extends _Client {
  const _$ClientImpl({
    required this.id,
    required this.companyId,
    required this.lastName,
    this.firstName,
    this.companyName,
    this.address,
    this.phone,
    this.email,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  }) : super._();

  factory _$ClientImpl.fromJson(Map<String, dynamic> json) =>
      _$$ClientImplFromJson(json);

  @override
  final String id;
  @override
  final String companyId;
  @override
  final String lastName;
  @override
  final String? firstName;
  @override
  final String? companyName;
  @override
  final String? address;
  @override
  final String? phone;
  @override
  final String? email;
  @override
  final String? notes;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'Client(id: $id, companyId: $companyId, lastName: $lastName, firstName: $firstName, companyName: $companyName, address: $address, phone: $phone, email: $email, notes: $notes, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClientImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.companyId, companyId) ||
                other.companyId == companyId) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.companyName, companyName) ||
                other.companyName == companyName) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.notes, notes) || other.notes == notes) &&
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
    lastName,
    firstName,
    companyName,
    address,
    phone,
    email,
    notes,
    createdAt,
    updatedAt,
  );

  /// Create a copy of Client
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ClientImplCopyWith<_$ClientImpl> get copyWith =>
      __$$ClientImplCopyWithImpl<_$ClientImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ClientImplToJson(this);
  }
}

abstract class _Client extends Client {
  const factory _Client({
    required final String id,
    required final String companyId,
    required final String lastName,
    final String? firstName,
    final String? companyName,
    final String? address,
    final String? phone,
    final String? email,
    final String? notes,
    required final DateTime createdAt,
    required final DateTime updatedAt,
  }) = _$ClientImpl;
  const _Client._() : super._();

  factory _Client.fromJson(Map<String, dynamic> json) = _$ClientImpl.fromJson;

  @override
  String get id;
  @override
  String get companyId;
  @override
  String get lastName;
  @override
  String? get firstName;
  @override
  String? get companyName;
  @override
  String? get address;
  @override
  String? get phone;
  @override
  String? get email;
  @override
  String? get notes;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;

  /// Create a copy of Client
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ClientImplCopyWith<_$ClientImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ClientInput _$ClientInputFromJson(Map<String, dynamic> json) {
  return _ClientInput.fromJson(json);
}

/// @nodoc
mixin _$ClientInput {
  String get lastName => throw _privateConstructorUsedError;
  String? get firstName => throw _privateConstructorUsedError;
  String? get companyName => throw _privateConstructorUsedError;
  String? get address => throw _privateConstructorUsedError;
  String? get phone => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;

  /// Serializes this ClientInput to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ClientInput
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ClientInputCopyWith<ClientInput> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClientInputCopyWith<$Res> {
  factory $ClientInputCopyWith(
    ClientInput value,
    $Res Function(ClientInput) then,
  ) = _$ClientInputCopyWithImpl<$Res, ClientInput>;
  @useResult
  $Res call({
    String lastName,
    String? firstName,
    String? companyName,
    String? address,
    String? phone,
    String? email,
    String? notes,
  });
}

/// @nodoc
class _$ClientInputCopyWithImpl<$Res, $Val extends ClientInput>
    implements $ClientInputCopyWith<$Res> {
  _$ClientInputCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ClientInput
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lastName = null,
    Object? firstName = freezed,
    Object? companyName = freezed,
    Object? address = freezed,
    Object? phone = freezed,
    Object? email = freezed,
    Object? notes = freezed,
  }) {
    return _then(
      _value.copyWith(
            lastName: null == lastName
                ? _value.lastName
                : lastName // ignore: cast_nullable_to_non_nullable
                      as String,
            firstName: freezed == firstName
                ? _value.firstName
                : firstName // ignore: cast_nullable_to_non_nullable
                      as String?,
            companyName: freezed == companyName
                ? _value.companyName
                : companyName // ignore: cast_nullable_to_non_nullable
                      as String?,
            address: freezed == address
                ? _value.address
                : address // ignore: cast_nullable_to_non_nullable
                      as String?,
            phone: freezed == phone
                ? _value.phone
                : phone // ignore: cast_nullable_to_non_nullable
                      as String?,
            email: freezed == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                      as String?,
            notes: freezed == notes
                ? _value.notes
                : notes // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ClientInputImplCopyWith<$Res>
    implements $ClientInputCopyWith<$Res> {
  factory _$$ClientInputImplCopyWith(
    _$ClientInputImpl value,
    $Res Function(_$ClientInputImpl) then,
  ) = __$$ClientInputImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String lastName,
    String? firstName,
    String? companyName,
    String? address,
    String? phone,
    String? email,
    String? notes,
  });
}

/// @nodoc
class __$$ClientInputImplCopyWithImpl<$Res>
    extends _$ClientInputCopyWithImpl<$Res, _$ClientInputImpl>
    implements _$$ClientInputImplCopyWith<$Res> {
  __$$ClientInputImplCopyWithImpl(
    _$ClientInputImpl _value,
    $Res Function(_$ClientInputImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ClientInput
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lastName = null,
    Object? firstName = freezed,
    Object? companyName = freezed,
    Object? address = freezed,
    Object? phone = freezed,
    Object? email = freezed,
    Object? notes = freezed,
  }) {
    return _then(
      _$ClientInputImpl(
        lastName: null == lastName
            ? _value.lastName
            : lastName // ignore: cast_nullable_to_non_nullable
                  as String,
        firstName: freezed == firstName
            ? _value.firstName
            : firstName // ignore: cast_nullable_to_non_nullable
                  as String?,
        companyName: freezed == companyName
            ? _value.companyName
            : companyName // ignore: cast_nullable_to_non_nullable
                  as String?,
        address: freezed == address
            ? _value.address
            : address // ignore: cast_nullable_to_non_nullable
                  as String?,
        phone: freezed == phone
            ? _value.phone
            : phone // ignore: cast_nullable_to_non_nullable
                  as String?,
        email: freezed == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String?,
        notes: freezed == notes
            ? _value.notes
            : notes // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ClientInputImpl implements _ClientInput {
  const _$ClientInputImpl({
    required this.lastName,
    this.firstName,
    this.companyName,
    this.address,
    this.phone,
    this.email,
    this.notes,
  });

  factory _$ClientInputImpl.fromJson(Map<String, dynamic> json) =>
      _$$ClientInputImplFromJson(json);

  @override
  final String lastName;
  @override
  final String? firstName;
  @override
  final String? companyName;
  @override
  final String? address;
  @override
  final String? phone;
  @override
  final String? email;
  @override
  final String? notes;

  @override
  String toString() {
    return 'ClientInput(lastName: $lastName, firstName: $firstName, companyName: $companyName, address: $address, phone: $phone, email: $email, notes: $notes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClientInputImpl &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.companyName, companyName) ||
                other.companyName == companyName) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.notes, notes) || other.notes == notes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    lastName,
    firstName,
    companyName,
    address,
    phone,
    email,
    notes,
  );

  /// Create a copy of ClientInput
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ClientInputImplCopyWith<_$ClientInputImpl> get copyWith =>
      __$$ClientInputImplCopyWithImpl<_$ClientInputImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ClientInputImplToJson(this);
  }
}

abstract class _ClientInput implements ClientInput {
  const factory _ClientInput({
    required final String lastName,
    final String? firstName,
    final String? companyName,
    final String? address,
    final String? phone,
    final String? email,
    final String? notes,
  }) = _$ClientInputImpl;

  factory _ClientInput.fromJson(Map<String, dynamic> json) =
      _$ClientInputImpl.fromJson;

  @override
  String get lastName;
  @override
  String? get firstName;
  @override
  String? get companyName;
  @override
  String? get address;
  @override
  String? get phone;
  @override
  String? get email;
  @override
  String? get notes;

  /// Create a copy of ClientInput
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ClientInputImplCopyWith<_$ClientInputImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
