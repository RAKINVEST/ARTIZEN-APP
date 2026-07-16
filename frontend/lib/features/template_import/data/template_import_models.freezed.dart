// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'template_import_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

DocumentAnalysisSummary _$DocumentAnalysisSummaryFromJson(
  Map<String, dynamic> json,
) {
  return _DocumentAnalysisSummary.fromJson(json);
}

/// @nodoc
mixin _$DocumentAnalysisSummary {
  String get id => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String get filename => throw _privateConstructorUsedError;
  String get documentType => throw _privateConstructorUsedError;
  int? get pageCount => throw _privateConstructorUsedError;

  /// Serializes this DocumentAnalysisSummary to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DocumentAnalysisSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DocumentAnalysisSummaryCopyWith<DocumentAnalysisSummary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DocumentAnalysisSummaryCopyWith<$Res> {
  factory $DocumentAnalysisSummaryCopyWith(
    DocumentAnalysisSummary value,
    $Res Function(DocumentAnalysisSummary) then,
  ) = _$DocumentAnalysisSummaryCopyWithImpl<$Res, DocumentAnalysisSummary>;
  @useResult
  $Res call({
    String id,
    String status,
    String filename,
    String documentType,
    int? pageCount,
  });
}

/// @nodoc
class _$DocumentAnalysisSummaryCopyWithImpl<
  $Res,
  $Val extends DocumentAnalysisSummary
>
    implements $DocumentAnalysisSummaryCopyWith<$Res> {
  _$DocumentAnalysisSummaryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DocumentAnalysisSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? status = null,
    Object? filename = null,
    Object? documentType = null,
    Object? pageCount = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            filename: null == filename
                ? _value.filename
                : filename // ignore: cast_nullable_to_non_nullable
                      as String,
            documentType: null == documentType
                ? _value.documentType
                : documentType // ignore: cast_nullable_to_non_nullable
                      as String,
            pageCount: freezed == pageCount
                ? _value.pageCount
                : pageCount // ignore: cast_nullable_to_non_nullable
                      as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DocumentAnalysisSummaryImplCopyWith<$Res>
    implements $DocumentAnalysisSummaryCopyWith<$Res> {
  factory _$$DocumentAnalysisSummaryImplCopyWith(
    _$DocumentAnalysisSummaryImpl value,
    $Res Function(_$DocumentAnalysisSummaryImpl) then,
  ) = __$$DocumentAnalysisSummaryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String status,
    String filename,
    String documentType,
    int? pageCount,
  });
}

