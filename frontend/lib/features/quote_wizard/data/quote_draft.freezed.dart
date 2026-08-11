// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'quote_draft.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$DraftLine {
  /// Stable identity of the line within the draft. For a catalog line it is
  /// the catalog item's id (so ticking the same article twice bumps its
  /// quantity rather than duplicating it); for a free line it is a generated
  /// key ([newFreeLineId]), so two free lines never collapse into one.
  String get id => throw _privateConstructorUsedError;

  /// Null for a free line — décision 5.
  String? get catalogItemId => throw _privateConstructorUsedError;
  String get designation => throw _privateConstructorUsedError;
  String get unit => throw _privateConstructorUsedError;
  num get quantity => throw _privateConstructorUsedError;
  String get unitPriceHt => throw _privateConstructorUsedError;
  String get vatRate => throw _privateConstructorUsedError;

  /// True once the artisan set a price different from the catalog's. Only
  /// then does the override travel to the backend for a catalog line — an
  /// untouched catalog line sends no price, so the server re-reads the
  /// current catalog price exactly as before this feature.
  bool get priceOverridden => throw _privateConstructorUsedError;

  /// Create a copy of DraftLine
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DraftLineCopyWith<DraftLine> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DraftLineCopyWith<$Res> {
  factory $DraftLineCopyWith(DraftLine value, $Res Function(DraftLine) then) =
      _$DraftLineCopyWithImpl<$Res, DraftLine>;
  @useResult
  $Res call({
    String id,
    String? catalogItemId,
    String designation,
    String unit,
    num quantity,
    String unitPriceHt,
    String vatRate,
    bool priceOverridden,
  });
}

/// @nodoc
class _$DraftLineCopyWithImpl<$Res, $Val extends DraftLine>
    implements $DraftLineCopyWith<$Res> {
  _$DraftLineCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DraftLine
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
    Object? priceOverridden = null,
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
                      as num,
            unitPriceHt: null == unitPriceHt
                ? _value.unitPriceHt
                : unitPriceHt // ignore: cast_nullable_to_non_nullable
                      as String,
            vatRate: null == vatRate
                ? _value.vatRate
                : vatRate // ignore: cast_nullable_to_non_nullable
                      as String,
            priceOverridden: null == priceOverridden
                ? _value.priceOverridden
                : priceOverridden // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DraftLineImplCopyWith<$Res>
    implements $DraftLineCopyWith<$Res> {
  factory _$$DraftLineImplCopyWith(
    _$DraftLineImpl value,
    $Res Function(_$DraftLineImpl) then,
  ) = __$$DraftLineImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String? catalogItemId,
    String designation,
    String unit,
    num quantity,
    String unitPriceHt,
    String vatRate,
    bool priceOverridden,
  });
}

