// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'metiers_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

CatalogPackSummary _$CatalogPackSummaryFromJson(Map<String, dynamic> json) {
  return _CatalogPackSummary.fromJson(json);
}

/// @nodoc
mixin _$CatalogPackSummary {
  String get name => throw _privateConstructorUsedError;
  int get itemCount => throw _privateConstructorUsedError;

  /// Serializes this CatalogPackSummary to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CatalogPackSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CatalogPackSummaryCopyWith<CatalogPackSummary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CatalogPackSummaryCopyWith<$Res> {
  factory $CatalogPackSummaryCopyWith(
    CatalogPackSummary value,
    $Res Function(CatalogPackSummary) then,
  ) = _$CatalogPackSummaryCopyWithImpl<$Res, CatalogPackSummary>;
  @useResult
  $Res call({String name, int itemCount});
}

/// @nodoc
class _$CatalogPackSummaryCopyWithImpl<$Res, $Val extends CatalogPackSummary>
    implements $CatalogPackSummaryCopyWith<$Res> {
  _$CatalogPackSummaryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CatalogPackSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? name = null, Object? itemCount = null}) {
    return _then(
      _value.copyWith(
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            itemCount: null == itemCount
                ? _value.itemCount
                : itemCount // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CatalogPackSummaryImplCopyWith<$Res>
    implements $CatalogPackSummaryCopyWith<$Res> {
  factory _$$CatalogPackSummaryImplCopyWith(
    _$CatalogPackSummaryImpl value,
    $Res Function(_$CatalogPackSummaryImpl) then,
  ) = __$$CatalogPackSummaryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, int itemCount});
}

/// @nodoc
class __$$CatalogPackSummaryImplCopyWithImpl<$Res>
    extends _$CatalogPackSummaryCopyWithImpl<$Res, _$CatalogPackSummaryImpl>
    implements _$$CatalogPackSummaryImplCopyWith<$Res> {
  __$$CatalogPackSummaryImplCopyWithImpl(
    _$CatalogPackSummaryImpl _value,
    $Res Function(_$CatalogPackSummaryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CatalogPackSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? name = null, Object? itemCount = null}) {
    return _then(
      _$CatalogPackSummaryImpl(
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        itemCount: null == itemCount
            ? _value.itemCount
            : itemCount // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CatalogPackSummaryImpl implements _CatalogPackSummary {
  const _$CatalogPackSummaryImpl({required this.name, required this.itemCount});

  factory _$CatalogPackSummaryImpl.fromJson(Map<String, dynamic> json) =>
      _$$CatalogPackSummaryImplFromJson(json);

  @override
  final String name;
  @override
  final int itemCount;

  @override
  String toString() {
    return 'CatalogPackSummary(name: $name, itemCount: $itemCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CatalogPackSummaryImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.itemCount, itemCount) ||
                other.itemCount == itemCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, itemCount);

  /// Create a copy of CatalogPackSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CatalogPackSummaryImplCopyWith<_$CatalogPackSummaryImpl> get copyWith =>
      __$$CatalogPackSummaryImplCopyWithImpl<_$CatalogPackSummaryImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CatalogPackSummaryImplToJson(this);
  }
}

abstract class _CatalogPackSummary implements CatalogPackSummary {
  const factory _CatalogPackSummary({
    required final String name,
    required final int itemCount,
  }) = _$CatalogPackSummaryImpl;

  factory _CatalogPackSummary.fromJson(Map<String, dynamic> json) =
      _$CatalogPackSummaryImpl.fromJson;

  @override
  String get name;
  @override
  int get itemCount;

  /// Create a copy of CatalogPackSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CatalogPackSummaryImplCopyWith<_$CatalogPackSummaryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CatalogSource _$CatalogSourceFromJson(Map<String, dynamic> json) {
  return _CatalogSource.fromJson(json);
}

/// @nodoc
mixin _$CatalogSource {
  String get slug => throw _privateConstructorUsedError;
  String get label => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  List<CatalogPackSummary> get packs => throw _privateConstructorUsedError;
  int get itemCount => throw _privateConstructorUsedError;
  int get productCount => throw _privateConstructorUsedError;
  int get prestationCount => throw _privateConstructorUsedError;
  CatalogSourceStatus get status => throw _privateConstructorUsedError;
  int get version => throw _privateConstructorUsedError;
  int? get importedVersion => throw _privateConstructorUsedError;
  DateTime? get importedAt =>
      throw _privateConstructorUsedError; // Only when status == updateAvailable: how many articles the update adds…
  int? get updateItemCount =>
      throw _privateConstructorUsedError; // …and its "Nouveautés" (why to update): "Ajout des PAC R290", etc.
  List<String>? get updateNotes => throw _privateConstructorUsedError;

  /// Serializes this CatalogSource to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CatalogSource
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CatalogSourceCopyWith<CatalogSource> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CatalogSourceCopyWith<$Res> {
  factory $CatalogSourceCopyWith(
    CatalogSource value,
    $Res Function(CatalogSource) then,
  ) = _$CatalogSourceCopyWithImpl<$Res, CatalogSource>;
  @useResult
  $Res call({
    String slug,
    String label,
    String? description,
    List<CatalogPackSummary> packs,
    int itemCount,
    int productCount,
    int prestationCount,
    CatalogSourceStatus status,
    int version,
    int? importedVersion,
    DateTime? importedAt,
    int? updateItemCount,
    List<String>? updateNotes,
  });
}

/// @nodoc
class _$CatalogSourceCopyWithImpl<$Res, $Val extends CatalogSource>
    implements $CatalogSourceCopyWith<$Res> {
  _$CatalogSourceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CatalogSource
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? slug = null,
    Object? label = null,
    Object? description = freezed,
    Object? packs = null,
    Object? itemCount = null,
    Object? productCount = null,
    Object? prestationCount = null,
    Object? status = null,
    Object? version = null,
    Object? importedVersion = freezed,
    Object? importedAt = freezed,
    Object? updateItemCount = freezed,
    Object? updateNotes = freezed,
  }) {
    return _then(
      _value.copyWith(
            slug: null == slug
                ? _value.slug
                : slug // ignore: cast_nullable_to_non_nullable
                      as String,
            label: null == label
                ? _value.label
                : label // ignore: cast_nullable_to_non_nullable
                      as String,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            packs: null == packs
                ? _value.packs
                : packs // ignore: cast_nullable_to_non_nullable
                      as List<CatalogPackSummary>,
            itemCount: null == itemCount
                ? _value.itemCount
                : itemCount // ignore: cast_nullable_to_non_nullable
                      as int,
            productCount: null == productCount
                ? _value.productCount
                : productCount // ignore: cast_nullable_to_non_nullable
                      as int,
            prestationCount: null == prestationCount
                ? _value.prestationCount
                : prestationCount // ignore: cast_nullable_to_non_nullable
                      as int,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as CatalogSourceStatus,
            version: null == version
                ? _value.version
                : version // ignore: cast_nullable_to_non_nullable
                      as int,
            importedVersion: freezed == importedVersion
                ? _value.importedVersion
                : importedVersion // ignore: cast_nullable_to_non_nullable
                      as int?,
            importedAt: freezed == importedAt
                ? _value.importedAt
                : importedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            updateItemCount: freezed == updateItemCount
                ? _value.updateItemCount
                : updateItemCount // ignore: cast_nullable_to_non_nullable
                      as int?,
            updateNotes: freezed == updateNotes
                ? _value.updateNotes
                : updateNotes // ignore: cast_nullable_to_non_nullable
                      as List<String>?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CatalogSourceImplCopyWith<$Res>
    implements $CatalogSourceCopyWith<$Res> {
  factory _$$CatalogSourceImplCopyWith(
    _$CatalogSourceImpl value,
    $Res Function(_$CatalogSourceImpl) then,
  ) = __$$CatalogSourceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String slug,
    String label,
    String? description,
    List<CatalogPackSummary> packs,
    int itemCount,
    int productCount,
    int prestationCount,
    CatalogSourceStatus status,
    int version,
    int? importedVersion,
    DateTime? importedAt,
    int? updateItemCount,
    List<String>? updateNotes,
  });
}

/// @nodoc
class __$$CatalogSourceImplCopyWithImpl<$Res>
    extends _$CatalogSourceCopyWithImpl<$Res, _$CatalogSourceImpl>
    implements _$$CatalogSourceImplCopyWith<$Res> {
  __$$CatalogSourceImplCopyWithImpl(
    _$CatalogSourceImpl _value,
    $Res Function(_$CatalogSourceImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CatalogSource
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? slug = null,
    Object? label = null,
    Object? description = freezed,
    Object? packs = null,
    Object? itemCount = null,
    Object? productCount = null,
    Object? prestationCount = null,
    Object? status = null,
    Object? version = null,
    Object? importedVersion = freezed,
    Object? importedAt = freezed,
    Object? updateItemCount = freezed,
    Object? updateNotes = freezed,
  }) {
    return _then(
      _$CatalogSourceImpl(
        slug: null == slug
            ? _value.slug
            : slug // ignore: cast_nullable_to_non_nullable
                  as String,
        label: null == label
            ? _value.label
            : label // ignore: cast_nullable_to_non_nullable
                  as String,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        packs: null == packs
            ? _value._packs
            : packs // ignore: cast_nullable_to_non_nullable
                  as List<CatalogPackSummary>,
        itemCount: null == itemCount
            ? _value.itemCount
            : itemCount // ignore: cast_nullable_to_non_nullable
                  as int,
        productCount: null == productCount
            ? _value.productCount
            : productCount // ignore: cast_nullable_to_non_nullable
                  as int,
        prestationCount: null == prestationCount
            ? _value.prestationCount
            : prestationCount // ignore: cast_nullable_to_non_nullable
                  as int,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as CatalogSourceStatus,
        version: null == version
            ? _value.version
            : version // ignore: cast_nullable_to_non_nullable
                  as int,
        importedVersion: freezed == importedVersion
            ? _value.importedVersion
            : importedVersion // ignore: cast_nullable_to_non_nullable
                  as int?,
        importedAt: freezed == importedAt
            ? _value.importedAt
            : importedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        updateItemCount: freezed == updateItemCount
            ? _value.updateItemCount
            : updateItemCount // ignore: cast_nullable_to_non_nullable
                  as int?,
        updateNotes: freezed == updateNotes
            ? _value._updateNotes
            : updateNotes // ignore: cast_nullable_to_non_nullable
                  as List<String>?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CatalogSourceImpl extends _CatalogSource {
  const _$CatalogSourceImpl({
    required this.slug,
    required this.label,
    this.description,
    final List<CatalogPackSummary> packs = const <CatalogPackSummary>[],
    required this.itemCount,
    required this.productCount,
    required this.prestationCount,
    required this.status,
    required this.version,
    this.importedVersion,
    this.importedAt,
    this.updateItemCount,
    final List<String>? updateNotes,
  }) : _packs = packs,
       _updateNotes = updateNotes,
       super._();

  factory _$CatalogSourceImpl.fromJson(Map<String, dynamic> json) =>
      _$$CatalogSourceImplFromJson(json);

  @override
  final String slug;
  @override
  final String label;
  @override
  final String? description;
  final List<CatalogPackSummary> _packs;
  @override
  @JsonKey()
  List<CatalogPackSummary> get packs {
    if (_packs is EqualUnmodifiableListView) return _packs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_packs);
  }

  @override
  final int itemCount;
  @override
  final int productCount;
  @override
  final int prestationCount;
  @override
  final CatalogSourceStatus status;
  @override
  final int version;
  @override
  final int? importedVersion;
  @override
  final DateTime? importedAt;
  // Only when status == updateAvailable: how many articles the update adds…
  @override
  final int? updateItemCount;
  // …and its "Nouveautés" (why to update): "Ajout des PAC R290", etc.
  final List<String>? _updateNotes;
  // …and its "Nouveautés" (why to update): "Ajout des PAC R290", etc.
  @override
  List<String>? get updateNotes {
    final value = _updateNotes;
    if (value == null) return null;
    if (_updateNotes is EqualUnmodifiableListView) return _updateNotes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'CatalogSource(slug: $slug, label: $label, description: $description, packs: $packs, itemCount: $itemCount, productCount: $productCount, prestationCount: $prestationCount, status: $status, version: $version, importedVersion: $importedVersion, importedAt: $importedAt, updateItemCount: $updateItemCount, updateNotes: $updateNotes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CatalogSourceImpl &&
            (identical(other.slug, slug) || other.slug == slug) &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(other._packs, _packs) &&
            (identical(other.itemCount, itemCount) ||
                other.itemCount == itemCount) &&
            (identical(other.productCount, productCount) ||
                other.productCount == productCount) &&
            (identical(other.prestationCount, prestationCount) ||
                other.prestationCount == prestationCount) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.version, version) || other.version == version) &&
            (identical(other.importedVersion, importedVersion) ||
                other.importedVersion == importedVersion) &&
            (identical(other.importedAt, importedAt) ||
                other.importedAt == importedAt) &&
            (identical(other.updateItemCount, updateItemCount) ||
                other.updateItemCount == updateItemCount) &&
            const DeepCollectionEquality().equals(
              other._updateNotes,
              _updateNotes,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    slug,
    label,
    description,
    const DeepCollectionEquality().hash(_packs),
    itemCount,
    productCount,
    prestationCount,
    status,
    version,
    importedVersion,
    importedAt,
    updateItemCount,
    const DeepCollectionEquality().hash(_updateNotes),
  );

  /// Create a copy of CatalogSource
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CatalogSourceImplCopyWith<_$CatalogSourceImpl> get copyWith =>
      __$$CatalogSourceImplCopyWithImpl<_$CatalogSourceImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CatalogSourceImplToJson(this);
  }
}

abstract class _CatalogSource extends CatalogSource {
  const factory _CatalogSource({
    required final String slug,
    required final String label,
    final String? description,
    final List<CatalogPackSummary> packs,
    required final int itemCount,
    required final int productCount,
    required final int prestationCount,
    required final CatalogSourceStatus status,
    required final int version,
    final int? importedVersion,
    final DateTime? importedAt,
    final int? updateItemCount,
    final List<String>? updateNotes,
  }) = _$CatalogSourceImpl;
  const _CatalogSource._() : super._();

  factory _CatalogSource.fromJson(Map<String, dynamic> json) =
      _$CatalogSourceImpl.fromJson;

  @override
  String get slug;
  @override
  String get label;
  @override
  String? get description;
  @override
  List<CatalogPackSummary> get packs;
  @override
  int get itemCount;
  @override
  int get productCount;
  @override
  int get prestationCount;
  @override
  CatalogSourceStatus get status;
  @override
  int get version;
  @override
  int? get importedVersion;
  @override
  DateTime? get importedAt; // Only when status == updateAvailable: how many articles the update adds…
  @override
  int? get updateItemCount; // …and its "Nouveautés" (why to update): "Ajout des PAC R290", etc.
  @override
  List<String>? get updateNotes;

  /// Create a copy of CatalogSource
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CatalogSourceImplCopyWith<_$CatalogSourceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CatalogImportResult _$CatalogImportResultFromJson(Map<String, dynamic> json) {
  return _CatalogImportResult.fromJson(json);
}

/// @nodoc
mixin _$CatalogImportResult {
  String get slug => throw _privateConstructorUsedError;
  String get label => throw _privateConstructorUsedError;
  int get categoriesCreated => throw _privateConstructorUsedError;
  int get itemsCreated => throw _privateConstructorUsedError;
  int get itemsSkipped => throw _privateConstructorUsedError;

  /// Serializes this CatalogImportResult to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CatalogImportResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CatalogImportResultCopyWith<CatalogImportResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CatalogImportResultCopyWith<$Res> {
  factory $CatalogImportResultCopyWith(
    CatalogImportResult value,
    $Res Function(CatalogImportResult) then,
  ) = _$CatalogImportResultCopyWithImpl<$Res, CatalogImportResult>;
  @useResult
  $Res call({
    String slug,
    String label,
    int categoriesCreated,
    int itemsCreated,
    int itemsSkipped,
  });
}

/// @nodoc
class _$CatalogImportResultCopyWithImpl<$Res, $Val extends CatalogImportResult>
    implements $CatalogImportResultCopyWith<$Res> {
  _$CatalogImportResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CatalogImportResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? slug = null,
    Object? label = null,
    Object? categoriesCreated = null,
    Object? itemsCreated = null,
    Object? itemsSkipped = null,
  }) {
    return _then(
      _value.copyWith(
            slug: null == slug
                ? _value.slug
                : slug // ignore: cast_nullable_to_non_nullable
                      as String,
            label: null == label
                ? _value.label
                : label // ignore: cast_nullable_to_non_nullable
                      as String,
            categoriesCreated: null == categoriesCreated
                ? _value.categoriesCreated
                : categoriesCreated // ignore: cast_nullable_to_non_nullable
                      as int,
            itemsCreated: null == itemsCreated
                ? _value.itemsCreated
                : itemsCreated // ignore: cast_nullable_to_non_nullable
                      as int,
            itemsSkipped: null == itemsSkipped
                ? _value.itemsSkipped
                : itemsSkipped // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CatalogImportResultImplCopyWith<$Res>
    implements $CatalogImportResultCopyWith<$Res> {
  factory _$$CatalogImportResultImplCopyWith(
    _$CatalogImportResultImpl value,
    $Res Function(_$CatalogImportResultImpl) then,
  ) = __$$CatalogImportResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String slug,
    String label,
    int categoriesCreated,
    int itemsCreated,
    int itemsSkipped,
  });
}

/// @nodoc
class __$$CatalogImportResultImplCopyWithImpl<$Res>
    extends _$CatalogImportResultCopyWithImpl<$Res, _$CatalogImportResultImpl>
    implements _$$CatalogImportResultImplCopyWith<$Res> {
  __$$CatalogImportResultImplCopyWithImpl(
    _$CatalogImportResultImpl _value,
    $Res Function(_$CatalogImportResultImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CatalogImportResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? slug = null,
    Object? label = null,
    Object? categoriesCreated = null,
    Object? itemsCreated = null,
    Object? itemsSkipped = null,
  }) {
    return _then(
      _$CatalogImportResultImpl(
        slug: null == slug
            ? _value.slug
            : slug // ignore: cast_nullable_to_non_nullable
                  as String,
        label: null == label
            ? _value.label
            : label // ignore: cast_nullable_to_non_nullable
                  as String,
        categoriesCreated: null == categoriesCreated
            ? _value.categoriesCreated
            : categoriesCreated // ignore: cast_nullable_to_non_nullable
                  as int,
        itemsCreated: null == itemsCreated
            ? _value.itemsCreated
            : itemsCreated // ignore: cast_nullable_to_non_nullable
                  as int,
        itemsSkipped: null == itemsSkipped
            ? _value.itemsSkipped
            : itemsSkipped // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CatalogImportResultImpl implements _CatalogImportResult {
  const _$CatalogImportResultImpl({
    required this.slug,
    required this.label,
    required this.categoriesCreated,
    required this.itemsCreated,
    required this.itemsSkipped,
  });

  factory _$CatalogImportResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$CatalogImportResultImplFromJson(json);

  @override
  final String slug;
  @override
  final String label;
  @override
  final int categoriesCreated;
  @override
  final int itemsCreated;
  @override
  final int itemsSkipped;

  @override
  String toString() {
    return 'CatalogImportResult(slug: $slug, label: $label, categoriesCreated: $categoriesCreated, itemsCreated: $itemsCreated, itemsSkipped: $itemsSkipped)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CatalogImportResultImpl &&
            (identical(other.slug, slug) || other.slug == slug) &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.categoriesCreated, categoriesCreated) ||
                other.categoriesCreated == categoriesCreated) &&
            (identical(other.itemsCreated, itemsCreated) ||
                other.itemsCreated == itemsCreated) &&
            (identical(other.itemsSkipped, itemsSkipped) ||
                other.itemsSkipped == itemsSkipped));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    slug,
    label,
    categoriesCreated,
    itemsCreated,
    itemsSkipped,
  );

  /// Create a copy of CatalogImportResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CatalogImportResultImplCopyWith<_$CatalogImportResultImpl> get copyWith =>
      __$$CatalogImportResultImplCopyWithImpl<_$CatalogImportResultImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CatalogImportResultImplToJson(this);
  }
}

abstract class _CatalogImportResult implements CatalogImportResult {
  const factory _CatalogImportResult({
    required final String slug,
    required final String label,
    required final int categoriesCreated,
    required final int itemsCreated,
    required final int itemsSkipped,
  }) = _$CatalogImportResultImpl;

  factory _CatalogImportResult.fromJson(Map<String, dynamic> json) =
      _$CatalogImportResultImpl.fromJson;

  @override
  String get slug;
  @override
  String get label;
  @override
  int get categoriesCreated;
  @override
  int get itemsCreated;
  @override
  int get itemsSkipped;

  /// Create a copy of CatalogImportResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CatalogImportResultImplCopyWith<_$CatalogImportResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