/// @nodoc
class __$$DocumentAnalysisSummaryImplCopyWithImpl<$Res>
    extends
        _$DocumentAnalysisSummaryCopyWithImpl<
          $Res,
          _$DocumentAnalysisSummaryImpl
        >
    implements _$$DocumentAnalysisSummaryImplCopyWith<$Res> {
  __$$DocumentAnalysisSummaryImplCopyWithImpl(
    _$DocumentAnalysisSummaryImpl _value,
    $Res Function(_$DocumentAnalysisSummaryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DocumentAnalysisSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? status = null,
    Object? filename = null,
    Object? documentType = null,
    Object? pageCount = freezed,
  }) {
    return _then(
      _$DocumentAnalysisSummaryImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        filename: null == filename
            ? _value.filename
            : filename // ignore: cast_nullable_to_non_nullable
                  as String,
        documentType: null == documentType
            ? _value.documentType
            : documentType // ignore: cast_nullable_to_non_nullable
                  as String,
        pageCount: freezed == pageCount
            ? _value.pageCount
            : pageCount // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DocumentAnalysisSummaryImpl implements _DocumentAnalysisSummary {
  const _$DocumentAnalysisSummaryImpl({
    required this.id,
    required this.status,
    required this.filename,
    required this.documentType,
    this.pageCount,
  });

  factory _$DocumentAnalysisSummaryImpl.fromJson(Map<String, dynamic> json) =>
      _$$DocumentAnalysisSummaryImplFromJson(json);

  @override
  final String id;
  @override
  final String status;
  @override
  final String filename;
  @override
  final String documentType;
  @override
  final int? pageCount;

  @override
  String toString() {
    return 'DocumentAnalysisSummary(id: $id, status: $status, filename: $filename, documentType: $documentType, pageCount: $pageCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DocumentAnalysisSummaryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.filename, filename) ||
                other.filename == filename) &&
            (identical(other.documentType, documentType) ||
                other.documentType == documentType) &&
            (identical(other.pageCount, pageCount) ||
                other.pageCount == pageCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, status, filename, documentType, pageCount);

  /// Create a copy of DocumentAnalysisSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DocumentAnalysisSummaryImplCopyWith<_$DocumentAnalysisSummaryImpl>
  get copyWith =>
      __$$DocumentAnalysisSummaryImplCopyWithImpl<
        _$DocumentAnalysisSummaryImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DocumentAnalysisSummaryImplToJson(this);
  }
}

abstract class _DocumentAnalysisSummary implements DocumentAnalysisSummary {
  const factory _DocumentAnalysisSummary({
    required final String id,
    required final String status,
    required final String filename,
    required final String documentType,
    final int? pageCount,
  }) = _$DocumentAnalysisSummaryImpl;

  factory _DocumentAnalysisSummary.fromJson(Map<String, dynamic> json) =
      _$DocumentAnalysisSummaryImpl.fromJson;

  @override
  String get id;
  @override
  String get status;
  @override
  String get filename;
  @override
  String get documentType;
  @override
  int? get pageCount;

  /// Create a copy of DocumentAnalysisSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DocumentAnalysisSummaryImplCopyWith<_$DocumentAnalysisSummaryImpl>
  get copyWith => throw _privateConstructorUsedError;
}

DetectionResult _$DetectionResultFromJson(Map<String, dynamic> json) {
  return _DetectionResult.fromJson(json);
}

/// @nodoc
mixin _$DetectionResult {
  bool get logoDetected => throw _privateConstructorUsedError;
  String? get logoPosition => throw _privateConstructorUsedError;
  List<String> get dominantColors => throw _privateConstructorUsedError;
  bool get headerDetected => throw _privateConstructorUsedError;
  bool get footerDetected => throw _privateConstructorUsedError;
  bool get tableDetected => throw _privateConstructorUsedError;
  String? get companyName => throw _privateConstructorUsedError;
  String? get address => throw _privateConstructorUsedError;
  String? get phone => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String? get website => throw _privateConstructorUsedError;
  String? get siret => throw _privateConstructorUsedError;
  String? get vatNumber => throw _privateConstructorUsedError;
  bool get legalNoticeDetected => throw _privateConstructorUsedError;
  double get confidenceScore => throw _privateConstructorUsedError;

  /// Serializes this DetectionResult to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DetectionResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DetectionResultCopyWith<DetectionResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DetectionResultCopyWith<$Res> {
  factory $DetectionResultCopyWith(
    DetectionResult value,
    $Res Function(DetectionResult) then,
  ) = _$DetectionResultCopyWithImpl<$Res, DetectionResult>;
  @useResult
  $Res call({
    bool logoDetected,
    String? logoPosition,
    List<String> dominantColors,
    bool headerDetected,
    bool footerDetected,
    bool tableDetected,
    String? companyName,
    String? address,
    String? phone,
    String? email,
    String? website,
    String? siret,
    String? vatNumber,
    bool legalNoticeDetected,
    double confidenceScore,
  });
}

/// @nodoc
class _$DetectionResultCopyWithImpl<$Res, $Val extends DetectionResult>
    implements $DetectionResultCopyWith<$Res> {
  _$DetectionResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DetectionResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? logoDetected = null,
    Object? logoPosition = freezed,
    Object? dominantColors = null,
    Object? headerDetected = null,
    Object? footerDetected = null,
    Object? tableDetected = null,
    Object? companyName = freezed,
    Object? address = freezed,
    Object? phone = freezed,
    Object? email = freezed,
    Object? website = freezed,
    Object? siret = freezed,
    Object? vatNumber = freezed,
    Object? legalNoticeDetected = null,
    Object? confidenceScore = null,
  }) {
    return _then(
      _value.copyWith(
            logoDetected: null == logoDetected
                ? _value.logoDetected
                : logoDetected // ignore: cast_nullable_to_non_nullable
                      as bool,
            logoPosition: freezed == logoPosition
                ? _value.logoPosition
                : logoPosition // ignore: cast_nullable_to_non_nullable
                      as String?,
            dominantColors: null == dominantColors
                ? _value.dominantColors
                : dominantColors // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            headerDetected: null == headerDetected
                ? _value.headerDetected
                : headerDetected // ignore: cast_nullable_to_non_nullable
                      as bool,
            footerDetected: null == footerDetected
                ? _value.footerDetected
                : footerDetected // ignore: cast_nullable_to_non_nullable
                      as bool,
            tableDetected: null == tableDetected
                ? _value.tableDetected
                : tableDetected // ignore: cast_nullable_to_non_nullable
                      as bool,
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
            website: freezed == website
                ? _value.website
                : website // ignore: cast_nullable_to_non_nullable
                      as String?,
            siret: freezed == siret
                ? _value.siret
                : siret // ignore: cast_nullable_to_non_nullable
                      as String?,
            vatNumber: freezed == vatNumber
                ? _value.vatNumber
                : vatNumber // ignore: cast_nullable_to_non_nullable
                      as String?,
            legalNoticeDetected: null == legalNoticeDetected
                ? _value.legalNoticeDetected
                : legalNoticeDetected // ignore: cast_nullable_to_non_nullable
                      as bool,
            confidenceScore: null == confidenceScore
                ? _value.confidenceScore
                : confidenceScore // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DetectionResultImplCopyWith<$Res>
    implements $DetectionResultCopyWith<$Res> {
  factory _$$DetectionResultImplCopyWith(
    _$DetectionResultImpl value,
    $Res Function(_$DetectionResultImpl) then,
  ) = __$$DetectionResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    bool logoDetected,
    String? logoPosition,
    List<String> dominantColors,
    bool headerDetected,
    bool footerDetected,
    bool tableDetected,
    String? companyName,
    String? address,
    String? phone,
    String? email,
    String? website,
    String? siret,
    String? vatNumber,
    bool legalNoticeDetected,
    double confidenceScore,
  });
}

/// @nodoc
class __$$DetectionResultImplCopyWithImpl<$Res>
    extends _$DetectionResultCopyWithImpl<$Res, _$DetectionResultImpl>
    implements _$$DetectionResultImplCopyWith<$Res> {
  __$$DetectionResultImplCopyWithImpl(
    _$DetectionResultImpl _value,
    $Res Function(_$DetectionResultImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DetectionResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? logoDetected = null,
    Object? logoPosition = freezed,
    Object? dominantColors = null,
    Object? headerDetected = null,
    Object? footerDetected = null,
    Object? tableDetected = null,
    Object? companyName = freezed,
    Object? address = freezed,
    Object? phone = freezed,
    Object? email = freezed,
    Object? website = freezed,
    Object? siret = freezed,
    Object? vatNumber = freezed,
    Object? legalNoticeDetected = null,
    Object? confidenceScore = null,
  }) {
    return _then(
      _$DetectionResultImpl(
        logoDetected: null == logoDetected
            ? _value.logoDetected
            : logoDetected // ignore: cast_nullable_to_non_nullable
                  as bool,
        logoPosition: freezed == logoPosition
            ? _value.logoPosition
            : logoPosition // ignore: cast_nullable_to_non_nullable
                  as String?,
        dominantColors: null == dominantColors
            ? _value._dominantColors
            : dominantColors // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        headerDetected: null == headerDetected
            ? _value.headerDetected
            : headerDetected // ignore: cast_nullable_to_non_nullable
                  as bool,
        footerDetected: null == footerDetected
            ? _value.footerDetected
            : footerDetected // ignore: cast_nullable_to_non_nullable
                  as bool,
        tableDetected: null == tableDetected
            ? _value.tableDetected
            : tableDetected // ignore: cast_nullable_to_non_nullable
                  as bool,
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
        website: freezed == website
            ? _value.website
            : website // ignore: cast_nullable_to_non_nullable
                  as String?,
        siret: freezed == siret
            ? _value.siret
            : siret // ignore: cast_nullable_to_non_nullable
                  as String?,
        vatNumber: freezed == vatNumber
            ? _value.vatNumber
            : vatNumber // ignore: cast_nullable_to_non_nullable
                  as String?,
        legalNoticeDetected: null == legalNoticeDetected
            ? _value.legalNoticeDetected
            : legalNoticeDetected // ignore: cast_nullable_to_non_nullable
                  as bool,
        confidenceScore: null == confidenceScore
            ? _value.confidenceScore
            : confidenceScore // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DetectionResultImpl implements _DetectionResult {
  const _$DetectionResultImpl({
    required this.logoDetected,
    this.logoPosition,
    required final List<String> dominantColors,
    required this.headerDetected,
    required this.footerDetected,
    required this.tableDetected,
    this.companyName,
    this.address,
    this.phone,
    this.email,
    this.website,
    this.siret,
    this.vatNumber,
    required this.legalNoticeDetected,
    required this.confidenceScore,
  }) : _dominantColors = dominantColors;

  factory _$DetectionResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$DetectionResultImplFromJson(json);

  @override
  final bool logoDetected;
  @override
  final String? logoPosition;
  final List<String> _dominantColors;
  @override
  List<String> get dominantColors {
    if (_dominantColors is EqualUnmodifiableListView) return _dominantColors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_dominantColors);
  }

  @override
  final bool headerDetected;
  @override
  final bool footerDetected;
  @override
  final bool tableDetected;
  @override
  final String? companyName;
  @override
  final String? address;
  @override
  final String? phone;
  @override
  final String? email;
  @override
  final String? website;
  @override
  final String? siret;
  @override
  final String? vatNumber;
  @override
  final bool legalNoticeDetected;
  @override
  final double confidenceScore;

  @override
  String toString() {
    return 'DetectionResult(logoDetected: $logoDetected, logoPosition: $logoPosition, dominantColors: $dominantColors, headerDetected: $headerDetected, footerDetected: $footerDetected, tableDetected: $tableDetected, companyName: $companyName, address: $address, phone: $phone, email: $email, website: $website, siret: $siret, vatNumber: $vatNumber, legalNoticeDetected: $legalNoticeDetected, confidenceScore: $confidenceScore)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DetectionResultImpl &&
            (identical(other.logoDetected, logoDetected) ||
                other.logoDetected == logoDetected) &&
            (identical(other.logoPosition, logoPosition) ||
                other.logoPosition == logoPosition) &&
            const DeepCollectionEquality().equals(
              other._dominantColors,
              _dominantColors,
            ) &&
            (identical(other.headerDetected, headerDetected) ||
                other.headerDetected == headerDetected) &&
            (identical(other.footerDetected, footerDetected) ||
                other.footerDetected == footerDetected) &&
            (identical(other.tableDetected, tableDetected) ||
                other.tableDetected == tableDetected) &&
            (identical(other.companyName, companyName) ||
                other.companyName == companyName) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.website, website) || other.website == website) &&
            (identical(other.siret, siret) || other.siret == siret) &&
            (identical(other.vatNumber, vatNumber) ||
                other.vatNumber == vatNumber) &&
            (identical(other.legalNoticeDetected, legalNoticeDetected) ||
                other.legalNoticeDetected == legalNoticeDetected) &&
            (identical(other.confidenceScore, confidenceScore) ||
                other.confidenceScore == confidenceScore));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    logoDetected,
    logoPosition,
    const DeepCollectionEquality().hash(_dominantColors),
    headerDetected,
    footerDetected,
    tableDetected,
    companyName,
    address,
    phone,
    email,
    website,
    siret,
    vatNumber,
    legalNoticeDetected,
    confidenceScore,
  );

  /// Create a copy of DetectionResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DetectionResultImplCopyWith<_$DetectionResultImpl> get copyWith =>
      __$$DetectionResultImplCopyWithImpl<_$DetectionResultImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$DetectionResultImplToJson(this);
  }
}

