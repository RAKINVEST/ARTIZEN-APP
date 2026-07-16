// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'quote_suggestion_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

QuoteSuggestionItem _$QuoteSuggestionItemFromJson(Map<String, dynamic> json) {
  return _QuoteSuggestionItem.fromJson(json);
}

/// @nodoc
mixin _$QuoteSuggestionItem {
  String get catalogItemId => throw _privateConstructorUsedError;
  String get designation => throw _privateConstructorUsedError;
  String get quantity => throw _privateConstructorUsedError;
  String get reason => throw _privateConstructorUsedError;

  /// Serializes this QuoteSuggestionItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of QuoteSuggestionItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QuoteSuggestionItemCopyWith<QuoteSuggestionItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuoteSuggestionItemCopyWith<$Res> {
  factory $QuoteSuggestionItemCopyWith(
    QuoteSuggestionItem value,
    $Res Function(QuoteSuggestionItem) then,
  ) = _$QuoteSuggestionItemCopyWithImpl<$Res, QuoteSuggestionItem>;
  @useResult
  $Res call({
    String catalogItemId,
    String designation,
    String quantity,
    String reason,
  });
}

/// @nodoc
class _$QuoteSuggestionItemCopyWithImpl<$Res, $Val extends QuoteSuggestionItem>
    implements $QuoteSuggestionItemCopyWith<$Res> {
  _$QuoteSuggestionItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of QuoteSuggestionItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? catalogItemId = null,
    Object? designation = null,
    Object? quantity = null,
    Object? reason = null,
  }) {
    return _then(
      _value.copyWith(
            catalogItemId: null == catalogItemId
                ? _value.catalogItemId
                : catalogItemId // ignore: cast_nullable_to_non_nullable
                      as String,
            designation: null == designation
                ? _value.designation
                : designation // ignore: cast_nullable_to_non_nullable
                      as String,
            quantity: null == quantity
                ? _value.quantity
                : quantity // ignore: cast_nullable_to_non_nullable
                      as String,
            reason: null == reason
                ? _value.reason
                : reason // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$QuoteSuggestionItemImplCopyWith<$Res>
    implements $QuoteSuggestionItemCopyWith<$Res> {
  factory _$$QuoteSuggestionItemImplCopyWith(
    _$QuoteSuggestionItemImpl value,
    $Res Function(_$QuoteSuggestionItemImpl) then,
  ) = __$$QuoteSuggestionItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String catalogItemId,
    String designation,
    String quantity,
    String reason,
  });
}

/// @nodoc
class __$$QuoteSuggestionItemImplCopyWithImpl<$Res>
    extends _$QuoteSuggestionItemCopyWithImpl<$Res, _$QuoteSuggestionItemImpl>
    implements _$$QuoteSuggestionItemImplCopyWith<$Res> {
  __$$QuoteSuggestionItemImplCopyWithImpl(
    _$QuoteSuggestionItemImpl _value,
    $Res Function(_$QuoteSuggestionItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of QuoteSuggestionItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? catalogItemId = null,
    Object? designation = null,
    Object? quantity = null,
    Object? reason = null,
  }) {
    return _then(
      _$QuoteSuggestionItemImpl(
        catalogItemId: null == catalogItemId
            ? _value.catalogItemId
            : catalogItemId // ignore: cast_nullable_to_non_nullable
                  as String,
        designation: null == designation
            ? _value.designation
            : designation // ignore: cast_nullable_to_non_nullable
                  as String,
        quantity: null == quantity
            ? _value.quantity
            : quantity // ignore: cast_nullable_to_non_nullable
                  as String,
        reason: null == reason
            ? _value.reason
            : reason // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$QuoteSuggestionItemImpl implements _QuoteSuggestionItem {
  const _$QuoteSuggestionItemImpl({
    required this.catalogItemId,
    required this.designation,
    required this.quantity,
    required this.reason,
  });

  factory _$QuoteSuggestionItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$QuoteSuggestionItemImplFromJson(json);

  @override
  final String catalogItemId;
  @override
  final String designation;
  @override
  final String quantity;
  @override
  final String reason;

  @override
  String toString() {
    return 'QuoteSuggestionItem(catalogItemId: $catalogItemId, designation: $designation, quantity: $quantity, reason: $reason)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuoteSuggestionItemImpl &&
            (identical(other.catalogItemId, catalogItemId) ||
                other.catalogItemId == catalogItemId) &&
            (identical(other.designation, designation) ||
                other.designation == designation) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.reason, reason) || other.reason == reason));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, catalogItemId, designation, quantity, reason);

  /// Create a copy of QuoteSuggestionItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QuoteSuggestionItemImplCopyWith<_$QuoteSuggestionItemImpl> get copyWith =>
      __$$QuoteSuggestionItemImplCopyWithImpl<_$QuoteSuggestionItemImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$QuoteSuggestionItemImplToJson(this);
  }
}

abstract class _QuoteSuggestionItem implements QuoteSuggestionItem {
  const factory _QuoteSuggestionItem({
    required final String catalogItemId,
    required final String designation,
    required final String quantity,
    required final String reason,
  }) = _$QuoteSuggestionItemImpl;