/// @nodoc
class __$$DraftLineImplCopyWithImpl<$Res>
    extends _$DraftLineCopyWithImpl<$Res, _$DraftLineImpl>
    implements _$$DraftLineImplCopyWith<$Res> {
  __$$DraftLineImplCopyWithImpl(
    _$DraftLineImpl _value,
    $Res Function(_$DraftLineImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DraftLine
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
    Object? priceOverridden = null,
  }) {
    return _then(
      _$DraftLineImpl(
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
                  as num,
        unitPriceHt: null == unitPriceHt
            ? _value.unitPriceHt
            : unitPriceHt // ignore: cast_nullable_to_non_nullable
                  as String,
        vatRate: null == vatRate
            ? _value.vatRate
            : vatRate // ignore: cast_nullable_to_non_nullable
                  as String,
        priceOverridden: null == priceOverridden
            ? _value.priceOverridden
            : priceOverridden // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _$DraftLineImpl implements _DraftLine {
  const _$DraftLineImpl({
    required this.id,
    this.catalogItemId,
    required this.designation,
    required this.unit,
    required this.quantity,
    required this.unitPriceHt,
    required this.vatRate,
    this.priceOverridden = false,
  });

  /// Stable identity of the line within the draft. For a catalog line it is
  /// the catalog item's id (so ticking the same article twice bumps its
  /// quantity rather than duplicating it); for a free line it is a generated
  /// key ([newFreeLineId]), so two free lines never collapse into one.
  @override
  final String id;

  /// Null for a free line — décision 5.
  @override
  final String? catalogItemId;
  @override
  final String designation;
  @override
  final String unit;
  @override
  final num quantity;
  @override
  final String unitPriceHt;
  @override
  final String vatRate;

  /// True once the artisan set a price different from the catalog's. Only
  /// then does the override travel to the backend for a catalog line — an
  /// untouched catalog line sends no price, so the server re-reads the
  /// current catalog price exactly as before this feature.
  @override
  @JsonKey()
  final bool priceOverridden;

  @override
  String toString() {
    return 'DraftLine(id: $id, catalogItemId: $catalogItemId, designation: $designation, unit: $unit, quantity: $quantity, unitPriceHt: $unitPriceHt, vatRate: $vatRate, priceOverridden: $priceOverridden)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DraftLineImpl &&
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
            (identical(other.priceOverridden, priceOverridden) ||
                other.priceOverridden == priceOverridden));
  }

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
    priceOverridden,
  );

  /// Create a copy of DraftLine
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DraftLineImplCopyWith<_$DraftLineImpl> get copyWith =>
      __$$DraftLineImplCopyWithImpl<_$DraftLineImpl>(this, _$identity);
}

abstract class _DraftLine implements DraftLine {
  const factory _DraftLine({
    required final String id,
    final String? catalogItemId,
    required final String designation,
    required final String unit,
    required final num quantity,
    required final String unitPriceHt,
    required final String vatRate,
    final bool priceOverridden,
  }) = _$DraftLineImpl;

  /// Stable identity of the line within the draft. For a catalog line it is
  /// the catalog item's id (so ticking the same article twice bumps its
  /// quantity rather than duplicating it); for a free line it is a generated
  /// key ([newFreeLineId]), so two free lines never collapse into one.
  @override
  String get id;

  /// Null for a free line — décision 5.
  @override
  String? get catalogItemId;
  @override
  String get designation;
  @override
  String get unit;
  @override
  num get quantity;
  @override
  String get unitPriceHt;
  @override
  String get vatRate;

  /// True once the artisan set a price different from the catalog's. Only
  /// then does the override travel to the backend for a catalog line — an
  /// untouched catalog line sends no price, so the server re-reads the
  /// current catalog price exactly as before this feature.
  @override
  bool get priceOverridden;

  /// Create a copy of DraftLine
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DraftLineImplCopyWith<_$DraftLineImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$QuoteDraft {
  String? get clientId => throw _privateConstructorUsedError;
  String? get clientLabel => throw _privateConstructorUsedError;

  /// Objet du devis (V1.1 #6) — free-text subject the artisan types at the
  /// Personnaliser step. Null when empty. Persisted with the quote (unlike the
  /// folder, which is navigation only — décision P4.3).
  String? get object => throw _privateConstructorUsedError;
  List<DraftLine> get lines => throw _privateConstructorUsedError;
  QuoteCalculation? get calculation => throw _privateConstructorUsedError;

  /// Discount + deposit the artisan set (décision 5: quote-level, not lines).
  /// ``*Type`` is `'percent'` | `'amount'` | null; ``*Value`` is the entered
  /// percentage or euro amount, as a string like the rest of the draft. The
  /// backend computes every amount — these are only the inputs it is sent.
  String? get discountType => throw _privateConstructorUsedError;
  String? get discountValue => throw _privateConstructorUsedError;
  String? get depositType => throw _privateConstructorUsedError;
  String? get depositValue => throw _privateConstructorUsedError;

  /// Create a copy of QuoteDraft
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QuoteDraftCopyWith<QuoteDraft> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuoteDraftCopyWith<$Res> {
  factory $QuoteDraftCopyWith(
    QuoteDraft value,
    $Res Function(QuoteDraft) then,
  ) = _$QuoteDraftCopyWithImpl<$Res, QuoteDraft>;
  @useResult
  $Res call({
    String? clientId,
    String? clientLabel,
    String? object,
    List<DraftLine> lines,
    QuoteCalculation? calculation,
    String? discountType,
    String? discountValue,
    String? depositType,
    String? depositValue,
  });

  $QuoteCalculationCopyWith<$Res>? get calculation;
}

/// @nodoc
class _$QuoteDraftCopyWithImpl<$Res, $Val extends QuoteDraft>
    implements $QuoteDraftCopyWith<$Res> {
  _$QuoteDraftCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of QuoteDraft
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? clientId = freezed,
    Object? clientLabel = freezed,
    Object? object = freezed,
    Object? lines = null,
    Object? calculation = freezed,
    Object? discountType = freezed,
    Object? discountValue = freezed,
    Object? depositType = freezed,
    Object? depositValue = freezed,
  }) {
    return _then(
      _value.copyWith(
            clientId: freezed == clientId
                ? _value.clientId
                : clientId // ignore: cast_nullable_to_non_nullable
                      as String?,
            clientLabel: freezed == clientLabel
                ? _value.clientLabel
                : clientLabel // ignore: cast_nullable_to_non_nullable
                      as String?,
            object: freezed == object
                ? _value.object
                : object // ignore: cast_nullable_to_non_nullable
                      as String?,
            lines: null == lines
                ? _value.lines
                : lines // ignore: cast_nullable_to_non_nullable
                      as List<DraftLine>,
            calculation: freezed == calculation
                ? _value.calculation
                : calculation // ignore: cast_nullable_to_non_nullable
                      as QuoteCalculation?,
            discountType: freezed == discountType
                ? _value.discountType
                : discountType // ignore: cast_nullable_to_non_nullable
                      as String?,
            discountValue: freezed == discountValue
                ? _value.discountValue
                : discountValue // ignore: cast_nullable_to_non_nullable
                      as String?,
            depositType: freezed == depositType
                ? _value.depositType
                : depositType // ignore: cast_nullable_to_non_nullable
                      as String?,
            depositValue: freezed == depositValue
                ? _value.depositValue
                : depositValue // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }

  /// Create a copy of QuoteDraft
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $QuoteCalculationCopyWith<$Res>? get calculation {
    if (_value.calculation == null) {
      return null;
    }

    return $QuoteCalculationCopyWith<$Res>(_value.calculation!, (value) {
      return _then(_value.copyWith(calculation: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$QuoteDraftImplCopyWith<$Res>
    implements $QuoteDraftCopyWith<$Res> {
  factory _$$QuoteDraftImplCopyWith(
    _$QuoteDraftImpl value,
    $Res Function(_$QuoteDraftImpl) then,
  ) = __$$QuoteDraftImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? clientId,
    String? clientLabel,
    String? object,
    List<DraftLine> lines,
    QuoteCalculation? calculation,
    String? discountType,
    String? discountValue,
    String? depositType,
    String? depositValue,
  });

  @override
  $QuoteCalculationCopyWith<$Res>? get calculation;
}

/// @nodoc
class __$$QuoteDraftImplCopyWithImpl<$Res>
    extends _$QuoteDraftCopyWithImpl<$Res, _$QuoteDraftImpl>
    implements _$$QuoteDraftImplCopyWith<$Res> {
  __$$QuoteDraftImplCopyWithImpl(
    _$QuoteDraftImpl _value,
    $Res Function(_$QuoteDraftImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of QuoteDraft
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? clientId = freezed,
    Object? clientLabel = freezed,
    Object? object = freezed,
    Object? lines = null,
    Object? calculation = freezed,
    Object? discountType = freezed,
    Object? discountValue = freezed,
    Object? depositType = freezed,
    Object? depositValue = freezed,
  }) {
    return _then(
      _$QuoteDraftImpl(
        clientId: freezed == clientId
            ? _value.clientId
            : clientId // ignore: cast_nullable_to_non_nullable
                  as String?,
        clientLabel: freezed == clientLabel
            ? _value.clientLabel
            : clientLabel // ignore: cast_nullable_to_non_nullable
                  as String?,
        object: freezed == object
            ? _value.object
            : object // ignore: cast_nullable_to_non_nullable
                  as String?,
        lines: null == lines
            ? _value._lines
            : lines // ignore: cast_nullable_to_non_nullable
                  as List<DraftLine>,
        calculation: freezed == calculation
            ? _value.calculation
            : calculation // ignore: cast_nullable_to_non_nullable
                  as QuoteCalculation?,
        discountType: freezed == discountType
            ? _value.discountType
            : discountType // ignore: cast_nullable_to_non_nullable
                  as String?,
        discountValue: freezed == discountValue
            ? _value.discountValue
            : discountValue // ignore: cast_nullable_to_non_nullable
                  as String?,
        depositType: freezed == depositType
            ? _value.depositType
            : depositType // ignore: cast_nullable_to_non_nullable
                  as String?,
        depositValue: freezed == depositValue
            ? _value.depositValue
            : depositValue // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$QuoteDraftImpl extends _QuoteDraft {
  const _$QuoteDraftImpl({
    this.clientId,
    this.clientLabel,
    this.object,
    final List<DraftLine> lines = const <DraftLine>[],
    this.calculation,
    this.discountType,
    this.discountValue,
    this.depositType,
    this.depositValue,
  }) : _lines = lines,
       super._();

  @override
  final String? clientId;
  @override
  final String? clientLabel;

  /// Objet du devis (V1.1 #6) — free-text subject the artisan types at the
  /// Personnaliser step. Null when empty. Persisted with the quote (unlike the
  /// folder, which is navigation only — décision P4.3).
  @override
  final String? object;
  final List<DraftLine> _lines;
  @override
  @JsonKey()
  List<DraftLine> get lines {
    if (_lines is EqualUnmodifiableListView) return _lines;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_lines);
  }

  @override
  final QuoteCalculation? calculation;

  /// Discount + deposit the artisan set (décision 5: quote-level, not lines).
  /// ``*Type`` is `'percent'` | `'amount'` | null; ``*Value`` is the entered
  /// percentage or euro amount, as a string like the rest of the draft. The
  /// backend computes every amount — these are only the inputs it is sent.
  @override
  final String? discountType;
  @override
  final String? discountValue;
  @override
  final String? depositType;
  @override
  final String? depositValue;

  @override
  String toString() {
    return 'QuoteDraft(clientId: $clientId, clientLabel: $clientLabel, object: $object, lines: $lines, calculation: $calculation, discountType: $discountType, discountValue: $discountValue, depositType: $depositType, depositValue: $depositValue)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuoteDraftImpl &&
            (identical(other.clientId, clientId) ||
                other.clientId == clientId) &&
            (identical(other.clientLabel, clientLabel) ||
                other.clientLabel == clientLabel) &&
            (identical(other.object, object) || other.object == object) &&
            const DeepCollectionEquality().equals(other._lines, _lines) &&
            (identical(other.calculation, calculation) ||
                other.calculation == calculation) &&
            (identical(other.discountType, discountType) ||
                other.discountType == discountType) &&
            (identical(other.discountValue, discountValue) ||
                other.discountValue == discountValue) &&
            (identical(other.depositType, depositType) ||
                other.depositType == depositType) &&
            (identical(other.depositValue, depositValue) ||
                other.depositValue == depositValue));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    clientId,
    clientLabel,
    object,
    const DeepCollectionEquality().hash(_lines),
    calculation,
    discountType,
    discountValue,
    depositType,
    depositValue,
  );

  /// Create a copy of QuoteDraft
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QuoteDraftImplCopyWith<_$QuoteDraftImpl> get copyWith =>
      __$$QuoteDraftImplCopyWithImpl<_$QuoteDraftImpl>(this, _$identity);
}

abstract class _QuoteDraft extends QuoteDraft {
  const factory _QuoteDraft({
    final String? clientId,
    final String? clientLabel,
    final String? object,
    final List<DraftLine> lines,
    final QuoteCalculation? calculation,
    final String? discountType,
    final String? discountValue,
    final String? depositType,
    final String? depositValue,
  }) = _$QuoteDraftImpl;
  const _QuoteDraft._() : super._();

  @override
  String? get clientId;
  @override
  String? get clientLabel;

  /// Objet du devis (V1.1 #6) — free-text subject the artisan types at the
  /// Personnaliser step. Null when empty. Persisted with the quote (unlike the
  /// folder, which is navigation only — décision P4.3).
  @override
  String? get object;
  @override
  List<DraftLine> get lines;
  @override
  QuoteCalculation? get calculation;

  /// Discount + deposit the artisan set (décision 5: quote-level, not lines).
  /// ``*Type`` is `'percent'` | `'amount'` | null; ``*Value`` is the entered
  /// percentage or euro amount, as a string like the rest of the draft. The
  /// backend computes every amount — these are only the inputs it is sent.
  @override
  String? get discountType;
  @override
  String? get discountValue;
  @override
  String? get depositType;
  @override
  String? get depositValue;

  /// Create a copy of QuoteDraft
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QuoteDraftImplCopyWith<_$QuoteDraftImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
