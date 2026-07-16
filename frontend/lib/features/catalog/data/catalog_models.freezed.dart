// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'catalog_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

CatalogCategory _$CatalogCategoryFromJson(Map<String, dynamic> json) {
  return _CatalogCategory.fromJson(json);
}

/// @nodoc
mixin _$CatalogCategory {
  String get id => throw _privateConstructorUsedError;
  String get companyId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this CatalogCategory to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CatalogCategory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CatalogCategoryCopyWith<CatalogCategory> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CatalogCategoryCopyWith<$Res> {
  factory $CatalogCategoryCopyWith(
    CatalogCategory value,
    $Res Function(CatalogCategory) then,
  ) = _$CatalogCategoryCopyWithImpl<$Res, CatalogCategory>;
  @useResult
  $Res call({
    String id,
    String companyId,
    String name,
    String? description,
    DateTime createdAt,
    DateTime updatedAt,
  });
}

/// @nodoc
class _$CatalogCategoryCopyWithImpl<$Res, $Val extends CatalogCategory>
    implements $CatalogCategoryCopyWith<$Res> {
  _$CatalogCategoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CatalogCategory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? companyId = null,
    Object? name = null,
    Object? description = freezed,
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
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
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
abstract class _$$CatalogCategoryImplCopyWith<$Res>
    implements $CatalogCategoryCopyWith<$Res> {
  factory _$$CatalogCategoryImplCopyWith(
    _$CatalogCategoryImpl value,
    $Res Function(_$CatalogCategoryImpl) then,
  ) = __$$CatalogCategoryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String companyId,
    String name,
    String? description,
    DateTime createdAt,
    DateTime updatedAt,
  });
}

