// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'quote_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

QuoteLine _$QuoteLineFromJson(Map<String, dynamic> json) {
  return _QuoteLine.fromJson(json);
}

/// @nodoc
mixin _$QuoteLine {
  String get id =>
      throw _privateConstructorUsedError; // Null for a free line (décision 5), or once the catalog item behind a
  // line has been deleted (backend SET NULL). The snapshot below still holds.
  String? get catalogItemId => throw _privateConstructorUsedError;
  String get designation => throw _privateConstructorUsedError;
  String get unit => throw _privateConstructorUsedError;
  String get quantity => throw _privateConstructorUsedError;
  String get unitPriceHt => throw _privateConstructorUsedError;
  String get vatRate => throw _privateConstructorUsedError;
  String get totalHt => throw _privateConstructorUsedError;
  String get totalVat => throw _privateConstructorUsedError;
  String get totalTtc => throw _privateConstructorUsedError;

  /// Serializes this QuoteLine to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of QuoteLine
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QuoteLineCopyWith<QuoteLine> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuoteLineCopyWith<$Res> {
  factory $QuoteLineCopyWith(QuoteLine value, $Res Function(QuoteLine) then) =
      _$QuoteLineCopyWithImpl<$Res, QuoteLine>;
  @useResult
  $Res call({
    String id,
    String? catalogItemId,
    String designation,
    String unit,
    String quantity,
    String unitPriceHt,
    String vatRate,
    String totalHt,
    String totalVat,
    String totalTtc,
  });
}

/// @nodoc
class _$QuoteLineCopyWithImpl<$Res, $Val extends QuoteLine>
    implements $QuoteLineCopyWith<$Res> {
  _$QuoteLineCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of QuoteLine
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? catalogItemId = freezed,
    Object? designation = null,
    Object? unit = null,
    Object? quantity = null,
    Object? unitPriceHt = null,
    Object? vatRate = null,
    Object? totalHt = null,
    Object? totalVat = null,
    Object? totalTtc = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            catalogItemId: freezed == catalogItemId
                ? _value.catalogItemId
                : catalogItemId // ignore: cast_nullable_to_non_nullable
                      as String?,
            designation: null == designation
                ? _value.designation
                : designation // ignore: cast_nullable_to_non_nullable
                      as String,
            unit: null == unit
                ? _value.unit
                : unit // ignore: cast_nullable_to_non_nullable
                      as String,
            quantity: null == quantity
                ? _value.quantity
                : quantity // ignore: cast_nullable_to_non_nullable
                      as String,
            unitPriceHt: null == unitPriceHt
                ? _value.unitPriceHt
                : unitPriceHt // ignore: cast_nullable_to_non_nullable
                      as String,
            vatRate: null == vatRate
                ? _value.vatRate
                : vatRate // ignore: cast_nullable_to_non_nullable
                      as String,
            totalHt: null == totalHt
                ? _value.totalHt
                : totalHt // ignore: cast_nullable_to_non_nullable
                      as String,
            totalVat: null == totalVat
                ? _value.totalVat
                : totalVat // ignore: cast_nullable_to_non_nullable
                      as String,
            totalTtc: null == totalTtc
                ? _value.totalTtc
                : totalTtc // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$QuoteLineImplCopyWith<$Res>
    implements $QuoteLineCopyWith<$Res> {
  factory _$$QuoteLineImplCopyWith(
    _$QuoteLineImpl value,
    $Res Function(_$QuoteLineImpl) then,
  ) = __$$QuoteLineImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String? catalogItemId,
    String designation,
    String unit,
    String quantity,
    String unitPriceHt,
    String vatRate,
    String totalHt,
    String totalVat,
    String totalTtc,
  });
}