abstract class _DetectionResult implements DetectionResult {
  const factory _DetectionResult({
    required final bool logoDetected,
    final String? logoPosition,
    required final List<String> dominantColors,
    required final bool headerDetected,
    required final bool footerDetected,
    required final bool tableDetected,
    final String? companyName,
    final String? address,
    final String? phone,
    final String? email,
    final String? website,
    final String? siret,
    final String? vatNumber,
    required final bool legalNoticeDetected,
    required final double confidenceScore,
  }) = _$DetectionResultImpl;

  factory _DetectionResult.fromJson(Map<String, dynamic> json) =
      _$DetectionResultImpl.fromJson;

  @override
  bool get logoDetected;
  @override
  String? get logoPosition;
  @override
  List<String> get dominantColors;
  @override
  bool get headerDetected;
  @override
  bool get footerDetected;
  @override
  bool get tableDetected;
  @override
  String? get companyName;
  @override
  String? get address;
  @override
  String? get phone;
  @override
  String? get email;
  @override
  String? get website;
  @override
  String? get siret;
  @override
  String? get vatNumber;
  @override
  bool get legalNoticeDetected;
  @override
  double get confidenceScore;

  /// Create a copy of DetectionResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DetectionResultImplCopyWith<_$DetectionResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TemplateImportPreview _$TemplateImportPreviewFromJson(
  Map<String, dynamic> json,
) {
  return _TemplateImportPreview.fromJson(json);
}