/// @nodoc
class __$$CatalogCategoryImplCopyWithImpl<$Res>
    extends _$CatalogCategoryCopyWithImpl<$Res, _$CatalogCategoryImpl>
    implements _$$CatalogCategoryImplCopyWith<$Res> {
  __$$CatalogCategoryImplCopyWithImpl(
    _$CatalogCategoryImpl _value,
    $Res Function(_$CatalogCategoryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CatalogCategory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? companyId = null,
    Object? name = null,
    Object? description = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _$CatalogCategoryImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        companyId: null == companyId
            ? _value.companyId
            : companyId // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
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
class _$CatalogCategoryImpl implements _CatalogCategory {
  const _$CatalogCategoryImpl({
    required this.id,
    required this.companyId,
    required this.name,
    this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  factory _$CatalogCategoryImpl.fromJson(Map<String, dynamic> json) =>
      _$$CatalogCategoryImplFromJson(json);

  @override
  final String id;
  @override
  final String companyId;
  @override
  final String name;
  @override
  final String? description;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'CatalogCategory(id: $id, companyId: $companyId, name: $name, description: $description, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CatalogCategoryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.companyId, companyId) ||
                other.companyId == companyId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
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
    name,
    description,
    createdAt,
    updatedAt,
  );

  /// Create a copy of CatalogCategory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CatalogCategoryImplCopyWith<_$CatalogCategoryImpl> get copyWith =>
      __$$CatalogCategoryImplCopyWithImpl<_$CatalogCategoryImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CatalogCategoryImplToJson(this);
  }
}

abstract class _CatalogCategory implements CatalogCategory {
  const factory _CatalogCategory({
    required final String id,
    required final String companyId,
    required final String name,
    final String? description,
    required final DateTime createdAt,
    required final DateTime updatedAt,
  }) = _$CatalogCategoryImpl;

  factory _CatalogCategory.fromJson(Map<String, dynamic> json) =
      _$CatalogCategoryImpl.fromJson;

  @override
  String get id;
  @override
  String get companyId;
  @override
  String get name;
  @override
  String? get description;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;

  /// Create a copy of CatalogCategory
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CatalogCategoryImplCopyWith<_$CatalogCategoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CatalogCategoryInput _$CatalogCategoryInputFromJson(Map<String, dynamic> json) {
  return _CatalogCategoryInput.fromJson(json);
}

/// @nodoc
mixin _$CatalogCategoryInput {
  String get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;

  /// Serializes this CatalogCategoryInput to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CatalogCategoryInput
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CatalogCategoryInputCopyWith<CatalogCategoryInput> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CatalogCategoryInputCopyWith<$Res> {
  factory $CatalogCategoryInputCopyWith(
    CatalogCategoryInput value,
    $Res Function(CatalogCategoryInput) then,
  ) = _$CatalogCategoryInputCopyWithImpl<$Res, CatalogCategoryInput>;
  @useResult
  $Res call({String name, String? description});
}

/// @nodoc
class _$CatalogCategoryInputCopyWithImpl<
  $Res,
  $Val extends CatalogCategoryInput
>
    implements $CatalogCategoryInputCopyWith<$Res> {
  _$CatalogCategoryInputCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CatalogCategoryInput
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? name = null, Object? description = freezed}) {
    return _then(
      _value.copyWith(
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CatalogCategoryInputImplCopyWith<$Res>
    implements $CatalogCategoryInputCopyWith<$Res> {
  factory _$$CatalogCategoryInputImplCopyWith(
    _$CatalogCategoryInputImpl value,
    $Res Function(_$CatalogCategoryInputImpl) then,
  ) = __$$CatalogCategoryInputImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String? description});
}

/// @nodoc
class __$$CatalogCategoryInputImplCopyWithImpl<$Res>
    extends _$CatalogCategoryInputCopyWithImpl<$Res, _$CatalogCategoryInputImpl>
    implements _$$CatalogCategoryInputImplCopyWith<$Res> {
  __$$CatalogCategoryInputImplCopyWithImpl(
    _$CatalogCategoryInputImpl _value,
    $Res Function(_$CatalogCategoryInputImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CatalogCategoryInput
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? name = null, Object? description = freezed}) {
    return _then(
      _$CatalogCategoryInputImpl(
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CatalogCategoryInputImpl implements _CatalogCategoryInput {
  const _$CatalogCategoryInputImpl({required this.name, this.description});

  factory _$CatalogCategoryInputImpl.fromJson(Map<String, dynamic> json) =>
      _$$CatalogCategoryInputImplFromJson(json);

  @override
  final String name;
  @override
  final String? description;

  @override
  String toString() {
    return 'CatalogCategoryInput(name: $name, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CatalogCategoryInputImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, description);

  /// Create a copy of CatalogCategoryInput
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CatalogCategoryInputImplCopyWith<_$CatalogCategoryInputImpl>
  get copyWith =>
      __$$CatalogCategoryInputImplCopyWithImpl<_$CatalogCategoryInputImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CatalogCategoryInputImplToJson(this);
  }
}

abstract class _CatalogCategoryInput implements CatalogCategoryInput {
  const factory _CatalogCategoryInput({
    required final String name,
    final String? description,
  }) = _$CatalogCategoryInputImpl;

  factory _CatalogCategoryInput.fromJson(Map<String, dynamic> json) =
      _$CatalogCategoryInputImpl.fromJson;

  @override
  String get name;
  @override
  String? get description;

  /// Create a copy of CatalogCategoryInput
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CatalogCategoryInputImplCopyWith<_$CatalogCategoryInputImpl>
  get copyWith => throw _privateConstructorUsedError;
}

CatalogItem _$CatalogItemFromJson(Map<String, dynamic> json) {
  return _CatalogItem.fromJson(json);
}

/// @nodoc
mixin _$CatalogItem {
  String get id => throw _privateConstructorUsedError;
  String get companyId => throw _privateConstructorUsedError;
  String get categoryId => throw _privateConstructorUsedError;
  String? get code => throw _privateConstructorUsedError;
  String get designation => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  ItemType get itemType => throw _privateConstructorUsedError;
  String get unit => throw _privateConstructorUsedError;
  String get unitPriceHt => throw _privateConstructorUsedError;
  String get vatRate => throw _privateConstructorUsedError;
  int? get estimatedDurationMinutes => throw _privateConstructorUsedError;
  bool get active => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this CatalogItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CatalogItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CatalogItemCopyWith<CatalogItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CatalogItemCopyWith<$Res> {
  factory $CatalogItemCopyWith(
    CatalogItem value,
    $Res Function(CatalogItem) then,
  ) = _$CatalogItemCopyWithImpl<$Res, CatalogItem>;
  @useResult
  $Res call({
    String id,
    String companyId,
    String categoryId,
    String? code,
    String designation,
    String? description,
    ItemType itemType,
    String unit,
    String unitPriceHt,
    String vatRate,
    int? estimatedDurationMinutes,
    bool active,
    DateTime createdAt,
    DateTime updatedAt,
  });
}

/// @nodoc
class _$CatalogItemCopyWithImpl<$Res, $Val extends CatalogItem>
    implements $CatalogItemCopyWith<$Res> {
  _$CatalogItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CatalogItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? companyId = null,
    Object? categoryId = null,
    Object? code = freezed,
    Object? designation = null,
    Object? description = freezed,
    Object? itemType = null,
    Object? unit = null,
    Object? unitPriceHt = null,
    Object? vatRate = null,
    Object? estimatedDurationMinutes = freezed,
    Object? active = null,
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
            categoryId: null == categoryId
                ? _value.categoryId
                : categoryId // ignore: cast_nullable_to_non_nullable
                      as String,
            code: freezed == code
                ? _value.code
                : code // ignore: cast_nullable_to_non_nullable
                      as String?,
            designation: null == designation
                ? _value.designation
                : designation // ignore: cast_nullable_to_non_nullable
                      as String,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            itemType: null == itemType
                ? _value.itemType
                : itemType // ignore: cast_nullable_to_non_nullable
                      as ItemType,
            unit: null == unit
                ? _value.unit
                : unit // ignore: cast_nullable_to_non_nullable
                      as String,
            unitPriceHt: null == unitPriceHt
                ? _value.unitPriceHt
                : unitPriceHt // ignore: cast_nullable_to_non_nullable
                      as String,
            vatRate: null == vatRate
                ? _value.vatRate
                : vatRate // ignore: cast_nullable_to_non_nullable
                      as String,
            estimatedDurationMinutes: freezed == estimatedDurationMinutes
                ? _value.estimatedDurationMinutes
                : estimatedDurationMinutes // ignore: cast_nullable_to_non_nullable
                      as int?,
            active: null == active
                ? _value.active
                : active // ignore: cast_nullable_to_non_nullable
                      as bool,
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
abstract class _$$CatalogItemImplCopyWith<$Res>
    implements $CatalogItemCopyWith<$Res> {
  factory _$$CatalogItemImplCopyWith(
    _$CatalogItemImpl value,
    $Res Function(_$CatalogItemImpl) then,
  ) = __$$CatalogItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String companyId,
    String categoryId,
    String? code,
    String designation,
    String? description,
    ItemType itemType,
    String unit,
    String unitPriceHt,
    String vatRate,
    int? estimatedDurationMinutes,
    bool active,
    DateTime createdAt,
    DateTime updatedAt,
  });
}

/// @nodoc
class __$$CatalogItemImplCopyWithImpl<$Res>
    extends _$CatalogItemCopyWithImpl<$Res, _$CatalogItemImpl>
    implements _$$CatalogItemImplCopyWith<$Res> {
  __$$CatalogItemImplCopyWithImpl(
    _$CatalogItemImpl _value,
    $Res Function(_$CatalogItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CatalogItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? companyId = null,
    Object? categoryId = null,
    Object? code = freezed,
    Object? designation = null,
    Object? description = freezed,
    Object? itemType = null,
    Object? unit = null,
    Object? unitPriceHt = null,
    Object? vatRate = null,
    Object? estimatedDurationMinutes = freezed,
    Object? active = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _$CatalogItemImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        companyId: null == companyId
            ? _value.companyId
            : companyId // ignore: cast_nullable_to_non_nullable
                  as String,
        categoryId: null == categoryId
            ? _value.categoryId
            : categoryId // ignore: cast_nullable_to_non_nullable
                  as String,
        code: freezed == code
            ? _value.code
            : code // ignore: cast_nullable_to_non_nullable
                  as String?,
        designation: null == designation
            ? _value.designation
            : designation // ignore: cast_nullable_to_non_nullable
                  as String,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        itemType: null == itemType
            ? _value.itemType
            : itemType // ignore: cast_nullable_to_non_nullable
                  as ItemType,
        unit: null == unit
            ? _value.unit
            : unit // ignore: cast_nullable_to_non_nullable
                  as String,
        unitPriceHt: null == unitPriceHt
            ? _value.unitPriceHt
            : unitPriceHt // ignore: cast_nullable_to_non_nullable
                  as String,
        vatRate: null == vatRate
            ? _value.vatRate
            : vatRate // ignore: cast_nullable_to_non_nullable
                  as String,
        estimatedDurationMinutes: freezed == estimatedDurationMinutes
            ? _value.estimatedDurationMinutes
            : estimatedDurationMinutes // ignore: cast_nullable_to_non_nullable
                  as int?,
        active: null == active
            ? _value.active
            : active // ignore: cast_nullable_to_non_nullable
                  as bool,
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
class _$CatalogItemImpl implements _CatalogItem {
  const _$CatalogItemImpl({
    required this.id,
    required this.companyId,
    required this.categoryId,
    this.code,
    required this.designation,
    this.description,
    required this.itemType,
    required this.unit,
    required this.unitPriceHt,
    required this.vatRate,
    this.estimatedDurationMinutes,
    required this.active,
    required this.createdAt,
    required this.updatedAt,
  });

  factory _$CatalogItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$CatalogItemImplFromJson(json);

  @override
  final String id;
  @override
  final String companyId;
  @override
  final String categoryId;
  @override
  final String? code;
  @override
  final String designation;
  @override
  final String? description;
  @override
  final ItemType itemType;
  @override
  final String unit;
  @override
  final String unitPriceHt;
  @override
  final String vatRate;
  @override
  final int? estimatedDurationMinutes;
  @override
  final bool active;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'CatalogItem(id: $id, companyId: $companyId, categoryId: $categoryId, code: $code, designation: $designation, description: $description, itemType: $itemType, unit: $unit, unitPriceHt: $unitPriceHt, vatRate: $vatRate, estimatedDurationMinutes: $estimatedDurationMinutes, active: $active, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CatalogItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.companyId, companyId) ||
                other.companyId == companyId) &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.designation, designation) ||
                other.designation == designation) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.itemType, itemType) ||
                other.itemType == itemType) &&
            (identical(other.unit, unit) || other.unit == unit) &&
            (identical(other.unitPriceHt, unitPriceHt) ||
                other.unitPriceHt == unitPriceHt) &&
            (identical(other.vatRate, vatRate) || other.vatRate == vatRate) &&
            (identical(
                  other.estimatedDurationMinutes,
                  estimatedDurationMinutes,
                ) ||
                other.estimatedDurationMinutes == estimatedDurationMinutes) &&
            (identical(other.active, active) || other.active == active) &&
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
    categoryId,
    code,
    designation,
    description,
    itemType,
    unit,
    unitPriceHt,
    vatRate,
    estimatedDurationMinutes,
    active,
    createdAt,
    updatedAt,
  );

  /// Create a copy of CatalogItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CatalogItemImplCopyWith<_$CatalogItemImpl> get copyWith =>
      __$$CatalogItemImplCopyWithImpl<_$CatalogItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CatalogItemImplToJson(this);
  }
}

abstract class _CatalogItem implements CatalogItem {
  const factory _CatalogItem({
    required final String id,
    required final String companyId,
    required final String categoryId,
    final String? code,
    required final String designation,
    final String? description,
    required final ItemType itemType,
    required final String unit,
    required final String unitPriceHt,
    required final String vatRate,
    final int? estimatedDurationMinutes,
    required final bool active,
    required final DateTime createdAt,
    required final DateTime updatedAt,
  }) = _$CatalogItemImpl;

  factory _CatalogItem.fromJson(Map<String, dynamic> json) =
      _$CatalogItemImpl.fromJson;

  @override
  String get id;
  @override
  String get companyId;
  @override
  String get categoryId;
  @override
  String? get code;
  @override
  String get designation;
  @override
  String? get description;
  @override
  ItemType get itemType;
  @override
  String get unit;
  @override
  String get unitPriceHt;
  @override
  String get vatRate;
  @override
  int? get estimatedDurationMinutes;
  @override
  bool get active;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;

  /// Create a copy of CatalogItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CatalogItemImplCopyWith<_$CatalogItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CatalogItemInput _$CatalogItemInputFromJson(Map<String, dynamic> json) {
  return _CatalogItemInput.fromJson(json);
}

/// @nodoc
mixin _$CatalogItemInput {
  String get categoryId => throw _privateConstructorUsedError;
  String? get code => throw _privateConstructorUsedError;
  String get designation => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  ItemType get itemType => throw _privateConstructorUsedError;
  String get unit => throw _privateConstructorUsedError;
  String get unitPriceHt => throw _privateConstructorUsedError;
  String get vatRate => throw _privateConstructorUsedError;
  int? get estimatedDurationMinutes => throw _privateConstructorUsedError;

  /// Serializes this CatalogItemInput to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CatalogItemInput
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CatalogItemInputCopyWith<CatalogItemInput> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CatalogItemInputCopyWith<$Res> {
  factory $CatalogItemInputCopyWith(
    CatalogItemInput value,
    $Res Function(CatalogItemInput) then,
  ) = _$CatalogItemInputCopyWithImpl<$Res, CatalogItemInput>;
  @useResult
  $Res call({
    String categoryId,
    String? code,
    String designation,
    String? description,
    ItemType itemType,
    String unit,
    String unitPriceHt,
    String vatRate,
    int? estimatedDurationMinutes,
  });
}

/// @nodoc
class _$CatalogItemInputCopyWithImpl<$Res, $Val extends CatalogItemInput>
    implements $CatalogItemInputCopyWith<$Res> {
  _$CatalogItemInputCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CatalogItemInput
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? categoryId = null,
    Object? code = freezed,
    Object? designation = null,
    Object? description = freezed,
    Object? itemType = null,
    Object? unit = null,
    Object? unitPriceHt = null,
    Object? vatRate = null,
    Object? estimatedDurationMinutes = freezed,
  }) {
    return _then(
      _value.copyWith(
            categoryId: null == categoryId
                ? _value.categoryId
                : categoryId // ignore: cast_nullable_to_non_nullable
                      as String,
            code: freezed == code
                ? _value.code
                : code // ignore: cast_nullable_to_non_nullable
                      as String?,
            designation: null == designation
                ? _value.designation
                : designation // ignore: cast_nullable_to_non_nullable
                      as String,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            itemType: null == itemType
                ? _value.itemType
                : itemType // ignore: cast_nullable_to_non_nullable
                      as ItemType,
            unit: null == unit
                ? _value.unit
                : unit // ignore: cast_nullable_to_non_nullable
                      as String,
            unitPriceHt: null == unitPriceHt
                ? _value.unitPriceHt
                : unitPriceHt // ignore: cast_nullable_to_non_nullable
                      as String,
            vatRate: null == vatRate
                ? _value.vatRate
                : vatRate // ignore: cast_nullable_to_non_nullable
                      as String,
            estimatedDurationMinutes: freezed == estimatedDurationMinutes
                ? _value.estimatedDurationMinutes
                : estimatedDurationMinutes // ignore: cast_nullable_to_non_nullable
                      as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CatalogItemInputImplCopyWith<$Res>
    implements $CatalogItemInputCopyWith<$Res> {
  factory _$$CatalogItemInputImplCopyWith(
    _$CatalogItemInputImpl value,
    $Res Function(_$CatalogItemInputImpl) then,
  ) = __$$CatalogItemInputImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String categoryId,
    String? code,
    String designation,
    String? description,
    ItemType itemType,
    String unit,
    String unitPriceHt,
    String vatRate,
    int? estimatedDurationMinutes,
  });
}

/// @nodoc
class __$$CatalogItemInputImplCopyWithImpl<$Res>
    extends _$CatalogItemInputCopyWithImpl<$Res, _$CatalogItemInputImpl>
    implements _$$CatalogItemInputImplCopyWith<$Res> {
  __$$CatalogItemInputImplCopyWithImpl(
    _$CatalogItemInputImpl _value,
    $Res Function(_$CatalogItemInputImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CatalogItemInput
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? categoryId = null,
    Object? code = freezed,
    Object? designation = null,
    Object? description = freezed,
    Object? itemType = null,
    Object? unit = null,
    Object? unitPriceHt = null,
    Object? vatRate = null,
    Object? estimatedDurationMinutes = freezed,
  }) {
    return _then(
      _$CatalogItemInputImpl(
        categoryId: null == categoryId
            ? _value.categoryId
            : categoryId // ignore: cast_nullable_to_non_nullable
                  as String,
        code: freezed == code
            ? _value.code
            : code // ignore: cast_nullable_to_non_nullable
                  as String?,
        designation: null == designation
            ? _value.designation
            : designation // ignore: cast_nullable_to_non_nullable
                  as String,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        itemType: null == itemType
            ? _value.itemType
            : itemType // ignore: cast_nullable_to_non_nullable
                  as ItemType,
        unit: null == unit
            ? _value.unit
            : unit // ignore: cast_nullable_to_non_nullable
                  as String,
        unitPriceHt: null == unitPriceHt
            ? _value.unitPriceHt
            : unitPriceHt // ignore: cast_nullable_to_non_nullable
                  as String,
        vatRate: null == vatRate
            ? _value.vatRate
            : vatRate // ignore: cast_nullable_to_non_nullable
                  as String,
        estimatedDurationMinutes: freezed == estimatedDurationMinutes
            ? _value.estimatedDurationMinutes
            : estimatedDurationMinutes // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CatalogItemInputImpl implements _CatalogItemInput {
  const _$CatalogItemInputImpl({
    required this.categoryId,
    this.code,
    required this.designation,
    this.description,
    required this.itemType,
    required this.unit,
    required this.unitPriceHt,
    required this.vatRate,
    this.estimatedDurationMinutes,
  });

  factory _$CatalogItemInputImpl.fromJson(Map<String, dynamic> json) =>
      _$$CatalogItemInputImplFromJson(json);

  @override
  final String categoryId;
  @override
  final String? code;
  @override
  final String designation;
  @override
  final String? description;
  @override
  final ItemType itemType;
  @override
  final String unit;
  @override
  final String unitPriceHt;
  @override
  final String vatRate;
  @override
  final int? estimatedDurationMinutes;

  @override
  String toString() {
    return 'CatalogItemInput(categoryId: $categoryId, code: $code, designation: $designation, description: $description, itemType: $itemType, unit: $unit, unitPriceHt: $unitPriceHt, vatRate: $vatRate, estimatedDurationMinutes: $estimatedDurationMinutes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CatalogItemInputImpl &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.designation, designation) ||
                other.designation == designation) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.itemType, itemType) ||
                other.itemType == itemType) &&
            (identical(other.unit, unit) || other.unit == unit) &&
            (identical(other.unitPriceHt, unitPriceHt) ||
                other.unitPriceHt == unitPriceHt) &&
            (identical(other.vatRate, vatRate) || other.vatRate == vatRate) &&
            (identical(
                  other.estimatedDurationMinutes,
                  estimatedDurationMinutes,
                ) ||
                other.estimatedDurationMinutes == estimatedDurationMinutes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    categoryId,
    code,
    designation,
    description,
    itemType,
    unit,
    unitPriceHt,
    vatRate,
    estimatedDurationMinutes,
  );

  /// Create a copy of CatalogItemInput
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CatalogItemInputImplCopyWith<_$CatalogItemInputImpl> get copyWith =>
      __$$CatalogItemInputImplCopyWithImpl<_$CatalogItemInputImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CatalogItemInputImplToJson(this);
  }
}

abstract class _CatalogItemInput implements CatalogItemInput {
  const factory _CatalogItemInput({
    required final String categoryId,
    final String? code,
    required final String designation,
    final String? description,
    required final ItemType itemType,
    required final String unit,
    required final String unitPriceHt,
    required final String vatRate,
    final int? estimatedDurationMinutes,
  }) = _$CatalogItemInputImpl;

  factory _CatalogItemInput.fromJson(Map<String, dynamic> json) =
      _$CatalogItemInputImpl.fromJson;

  @override
  String get categoryId;
  @override
  String? get code;
  @override
  String get designation;
  @override
  String? get description;
  @override
  ItemType get itemType;
  @override
  String get unit;
  @override
  String get unitPriceHt;
  @override
  String get vatRate;
  @override
  int? get estimatedDurationMinutes;

  /// Create a copy of CatalogItemInput
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CatalogItemInputImplCopyWith<_$CatalogItemInputImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