/// @nodoc
class __$$QuoteLineImplCopyWithImpl<$Res>
    extends _$QuoteLineCopyWithImpl<$Res, _$QuoteLineImpl>
    implements _$$QuoteLineImplCopyWith<$Res> {
  __$$QuoteLineImplCopyWithImpl(
    _$QuoteLineImpl _value,
    $Res Function(_$QuoteLineImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of QuoteLine
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? catalogItemId = freezed,
    Object? designation = null,
    Object? unit = null,
    Object? quantity = null,
    Object? unitPriceHt = null,
    Object? vatRate = null,
    Object? totalHt = null,
    Object? totalVat = null,
    Object? totalTtc = null,
  }) {
    return _then(
      _$QuoteLineImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        catalogItemId: freezed == catalogItemId
            ? _value.catalogItemId
            : catalogItemId // ignore: cast_nullable_to_non_nullable
                  as String?,
        designation: null == designation
            ? _value.designation
            : designation // ignore: cast_nullable_to_non_nullable
                  as String,
        unit: null == unit
            ? _value.unit
            : unit // ignore: cast_nullable_to_non_nullable
                  as String,
        quantity: null == quantity
            ? _value.quantity
            : quantity // ignore: cast_nullable_to_non_nullable
                  as String,
        unitPriceHt: null == unitPriceHt
            ? _value.unitPriceHt
            : unitPriceHt // ignore: cast_nullable_to_non_nullable
                  as String,
        vatRate: null == vatRate
            ? _value.vatRate
            : vatRate // ignore: cast_nullable_to_non_nullable
                  as String,
        totalHt: null == totalHt
            ? _value.totalHt
            : totalHt // ignore: cast_nullable_to_non_nullable
                  as String,
        totalVat: null == totalVat
            ? _value.totalVat
            : totalVat // ignore: cast_nullable_to_non_nullable
                  as String,
        totalTtc: null == totalTtc
            ? _value.totalTtc
            : totalTtc // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$QuoteLineImpl implements _QuoteLine {
  const _$QuoteLineImpl({
    required this.id,
    this.catalogItemId,
    required this.designation,
    required this.unit,
    required this.quantity,
    required this.unitPriceHt,
    required this.vatRate,
    required this.totalHt,
    required this.totalVat,
    required this.totalTtc,
  });

  factory _$QuoteLineImpl.fromJson(Map<String, dynamic> json) =>
      _$$QuoteLineImplFromJson(json);

  @override
  final String id;
  // Null for a free line (décision 5), or once the catalog item behind a
  // line has been deleted (backend SET NULL). The snapshot below still holds.
  @override
  final String? catalogItemId;
  @override
  final String designation;
  @override
  final String unit;
  @override
  final String quantity;
  @override
  final String unitPriceHt;
  @override
  final String vatRate;
  @override
  final String totalHt;
  @override
  final String totalVat;
  @override
  final String totalTtc;

  @override
  String toString() {
    return 'QuoteLine(id: $id, catalogItemId: $catalogItemId, designation: $designation, unit: $unit, quantity: $quantity, unitPriceHt: $unitPriceHt, vatRate: $vatRate, totalHt: $totalHt, totalVat: $totalVat, totalTtc: $totalTtc)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuoteLineImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.catalogItemId, catalogItemId) ||
                other.catalogItemId == catalogItemId) &&
            (identical(other.designation, designation) ||
                other.designation == designation) &&
            (identical(other.unit, unit) || other.unit == unit) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.unitPriceHt, unitPriceHt) ||
                other.unitPriceHt == unitPriceHt) &&
            (identical(other.vatRate, vatRate) || other.vatRate == vatRate) &&
            (identical(other.totalHt, totalHt) || other.totalHt == totalHt) &&
            (identical(other.totalVat, totalVat) ||
                other.totalVat == totalVat) &&
            (identical(other.totalTtc, totalTtc) ||
                other.totalTtc == totalTtc));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    catalogItemId,
    designation,
    unit,
    quantity,
    unitPriceHt,
    vatRate,
    totalHt,
    totalVat,
    totalTtc,
  );

  /// Create a copy of QuoteLine
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QuoteLineImplCopyWith<_$QuoteLineImpl> get copyWith =>
      __$$QuoteLineImplCopyWithImpl<_$QuoteLineImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$QuoteLineImplToJson(this);
  }
}

abstract class _QuoteLine implements QuoteLine {
  const factory _QuoteLine({
    required final String id,
    final String? catalogItemId,
    required final String designation,
    required final String unit,
    required final String quantity,
    required final String unitPriceHt,
    required final String vatRate,
    required final String totalHt,
    required final String totalVat,
    required final String totalTtc,
  }) = _$QuoteLineImpl;