/// @nodoc
mixin _$TemplateImportPreview {
  DocumentAnalysisSummary get analysis => throw _privateConstructorUsedError;
  DetectionResult get detection => throw _privateConstructorUsedError;
  Company get currentCompany => throw _privateConstructorUsedError;
  BrandProfile get currentBrand => throw _privateConstructorUsedError;

  /// Serializes this TemplateImportPreview to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TemplateImportPreview
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TemplateImportPreviewCopyWith<TemplateImportPreview> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TemplateImportPreviewCopyWith<$Res> {
  factory $TemplateImportPreviewCopyWith(
    TemplateImportPreview value,
    $Res Function(TemplateImportPreview) then,
  ) = _$TemplateImportPreviewCopyWithImpl<$Res, TemplateImportPreview>;
  @useResult
  $Res call({
    DocumentAnalysisSummary analysis,
    DetectionResult detection,
    Company currentCompany,
    BrandProfile currentBrand,
  });

  $DocumentAnalysisSummaryCopyWith<$Res> get analysis;
  $DetectionResultCopyWith<$Res> get detection;
  $CompanyCopyWith<$Res> get currentCompany;
  $BrandProfileCopyWith<$Res> get currentBrand;
}

/// @nodoc
class _$TemplateImportPreviewCopyWithImpl<
  $Res,
  $Val extends TemplateImportPreview
>
    implements $TemplateImportPreviewCopyWith<$Res> {
  _$TemplateImportPreviewCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TemplateImportPreview
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? analysis = null,
    Object? detection = null,
    Object? currentCompany = null,
    Object? currentBrand = null,
  }) {
    return _then(
      _value.copyWith(
            analysis: null == analysis
                ? _value.analysis
                : analysis // ignore: cast_nullable_to_non_nullable
                      as DocumentAnalysisSummary,
            detection: null == detection
                ? _value.detection
                : detection // ignore: cast_nullable_to_non_nullable
                      as DetectionResult,
            currentCompany: null == currentCompany
                ? _value.currentCompany
                : currentCompany // ignore: cast_nullable_to_non_nullable
                      as Company,
            currentBrand: null == currentBrand
                ? _value.currentBrand
                : currentBrand // ignore: cast_nullable_to_non_nullable
                      as BrandProfile,
          )
          as $Val,
    );
  }

  /// Create a copy of TemplateImportPreview
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DocumentAnalysisSummaryCopyWith<$Res> get analysis {
    return $DocumentAnalysisSummaryCopyWith<$Res>(_value.analysis, (value) {
      return _then(_value.copyWith(analysis: value) as $Val);
    });
  }

  /// Create a copy of TemplateImportPreview
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DetectionResultCopyWith<$Res> get detection {
    return $DetectionResultCopyWith<$Res>(_value.detection, (value) {
      return _then(_value.copyWith(detection: value) as $Val);
    });
  }

  /// Create a copy of TemplateImportPreview
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CompanyCopyWith<$Res> get currentCompany {
    return $CompanyCopyWith<$Res>(_value.currentCompany, (value) {
      return _then(_value.copyWith(currentCompany: value) as $Val);
    });
  }

  /// Create a copy of TemplateImportPreview
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BrandProfileCopyWith<$Res> get currentBrand {
    return $BrandProfileCopyWith<$Res>(_value.currentBrand, (value) {
      return _then(_value.copyWith(currentBrand: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TemplateImportPreviewImplCopyWith<$Res>
    implements $TemplateImportPreviewCopyWith<$Res> {
  factory _$$TemplateImportPreviewImplCopyWith(
    _$TemplateImportPreviewImpl value,
    $Res Function(_$TemplateImportPreviewImpl) then,
  ) = __$$TemplateImportPreviewImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    DocumentAnalysisSummary analysis,
    DetectionResult detection,
    Company currentCompany,
    BrandProfile currentBrand,
  });

  @override
  $DocumentAnalysisSummaryCopyWith<$Res> get analysis;
  @override
  $DetectionResultCopyWith<$Res> get detection;
  @override
  $CompanyCopyWith<$Res> get currentCompany;
  @override
  $BrandProfileCopyWith<$Res> get currentBrand;
}

/// @nodoc
class __$$TemplateImportPreviewImplCopyWithImpl<$Res>
    extends
        _$TemplateImportPreviewCopyWithImpl<$Res, _$TemplateImportPreviewImpl>
    implements _$$TemplateImportPreviewImplCopyWith<$Res> {
  __$$TemplateImportPreviewImplCopyWithImpl(
    _$TemplateImportPreviewImpl _value,
    $Res Function(_$TemplateImportPreviewImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TemplateImportPreview
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? analysis = null,
    Object? detection = null,
    Object? currentCompany = null,
    Object? currentBrand = null,
  }) {
    return _then(
      _$TemplateImportPreviewImpl(
        analysis: null == analysis
            ? _value.analysis
            : analysis // ignore: cast_nullable_to_non_nullable
                  as DocumentAnalysisSummary,
        detection: null == detection
            ? _value.detection
            : detection // ignore: cast_nullable_to_non_nullable
                  as DetectionResult,
        currentCompany: null == currentCompany
            ? _value.currentCompany
            : currentCompany // ignore: cast_nullable_to_non_nullable
                  as Company,
        currentBrand: null == currentBrand
            ? _value.currentBrand
            : currentBrand // ignore: cast_nullable_to_non_nullable
                  as BrandProfile,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TemplateImportPreviewImpl implements _TemplateImportPreview {
  const _$TemplateImportPreviewImpl({
    required this.analysis,
    required this.detection,
    required this.currentCompany,
    required this.currentBrand,
  });

  factory _$TemplateImportPreviewImpl.fromJson(Map<String, dynamic> json) =>
      _$$TemplateImportPreviewImplFromJson(json);

  @override
  final DocumentAnalysisSummary analysis;
  @override
  final DetectionResult detection;
  @override
  final Company currentCompany;
  @override
  final BrandProfile currentBrand;

  @override
  String toString() {
    return 'TemplateImportPreview(analysis: $analysis, detection: $detection, currentCompany: $currentCompany, currentBrand: $currentBrand)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TemplateImportPreviewImpl &&
            (identical(other.analysis, analysis) ||
                other.analysis == analysis) &&
            (identical(other.detection, detection) ||
                other.detection == detection) &&
            (identical(other.currentCompany, currentCompany) ||
                other.currentCompany == currentCompany) &&
            (identical(other.currentBrand, currentBrand) ||
                other.currentBrand == currentBrand));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    analysis,
    detection,
    currentCompany,
    currentBrand,
  );

  /// Create a copy of TemplateImportPreview
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TemplateImportPreviewImplCopyWith<_$TemplateImportPreviewImpl>
  get copyWith =>
      __$$TemplateImportPreviewImplCopyWithImpl<_$TemplateImportPreviewImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$TemplateImportPreviewImplToJson(this);
  }
}

abstract class _TemplateImportPreview implements TemplateImportPreview {
  const factory _TemplateImportPreview({
    required final DocumentAnalysisSummary analysis,
    required final DetectionResult detection,
    required final Company currentCompany,
    required final BrandProfile currentBrand,
  }) = _$TemplateImportPreviewImpl;

  factory _TemplateImportPreview.fromJson(Map<String, dynamic> json) =
      _$TemplateImportPreviewImpl.fromJson;

  @override
  DocumentAnalysisSummary get analysis;
  @override
  DetectionResult get detection;
  @override
  Company get currentCompany;
  @override
  BrandProfile get currentBrand;

  /// Create a copy of TemplateImportPreview
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TemplateImportPreviewImplCopyWith<_$TemplateImportPreviewImpl>
  get copyWith => throw _privateConstructorUsedError;
}

TemplateImportValidateInput _$TemplateImportValidateInputFromJson(
  Map<String, dynamic> json,
) {
  return _TemplateImportValidateInput.fromJson(json);
}

/// @nodoc
mixin _$TemplateImportValidateInput {
  String? get name => throw _privateConstructorUsedError;
  String? get legalName => throw _privateConstructorUsedError;
  String? get siret => throw _privateConstructorUsedError;
  String? get vatNumber => throw _privateConstructorUsedError;
  String? get addressLine => throw _privateConstructorUsedError;
  String? get postalCode => throw _privateConstructorUsedError;
  String? get city => throw _privateConstructorUsedError;
  String? get phone => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String? get website => throw _privateConstructorUsedError;
  String? get primaryColor => throw _privateConstructorUsedError;
  String? get secondaryColor => throw _privateConstructorUsedError;

  /// Serializes this TemplateImportValidateInput to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TemplateImportValidateInput
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TemplateImportValidateInputCopyWith<TemplateImportValidateInput>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TemplateImportValidateInputCopyWith<$Res> {
  factory $TemplateImportValidateInputCopyWith(
    TemplateImportValidateInput value,
    $Res Function(TemplateImportValidateInput) then,
  ) =
      _$TemplateImportValidateInputCopyWithImpl<
        $Res,
        TemplateImportValidateInput
      >;
  @useResult
  $Res call({
    String? name,
    String? legalName,
    String? siret,
    String? vatNumber,
    String? addressLine,
    String? postalCode,
    String? city,
    String? phone,
    String? email,
    String? website,
    String? primaryColor,
    String? secondaryColor,
  });
}

/// @nodoc
class _$TemplateImportValidateInputCopyWithImpl<
  $Res,
  $Val extends TemplateImportValidateInput
>
    implements $TemplateImportValidateInputCopyWith<$Res> {
  _$TemplateImportValidateInputCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TemplateImportValidateInput
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? legalName = freezed,
    Object? siret = freezed,
    Object? vatNumber = freezed,
    Object? addressLine = freezed,
    Object? postalCode = freezed,
    Object? city = freezed,
    Object? phone = freezed,
    Object? email = freezed,
    Object? website = freezed,
    Object? primaryColor = freezed,
    Object? secondaryColor = freezed,
  }) {
    return _then(
      _value.copyWith(
            name: freezed == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String?,
            legalName: freezed == legalName
                ? _value.legalName
                : legalName // ignore: cast_nullable_to_non_nullable
                      as String?,
            siret: freezed == siret
                ? _value.siret
                : siret // ignore: cast_nullable_to_non_nullable
                      as String?,
            vatNumber: freezed == vatNumber
                ? _value.vatNumber
                : vatNumber // ignore: cast_nullable_to_non_nullable
                      as String?,
            addressLine: freezed == addressLine
                ? _value.addressLine
                : addressLine // ignore: cast_nullable_to_non_nullable
                      as String?,
            postalCode: freezed == postalCode
                ? _value.postalCode
                : postalCode // ignore: cast_nullable_to_non_nullable
                      as String?,
            city: freezed == city
                ? _value.city
                : city // ignore: cast_nullable_to_non_nullable
                      as String?,
            phone: freezed == phone
                ? _value.phone
                : phone // ignore: cast_nullable_to_non_nullable
                      as String?,
            email: freezed == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                      as String?,
            website: freezed == website
                ? _value.website
                : website // ignore: cast_nullable_to_non_nullable
                      as String?,
            primaryColor: freezed == primaryColor
                ? _value.primaryColor
                : primaryColor // ignore: cast_nullable_to_non_nullable
                      as String?,
            secondaryColor: freezed == secondaryColor
                ? _value.secondaryColor
                : secondaryColor // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TemplateImportValidateInputImplCopyWith<$Res>
    implements $TemplateImportValidateInputCopyWith<$Res> {
  factory _$$TemplateImportValidateInputImplCopyWith(
    _$TemplateImportValidateInputImpl value,
    $Res Function(_$TemplateImportValidateInputImpl) then,
  ) = __$$TemplateImportValidateInputImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? name,
    String? legalName,
    String? siret,
    String? vatNumber,
    String? addressLine,
    String? postalCode,
    String? city,
    String? phone,
    String? email,
    String? website,
    String? primaryColor,
    String? secondaryColor,
  });
}

/// @nodoc
class __$$TemplateImportValidateInputImplCopyWithImpl<$Res>
    extends
        _$TemplateImportValidateInputCopyWithImpl<
          $Res,
          _$TemplateImportValidateInputImpl
        >
    implements _$$TemplateImportValidateInputImplCopyWith<$Res> {
  __$$TemplateImportValidateInputImplCopyWithImpl(
    _$TemplateImportValidateInputImpl _value,
    $Res Function(_$TemplateImportValidateInputImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TemplateImportValidateInput
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? legalName = freezed,
    Object? siret = freezed,
    Object? vatNumber = freezed,
    Object? addressLine = freezed,
    Object? postalCode = freezed,
    Object? city = freezed,
    Object? phone = freezed,
    Object? email = freezed,
    Object? website = freezed,
    Object? primaryColor = freezed,
    Object? secondaryColor = freezed,
  }) {
    return _then(
      _$TemplateImportValidateInputImpl(
        name: freezed == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String?,
        legalName: freezed == legalName
            ? _value.legalName
            : legalName // ignore: cast_nullable_to_non_nullable
                  as String?,
        siret: freezed == siret
            ? _value.siret
            : siret // ignore: cast_nullable_to_non_nullable
                  as String?,
        vatNumber: freezed == vatNumber
            ? _value.vatNumber
            : vatNumber // ignore: cast_nullable_to_non_nullable
                  as String?,
        addressLine: freezed == addressLine
            ? _value.addressLine
            : addressLine // ignore: cast_nullable_to_non_nullable
                  as String?,
        postalCode: freezed == postalCode
            ? _value.postalCode
            : postalCode // ignore: cast_nullable_to_non_nullable
                  as String?,
        city: freezed == city
            ? _value.city
            : city // ignore: cast_nullable_to_non_nullable
                  as String?,
        phone: freezed == phone
            ? _value.phone
            : phone // ignore: cast_nullable_to_non_nullable
                  as String?,
        email: freezed == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String?,
        website: freezed == website
            ? _value.website
            : website // ignore: cast_nullable_to_non_nullable
                  as String?,
        primaryColor: freezed == primaryColor
            ? _value.primaryColor
            : primaryColor // ignore: cast_nullable_to_non_nullable
                  as String?,
        secondaryColor: freezed == secondaryColor
            ? _value.secondaryColor
            : secondaryColor // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TemplateImportValidateInputImpl
    implements _TemplateImportValidateInput {
  const _$TemplateImportValidateInputImpl({
    this.name,
    this.legalName,
    this.siret,
    this.vatNumber,
    this.addressLine,
    this.postalCode,
    this.city,
    this.phone,
    this.email,
    this.website,
    this.primaryColor,
    this.secondaryColor,
  });

  factory _$TemplateImportValidateInputImpl.fromJson(
    Map<String, dynamic> json,
  ) => _$$TemplateImportValidateInputImplFromJson(json);

  @override
  final String? name;
  @override
  final String? legalName;
  @override
  final String? siret;
  @override
  final String? vatNumber;
  @override
  final String? addressLine;
  @override
  final String? postalCode;
  @override
  final String? city;
  @override
  final String? phone;
  @override
  final String? email;
  @override
  final String? website;
  @override
  final String? primaryColor;
  @override
  final String? secondaryColor;

  @override
  String toString() {
    return 'TemplateImportValidateInput(name: $name, legalName: $legalName, siret: $siret, vatNumber: $vatNumber, addressLine: $addressLine, postalCode: $postalCode, city: $city, phone: $phone, email: $email, website: $website, primaryColor: $primaryColor, secondaryColor: $secondaryColor)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TemplateImportValidateInputImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.legalName, legalName) ||
                other.legalName == legalName) &&
            (identical(other.siret, siret) || other.siret == siret) &&
            (identical(other.vatNumber, vatNumber) ||
                other.vatNumber == vatNumber) &&
            (identical(other.addressLine, addressLine) ||
                other.addressLine == addressLine) &&
            (identical(other.postalCode, postalCode) ||
                other.postalCode == postalCode) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.website, website) || other.website == website) &&
            (identical(other.primaryColor, primaryColor) ||
                other.primaryColor == primaryColor) &&
            (identical(other.secondaryColor, secondaryColor) ||
                other.secondaryColor == secondaryColor));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    name,
    legalName,
    siret,
    vatNumber,
    addressLine,
    postalCode,
    city,
    phone,
    email,
    website,
    primaryColor,
    secondaryColor,
  );

  /// Create a copy of TemplateImportValidateInput
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TemplateImportValidateInputImplCopyWith<_$TemplateImportValidateInputImpl>
  get copyWith =>
      __$$TemplateImportValidateInputImplCopyWithImpl<
        _$TemplateImportValidateInputImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TemplateImportValidateInputImplToJson(this);
  }
}

abstract class _TemplateImportValidateInput
    implements TemplateImportValidateInput {
  const factory _TemplateImportValidateInput({
    final String? name,
    final String? legalName,
    final String? siret,
    final String? vatNumber,
    final String? addressLine,
    final String? postalCode,
    final String? city,
    final String? phone,
    final String? email,
    final String? website,
    final String? primaryColor,
    final String? secondaryColor,
  }) = _$TemplateImportValidateInputImpl;

  factory _TemplateImportValidateInput.fromJson(Map<String, dynamic> json) =
      _$TemplateImportValidateInputImpl.fromJson;

  @override
  String? get name;
  @override
  String? get legalName;
  @override
  String? get siret;
  @override
  String? get vatNumber;
  @override
  String? get addressLine;
  @override
  String? get postalCode;
  @override
  String? get city;
  @override
  String? get phone;
  @override
  String? get email;
  @override
  String? get website;
  @override
  String? get primaryColor;
  @override
  String? get secondaryColor;

  /// Create a copy of TemplateImportValidateInput
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TemplateImportValidateInputImplCopyWith<_$TemplateImportValidateInputImpl>
  get copyWith => throw _privateConstructorUsedError;
}