  factory _QuoteSuggestionItem.fromJson(Map<String, dynamic> json) =
      _$QuoteSuggestionItemImpl.fromJson;

  @override
  String get catalogItemId;
  @override
  String get designation;
  @override
  String get quantity;
  @override
  String get reason;

  /// Create a copy of QuoteSuggestionItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QuoteSuggestionItemImplCopyWith<_$QuoteSuggestionItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

QuoteSuggestion _$QuoteSuggestionFromJson(Map<String, dynamic> json) {
  return _QuoteSuggestion.fromJson(json);
}

/// @nodoc
mixin _$QuoteSuggestion {
  List<QuoteSuggestionItem> get items => throw _privateConstructorUsedError;
  double get confidence => throw _privateConstructorUsedError;
  String get comment => throw _privateConstructorUsedError;

  /// Serializes this QuoteSuggestion to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of QuoteSuggestion
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QuoteSuggestionCopyWith<QuoteSuggestion> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuoteSuggestionCopyWith<$Res> {
  factory $QuoteSuggestionCopyWith(
    QuoteSuggestion value,
    $Res Function(QuoteSuggestion) then,
  ) = _$QuoteSuggestionCopyWithImpl<$Res, QuoteSuggestion>;
  @useResult
  $Res call({
    List<QuoteSuggestionItem> items,
    double confidence,
    String comment,
  });
}

/// @nodoc
class _$QuoteSuggestionCopyWithImpl<$Res, $Val extends QuoteSuggestion>
    implements $QuoteSuggestionCopyWith<$Res> {
  _$QuoteSuggestionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of QuoteSuggestion
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? confidence = null,
    Object? comment = null,
  }) {
    return _then(
      _value.copyWith(
            items: null == items
                ? _value.items
                : items // ignore: cast_nullable_to_non_nullable
                      as List<QuoteSuggestionItem>,
            confidence: null == confidence
                ? _value.confidence
                : confidence // ignore: cast_nullable_to_non_nullable
                      as double,
            comment: null == comment
                ? _value.comment
                : comment // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$QuoteSuggestionImplCopyWith<$Res>
    implements $QuoteSuggestionCopyWith<$Res> {
  factory _$$QuoteSuggestionImplCopyWith(
    _$QuoteSuggestionImpl value,
    $Res Function(_$QuoteSuggestionImpl) then,
  ) = __$$QuoteSuggestionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<QuoteSuggestionItem> items,
    double confidence,
    String comment,
  });
}

/// @nodoc
class __$$QuoteSuggestionImplCopyWithImpl<$Res>
    extends _$QuoteSuggestionCopyWithImpl<$Res, _$QuoteSuggestionImpl>
    implements _$$QuoteSuggestionImplCopyWith<$Res> {
  __$$QuoteSuggestionImplCopyWithImpl(
    _$QuoteSuggestionImpl _value,
    $Res Function(_$QuoteSuggestionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of QuoteSuggestion
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? confidence = null,
    Object? comment = null,
  }) {
    return _then(
      _$QuoteSuggestionImpl(
        items: null == items
            ? _value._items
            : items // ignore: cast_nullable_to_non_nullable
                  as List<QuoteSuggestionItem>,
        confidence: null == confidence
            ? _value.confidence
            : confidence // ignore: cast_nullable_to_non_nullable
                  as double,
        comment: null == comment
            ? _value.comment
            : comment // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$QuoteSuggestionImpl implements _QuoteSuggestion {
  const _$QuoteSuggestionImpl({
    required final List<QuoteSuggestionItem> items,
    required this.confidence,
    required this.comment,
  }) : _items = items;

  factory _$QuoteSuggestionImpl.fromJson(Map<String, dynamic> json) =>
      _$$QuoteSuggestionImplFromJson(json);

  final List<QuoteSuggestionItem> _items;
  @override
  List<QuoteSuggestionItem> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  final double confidence;
  @override
  final String comment;

  @override
  String toString() {
    return 'QuoteSuggestion(items: $items, confidence: $confidence, comment: $comment)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuoteSuggestionImpl &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.confidence, confidence) ||
                other.confidence == confidence) &&
            (identical(other.comment, comment) || other.comment == comment));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_items),
    confidence,
    comment,
  );

  /// Create a copy of QuoteSuggestion
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QuoteSuggestionImplCopyWith<_$QuoteSuggestionImpl> get copyWith =>
      __$$QuoteSuggestionImplCopyWithImpl<_$QuoteSuggestionImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$QuoteSuggestionImplToJson(this);
  }
}

abstract class _QuoteSuggestion implements QuoteSuggestion {
  const factory _QuoteSuggestion({
    required final List<QuoteSuggestionItem> items,
    required final double confidence,
    required final String comment,
  }) = _$QuoteSuggestionImpl;

  factory _QuoteSuggestion.fromJson(Map<String, dynamic> json) =
      _$QuoteSuggestionImpl.fromJson;

  @override
  List<QuoteSuggestionItem> get items;
  @override
  double get confidence;
  @override
  String get comment;

  /// Create a copy of QuoteSuggestion
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QuoteSuggestionImplCopyWith<_$QuoteSuggestionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