  factory _QuoteLine.fromJson(Map<String, dynamic> json) =
      _$QuoteLineImpl.fromJson;

  @override
  String get id; // Null for a free line (décision 5), or once the catalog item behind a
  // line has been deleted (backend SET NULL). The snapshot below still holds.
  @override
  String? get catalogItemId;
  @override
  String get designation;
  @override
  String get unit;
  @override
  String get quantity;
  @override
  String get unitPriceHt;
  @override
  String get vatRate;
  @override
  String get totalHt;
  @override
  String get totalVat;
  @override
  String get totalTtc;

  /// Create a copy of QuoteLine
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QuoteLineImplCopyWith<_$QuoteLineImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Quote _$QuoteFromJson(Map<String, dynamic> json) {
  return _Quote.fromJson(json);
}

/// @nodoc
mixin _$Quote {
  String get id => throw _privateConstructorUsedError;
  String get companyId => throw _privateConstructorUsedError;
  String get clientId => throw _privateConstructorUsedError;

  /// Objet du devis (V1.1 #6) — free-text subject, null when the quote has none.
  String? get object => throw _privateConstructorUsedError;

  /// "DEV-2026-0001" — what the artisan and their customer actually use.
  /// `id` is a UUID nobody reads out loud.
  String get quoteNumber => throw _privateConstructorUsedError;
  QuoteStatus get status =>
      throw _privateConstructorUsedError; // The GROSS subtotal (sum of the lines, before discount).
  String get totalHt => throw _privateConstructorUsedError;
  String get totalVat => throw _privateConstructorUsedError;
  String get totalTtc =>
      throw _privateConstructorUsedError; // Discount + deposit (V1.1 #3), all computed by the backend and
  // snapshotted. Net == gross with no discount; balanceDue == net TTC with
  // no deposit. Defaulted so a pre-V1.1.3 quote still parses.
  String? get discountType => throw _privateConstructorUsedError;
  String get discountValue => throw _privateConstructorUsedError;
  String get discountAmount => throw _privateConstructorUsedError;
  String get netTotalHt => throw _privateConstructorUsedError;
  String get netTotalVat => throw _privateConstructorUsedError;
  String get netTotalTtc => throw _privateConstructorUsedError;
  String? get depositType => throw _privateConstructorUsedError;
  String get depositValue => throw _privateConstructorUsedError;
  String get depositAmount => throw _privateConstructorUsedError;
  String get balanceDue => throw _privateConstructorUsedError;
  List<QuoteLine> get lines => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this Quote to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Quote
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QuoteCopyWith<Quote> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuoteCopyWith<$Res> {
  factory $QuoteCopyWith(Quote value, $Res Function(Quote) then) =
      _$QuoteCopyWithImpl<$Res, Quote>;
  @useResult
  $Res call({
    String id,
    String companyId,
    String clientId,
    String? object,
    String quoteNumber,
    QuoteStatus status,
    String totalHt,
    String totalVat,
    String totalTtc,
    String? discountType,
    String discountValue,
    String discountAmount,
    String netTotalHt,
    String netTotalVat,
    String netTotalTtc,
    String? depositType,
    String depositValue,
    String depositAmount,
    String balanceDue,
    List<QuoteLine> lines,
    DateTime createdAt,
    DateTime updatedAt,
  });
}

/// @nodoc
class _$QuoteCopyWithImpl<$Res, $Val extends Quote>
    implements $QuoteCopyWith<$Res> {
  _$QuoteCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Quote
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? companyId = null,
    Object? clientId = null,
    Object? object = freezed,
    Object? quoteNumber = null,
    Object? status = null,
    Object? totalHt = null,
    Object? totalVat = null,
    Object? totalTtc = null,
    Object? discountType = freezed,
    Object? discountValue = null,
    Object? discountAmount = null,
    Object? netTotalHt = null,
    Object? netTotalVat = null,
    Object? netTotalTtc = null,
    Object? depositType = freezed,
    Object? depositValue = null,
    Object? depositAmount = null,
    Object? balanceDue = null,
    Object? lines = null,
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
            clientId: null == clientId
                ? _value.clientId
                : clientId // ignore: cast_nullable_to_non_nullable
                      as String,
            object: freezed == object
                ? _value.object
                : object // ignore: cast_nullable_to_non_nullable
                      as String?,
            quoteNumber: null == quoteNumber
                ? _value.quoteNumber
                : quoteNumber // ignore: cast_nullable_to_non_nullable
                      as String,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as QuoteStatus,
            totalHt: null == totalHt
                ? _value.totalHt
                : totalHt // ignore: cast_nullable_to_non_nullable
                      as String,
            totalVat: null == totalVat
                ? _value.totalVat
                : totalVat // ignore: cast_nullable_to_non_nullable
                      as String,
            totalTtc: null == totalTtc
                ? _value.totalTtc
                : totalTtc // ignore: cast_nullable_to_non_nullable
                      as String,
            discountType: freezed == discountType
                ? _value.discountType
                : discountType // ignore: cast_nullable_to_non_nullable
                      as String?,
            discountValue: null == discountValue
                ? _value.discountValue
                : discountValue // ignore: cast_nullable_to_non_nullable
                      as String,
            discountAmount: null == discountAmount
                ? _value.discountAmount
                : discountAmount // ignore: cast_nullable_to_non_nullable
                      as String,
            netTotalHt: null == netTotalHt
                ? _value.netTotalHt
                : netTotalHt // ignore: cast_nullable_to_non_nullable
                      as String,
            netTotalVat: null == netTotalVat
                ? _value.netTotalVat
                : netTotalVat // ignore: cast_nullable_to_non_nullable
                      as String,
            netTotalTtc: null == netTotalTtc
                ? _value.netTotalTtc
                : netTotalTtc // ignore: cast_nullable_to_non_nullable
                      as String,
            depositType: freezed == depositType
                ? _value.depositType
                : depositType // ignore: cast_nullable_to_non_nullable
                      as String?,
            depositValue: null == depositValue
                ? _value.depositValue
                : depositValue // ignore: cast_nullable_to_non_nullable
                      as String,
            depositAmount: null == depositAmount
                ? _value.depositAmount
                : depositAmount // ignore: cast_nullable_to_non_nullable
                      as String,
            balanceDue: null == balanceDue
                ? _value.balanceDue
                : balanceDue // ignore: cast_nullable_to_non_nullable
                      as String,
            lines: null == lines
                ? _value.lines
                : lines // ignore: cast_nullable_to_non_nullable
                      as List<QuoteLine>,
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
abstract class _$$QuoteImplCopyWith<$Res> implements $QuoteCopyWith<$Res> {
  factory _$$QuoteImplCopyWith(
    _$QuoteImpl value,
    $Res Function(_$QuoteImpl) then,
  ) = __$$QuoteImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String companyId,
    String clientId,
    String? object,
    String quoteNumber,
    QuoteStatus status,
    String totalHt,
    String totalVat,
    String totalTtc,
    String? discountType,
    String discountValue,
    String discountAmount,
    String netTotalHt,
    String netTotalVat,
    String netTotalTtc,
    String? depositType,
    String depositValue,
    String depositAmount,
    String balanceDue,
    List<QuoteLine> lines,
    DateTime createdAt,
    DateTime updatedAt,
  });
}

/// @nodoc
class __$$QuoteImplCopyWithImpl<$Res>
    extends _$QuoteCopyWithImpl<$Res, _$QuoteImpl>
    implements _$$QuoteImplCopyWith<$Res> {
  __$$QuoteImplCopyWithImpl(
    _$QuoteImpl _value,
    $Res Function(_$QuoteImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Quote
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? companyId = null,
    Object? clientId = null,
    Object? object = freezed,
    Object? quoteNumber = null,
    Object? status = null,
    Object? totalHt = null,
    Object? totalVat = null,
    Object? totalTtc = null,
    Object? discountType = freezed,
    Object? discountValue = null,
    Object? discountAmount = null,
    Object? netTotalHt = null,
    Object? netTotalVat = null,
    Object? netTotalTtc = null,
    Object? depositType = freezed,
    Object? depositValue = null,
    Object? depositAmount = null,
    Object? balanceDue = null,
    Object? lines = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _$QuoteImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        companyId: null == companyId
            ? _value.companyId
            : companyId // ignore: cast_nullable_to_non_nullable
                  as String,
        clientId: null == clientId
            ? _value.clientId
            : clientId // ignore: cast_nullable_to_non_nullable
                  as String,
        object: freezed == object
            ? _value.object
            : object // ignore: cast_nullable_to_non_nullable
                  as String?,
        quoteNumber: null == quoteNumber
            ? _value.quoteNumber
            : quoteNumber // ignore: cast_nullable_to_non_nullable
                  as String,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as QuoteStatus,
        totalHt: null == totalHt
            ? _value.totalHt
            : totalHt // ignore: cast_nullable_to_non_nullable
                  as String,
        totalVat: null == totalVat
            ? _value.totalVat
            : totalVat // ignore: cast_nullable_to_non_nullable
                  as String,
        totalTtc: null == totalTtc
            ? _value.totalTtc
            : totalTtc // ignore: cast_nullable_to_non_nullable
                  as String,
        discountType: freezed == discountType
            ? _value.discountType
            : discountType // ignore: cast_nullable_to_non_nullable
                  as String?,
        discountValue: null == discountValue
            ? _value.discountValue
            : discountValue // ignore: cast_nullable_to_non_nullable
                  as String,
        discountAmount: null == discountAmount
            ? _value.discountAmount
            : discountAmount // ignore: cast_nullable_to_non_nullable
                  as String,
        netTotalHt: null == netTotalHt
            ? _value.netTotalHt
            : netTotalHt // ignore: cast_nullable_to_non_nullable
                  as String,
        netTotalVat: null == netTotalVat
            ? _value.netTotalVat
            : netTotalVat // ignore: cast_nullable_to_non_nullable
                  as String,
        netTotalTtc: null == netTotalTtc
            ? _value.netTotalTtc
            : netTotalTtc // ignore: cast_nullable_to_non_nullable
                  as String,
        depositType: freezed == depositType
            ? _value.depositType
            : depositType // ignore: cast_nullable_to_non_nullable
                  as String?,
        depositValue: null == depositValue
            ? _value.depositValue
            : depositValue // ignore: cast_nullable_to_non_nullable
                  as String,
        depositAmount: null == depositAmount
            ? _value.depositAmount
            : depositAmount // ignore: cast_nullable_to_non_nullable
                  as String,
        balanceDue: null == balanceDue
            ? _value.balanceDue
            : balanceDue // ignore: cast_nullable_to_non_nullable
                  as String,
        lines: null == lines
            ? _value._lines
            : lines // ignore: cast_nullable_to_non_nullable
                  as List<QuoteLine>,
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
class _$QuoteImpl implements _Quote {
  const _$QuoteImpl({
    required this.id,
    required this.companyId,
    required this.clientId,
    this.object,
    required this.quoteNumber,
    required this.status,
    required this.totalHt,
    required this.totalVat,
    required this.totalTtc,
    this.discountType,
    this.discountValue = '0.00',
    this.discountAmount = '0.00',
    this.netTotalHt = '0.00',
    this.netTotalVat = '0.00',
    this.netTotalTtc = '0.00',
    this.depositType,
    this.depositValue = '0.00',
    this.depositAmount = '0.00',
    this.balanceDue = '0.00',
    required final List<QuoteLine> lines,
    required this.createdAt,
    required this.updatedAt,
  }) : _lines = lines;

  factory _$QuoteImpl.fromJson(Map<String, dynamic> json) =>
      _$$QuoteImplFromJson(json);

  @override
  final String id;
  @override
  final String companyId;
  @override
  final String clientId;

  /// Objet du devis (V1.1 #6) — free-text subject, null when the quote has none.
  @override
  final String? object;

  /// "DEV-2026-0001" — what the artisan and their customer actually use.
  /// `id` is a UUID nobody reads out loud.
  @override
  final String quoteNumber;
  @override
  final QuoteStatus status;
  // The GROSS subtotal (sum of the lines, before discount).
  @override
  final String totalHt;
  @override
  final String totalVat;
  @override
  final String totalTtc;
  // Discount + deposit (V1.1 #3), all computed by the backend and
  // snapshotted. Net == gross with no discount; balanceDue == net TTC with
  // no deposit. Defaulted so a pre-V1.1.3 quote still parses.
  @override
  final String? discountType;
  @override
  @JsonKey()
  final String discountValue;
  @override
  @JsonKey()
  final String discountAmount;
  @override
  @JsonKey()
  final String netTotalHt;
  @override
  @JsonKey()
  final String netTotalVat;
  @override
  @JsonKey()
  final String netTotalTtc;
  @override
  final String? depositType;
  @override
  @JsonKey()
  final String depositValue;
  @override
  @JsonKey()
  final String depositAmount;
  @override
  @JsonKey()
  final String balanceDue;
  final List<QuoteLine> _lines;
  @override
  List<QuoteLine> get lines {
    if (_lines is EqualUnmodifiableListView) return _lines;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_lines);
  }

  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'Quote(id: $id, companyId: $companyId, clientId: $clientId, object: $object, quoteNumber: $quoteNumber, status: $status, totalHt: $totalHt, totalVat: $totalVat, totalTtc: $totalTtc, discountType: $discountType, discountValue: $discountValue, discountAmount: $discountAmount, netTotalHt: $netTotalHt, netTotalVat: $netTotalVat, netTotalTtc: $netTotalTtc, depositType: $depositType, depositValue: $depositValue, depositAmount: $depositAmount, balanceDue: $balanceDue, lines: $lines, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuoteImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.companyId, companyId) ||
                other.companyId == companyId) &&
            (identical(other.clientId, clientId) ||
                other.clientId == clientId) &&
            (identical(other.object, object) || other.object == object) &&
            (identical(other.quoteNumber, quoteNumber) ||
                other.quoteNumber == quoteNumber) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.totalHt, totalHt) || other.totalHt == totalHt) &&
            (identical(other.totalVat, totalVat) ||
                other.totalVat == totalVat) &&
            (identical(other.totalTtc, totalTtc) ||
                other.totalTtc == totalTtc) &&
            (identical(other.discountType, discountType) ||
                other.discountType == discountType) &&
            (identical(other.discountValue, discountValue) ||
                other.discountValue == discountValue) &&
            (identical(other.discountAmount, discountAmount) ||
                other.discountAmount == discountAmount) &&
            (identical(other.netTotalHt, netTotalHt) ||
                other.netTotalHt == netTotalHt) &&
            (identical(other.netTotalVat, netTotalVat) ||
                other.netTotalVat == netTotalVat) &&
            (identical(other.netTotalTtc, netTotalTtc) ||
                other.netTotalTtc == netTotalTtc) &&
            (identical(other.depositType, depositType) ||
                other.depositType == depositType) &&
            (identical(other.depositValue, depositValue) ||
                other.depositValue == depositValue) &&
            (identical(other.depositAmount, depositAmount) ||
                other.depositAmount == depositAmount) &&
            (identical(other.balanceDue, balanceDue) ||
                other.balanceDue == balanceDue) &&
            const DeepCollectionEquality().equals(other._lines, _lines) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    id,
    companyId,
    clientId,
    object,
    quoteNumber,
    status,
    totalHt,
    totalVat,
    totalTtc,
    discountType,
    discountValue,
    discountAmount,
    netTotalHt,
    netTotalVat,
    netTotalTtc,
    depositType,
    depositValue,
    depositAmount,
    balanceDue,
    const DeepCollectionEquality().hash(_lines),
    createdAt,
    updatedAt,
  ]);

  /// Create a copy of Quote
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QuoteImplCopyWith<_$QuoteImpl> get copyWith =>
      __$$QuoteImplCopyWithImpl<_$QuoteImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$QuoteImplToJson(this);
  }
}

abstract class _Quote implements Quote {
  const factory _Quote({
    required final String id,
    required final String companyId,
    required final String clientId,
    final String? object,
    required final String quoteNumber,
    required final QuoteStatus status,
    required final String totalHt,
    required final String totalVat,
    required final String totalTtc,
    final String? discountType,
    final String discountValue,
    final String discountAmount,
    final String netTotalHt,
    final String netTotalVat,
    final String netTotalTtc,
    final String? depositType,
    final String depositValue,
    final String depositAmount,
    final String balanceDue,
    required final List<QuoteLine> lines,
    required final DateTime createdAt,
    required final DateTime updatedAt,
  }) = _$QuoteImpl;

  factory _Quote.fromJson(Map<String, dynamic> json) = _$QuoteImpl.fromJson;

  @override
  String get id;
  @override
  String get companyId;
  @override
  String get clientId;

  /// Objet du devis (V1.1 #6) — free-text subject, null when the quote has none.
  @override
  String? get object;

  /// "DEV-2026-0001" — what the artisan and their customer actually use.
  /// `id` is a UUID nobody reads out loud.
  @override
  String get quoteNumber;
  @override
  QuoteStatus get status; // The GROSS subtotal (sum of the lines, before discount).
  @override
  String get totalHt;
  @override
  String get totalVat;
  @override
  String get totalTtc; // Discount + deposit (V1.1 #3), all computed by the backend and
  // snapshotted. Net == gross with no discount; balanceDue == net TTC with
  // no deposit. Defaulted so a pre-V1.1.3 quote still parses.
  @override
  String? get discountType;
  @override
  String get discountValue;
  @override
  String get discountAmount;
  @override
  String get netTotalHt;
  @override
  String get netTotalVat;
  @override
  String get netTotalTtc;
  @override
  String? get depositType;
  @override
  String get depositValue;
  @override
  String get depositAmount;
  @override
  String get balanceDue;
  @override
  List<QuoteLine> get lines;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;

  /// Create a copy of Quote
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QuoteImplCopyWith<_$QuoteImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

QuoteLineInput _$QuoteLineInputFromJson(Map<String, dynamic> json) {
  return _QuoteLineInput.fromJson(json);
}

/// @nodoc
mixin _$QuoteLineInput {
  String? get catalogItemId => throw _privateConstructorUsedError;
  String get quantity => throw _privateConstructorUsedError;
  String? get designation => throw _privateConstructorUsedError;
  String? get unit => throw _privateConstructorUsedError;
  String? get unitPriceHt => throw _privateConstructorUsedError;
  String? get vatRate => throw _privateConstructorUsedError;

  /// Serializes this QuoteLineInput to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of QuoteLineInput
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QuoteLineInputCopyWith<QuoteLineInput> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuoteLineInputCopyWith<$Res> {
  factory $QuoteLineInputCopyWith(
    QuoteLineInput value,
    $Res Function(QuoteLineInput) then,
  ) = _$QuoteLineInputCopyWithImpl<$Res, QuoteLineInput>;
  @useResult
  $Res call({
    String? catalogItemId,
    String quantity,
    String? designation,
    String? unit,
    String? unitPriceHt,
    String? vatRate,
  });
}

/// @nodoc
class _$QuoteLineInputCopyWithImpl<$Res, $Val extends QuoteLineInput>
    implements $QuoteLineInputCopyWith<$Res> {
  _$QuoteLineInputCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of QuoteLineInput
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? catalogItemId = freezed,
    Object? quantity = null,
    Object? designation = freezed,
    Object? unit = freezed,
    Object? unitPriceHt = freezed,
    Object? vatRate = freezed,
  }) {
    return _then(
      _value.copyWith(
            catalogItemId: freezed == catalogItemId
                ? _value.catalogItemId
                : catalogItemId // ignore: cast_nullable_to_non_nullable
                      as String?,
            quantity: null == quantity
                ? _value.quantity
                : quantity // ignore: cast_nullable_to_non_nullable
                      as String,
            designation: freezed == designation
                ? _value.designation
                : designation // ignore: cast_nullable_to_non_nullable
                      as String?,
            unit: freezed == unit
                ? _value.unit
                : unit // ignore: cast_nullable_to_non_nullable
                      as String?,
            unitPriceHt: freezed == unitPriceHt
                ? _value.unitPriceHt
                : unitPriceHt // ignore: cast_nullable_to_non_nullable
                      as String?,
            vatRate: freezed == vatRate
                ? _value.vatRate
                : vatRate // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$QuoteLineInputImplCopyWith<$Res>
    implements $QuoteLineInputCopyWith<$Res> {
  factory _$$QuoteLineInputImplCopyWith(
    _$QuoteLineInputImpl value,
    $Res Function(_$QuoteLineInputImpl) then,
  ) = __$$QuoteLineInputImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? catalogItemId,
    String quantity,
    String? designation,
    String? unit,
    String? unitPriceHt,
    String? vatRate,
  });
}

/// @nodoc
class __$$QuoteLineInputImplCopyWithImpl<$Res>
    extends _$QuoteLineInputCopyWithImpl<$Res, _$QuoteLineInputImpl>
    implements _$$QuoteLineInputImplCopyWith<$Res> {
  __$$QuoteLineInputImplCopyWithImpl(
    _$QuoteLineInputImpl _value,
    $Res Function(_$QuoteLineInputImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of QuoteLineInput
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? catalogItemId = freezed,
    Object? quantity = null,
    Object? designation = freezed,
    Object? unit = freezed,
    Object? unitPriceHt = freezed,
    Object? vatRate = freezed,
  }) {
    return _then(
      _$QuoteLineInputImpl(
        catalogItemId: freezed == catalogItemId
            ? _value.catalogItemId
            : catalogItemId // ignore: cast_nullable_to_non_nullable
                  as String?,
        quantity: null == quantity
            ? _value.quantity
            : quantity // ignore: cast_nullable_to_non_nullable
                  as String,
        designation: freezed == designation
            ? _value.designation
            : designation // ignore: cast_nullable_to_non_nullable
                  as String?,
        unit: freezed == unit
            ? _value.unit
            : unit // ignore: cast_nullable_to_non_nullable
                  as String?,
        unitPriceHt: freezed == unitPriceHt
            ? _value.unitPriceHt
            : unitPriceHt // ignore: cast_nullable_to_non_nullable
                  as String?,
        vatRate: freezed == vatRate
            ? _value.vatRate
            : vatRate // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$QuoteLineInputImpl implements _QuoteLineInput {
  const _$QuoteLineInputImpl({
    this.catalogItemId,
    required this.quantity,
    this.designation,
    this.unit,
    this.unitPriceHt,
    this.vatRate,
  });

  factory _$QuoteLineInputImpl.fromJson(Map<String, dynamic> json) =>
      _$$QuoteLineInputImplFromJson(json);

  @override
  final String? catalogItemId;
  @override
  final String quantity;
  @override
  final String? designation;
  @override
  final String? unit;
  @override
  final String? unitPriceHt;
  @override
  final String? vatRate;

  @override
  String toString() {
    return 'QuoteLineInput(catalogItemId: $catalogItemId, quantity: $quantity, designation: $designation, unit: $unit, unitPriceHt: $unitPriceHt, vatRate: $vatRate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuoteLineInputImpl &&
            (identical(other.catalogItemId, catalogItemId) ||
                other.catalogItemId == catalogItemId) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.designation, designation) ||
                other.designation == designation) &&
            (identical(other.unit, unit) || other.unit == unit) &&
            (identical(other.unitPriceHt, unitPriceHt) ||
                other.unitPriceHt == unitPriceHt) &&
            (identical(other.vatRate, vatRate) || other.vatRate == vatRate));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    catalogItemId,
    quantity,
    designation,
    unit,
    unitPriceHt,
    vatRate,
  );

  /// Create a copy of QuoteLineInput
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QuoteLineInputImplCopyWith<_$QuoteLineInputImpl> get copyWith =>
      __$$QuoteLineInputImplCopyWithImpl<_$QuoteLineInputImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$QuoteLineInputImplToJson(this);
  }
}

abstract class _QuoteLineInput implements QuoteLineInput {
  const factory _QuoteLineInput({
    final String? catalogItemId,
    required final String quantity,
    final String? designation,
    final String? unit,
    final String? unitPriceHt,
    final String? vatRate,
  }) = _$QuoteLineInputImpl;

  factory _QuoteLineInput.fromJson(Map<String, dynamic> json) =
      _$QuoteLineInputImpl.fromJson;

  @override
  String? get catalogItemId;
  @override
  String get quantity;
  @override
  String? get designation;
  @override
  String? get unit;
  @override
  String? get unitPriceHt;
  @override
  String? get vatRate;

  /// Create a copy of QuoteLineInput
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QuoteLineInputImplCopyWith<_$QuoteLineInputImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
