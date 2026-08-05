// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'decision_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

DecisionIntent _$DecisionIntentFromJson(Map<String, dynamic> json) {
  return _DecisionIntent.fromJson(json);
}

/// @nodoc
mixin _$DecisionIntent {
  String get verb => throw _privateConstructorUsedError;
  String get target => throw _privateConstructorUsedError;
  String get raw => throw _privateConstructorUsedError;

  /// Serializes this DecisionIntent to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DecisionIntent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DecisionIntentCopyWith<DecisionIntent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DecisionIntentCopyWith<$Res> {
  factory $DecisionIntentCopyWith(
    DecisionIntent value,
    $Res Function(DecisionIntent) then,
  ) = _$DecisionIntentCopyWithImpl<$Res, DecisionIntent>;
  @useResult
  $Res call({String verb, String target, String raw});
}

/// @nodoc
class _$DecisionIntentCopyWithImpl<$Res, $Val extends DecisionIntent>
    implements $DecisionIntentCopyWith<$Res> {
  _$DecisionIntentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DecisionIntent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? verb = null, Object? target = null, Object? raw = null}) {
    return _then(
      _value.copyWith(
            verb: null == verb
                ? _value.verb
                : verb // ignore: cast_nullable_to_non_nullable
                      as String,
            target: null == target
                ? _value.target
                : target // ignore: cast_nullable_to_non_nullable
                      as String,
            raw: null == raw
                ? _value.raw
                : raw // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DecisionIntentImplCopyWith<$Res>
    implements $DecisionIntentCopyWith<$Res> {
  factory _$$DecisionIntentImplCopyWith(
    _$DecisionIntentImpl value,
    $Res Function(_$DecisionIntentImpl) then,
  ) = __$$DecisionIntentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String verb, String target, String raw});
}

/// @nodoc
class __$$DecisionIntentImplCopyWithImpl<$Res>
    extends _$DecisionIntentCopyWithImpl<$Res, _$DecisionIntentImpl>
    implements _$$DecisionIntentImplCopyWith<$Res> {
  __$$DecisionIntentImplCopyWithImpl(
    _$DecisionIntentImpl _value,
    $Res Function(_$DecisionIntentImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DecisionIntent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? verb = null, Object? target = null, Object? raw = null}) {
    return _then(
      _$DecisionIntentImpl(
        verb: null == verb
            ? _value.verb
            : verb // ignore: cast_nullable_to_non_nullable
                  as String,
        target: null == target
            ? _value.target
            : target // ignore: cast_nullable_to_non_nullable
                  as String,
        raw: null == raw
            ? _value.raw
            : raw // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DecisionIntentImpl implements _DecisionIntent {
  const _$DecisionIntentImpl({
    required this.verb,
    required this.target,
    required this.raw,
  });

  factory _$DecisionIntentImpl.fromJson(Map<String, dynamic> json) =>
      _$$DecisionIntentImplFromJson(json);

  @override
  final String verb;
  @override
  final String target;
  @override
  final String raw;

  @override
  String toString() {
    return 'DecisionIntent(verb: $verb, target: $target, raw: $raw)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DecisionIntentImpl &&
            (identical(other.verb, verb) || other.verb == verb) &&
            (identical(other.target, target) || other.target == target) &&
            (identical(other.raw, raw) || other.raw == raw));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, verb, target, raw);

  /// Create a copy of DecisionIntent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DecisionIntentImplCopyWith<_$DecisionIntentImpl> get copyWith =>
      __$$DecisionIntentImplCopyWithImpl<_$DecisionIntentImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$DecisionIntentImplToJson(this);
  }
}

abstract class _DecisionIntent implements DecisionIntent {
  const factory _DecisionIntent({
    required final String verb,
    required final String target,
    required final String raw,
  }) = _$DecisionIntentImpl;

  factory _DecisionIntent.fromJson(Map<String, dynamic> json) =
      _$DecisionIntentImpl.fromJson;

  @override
  String get verb;
  @override
  String get target;
  @override
  String get raw;

  /// Create a copy of DecisionIntent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DecisionIntentImplCopyWith<_$DecisionIntentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DecisionProposalElement _$DecisionProposalElementFromJson(
  Map<String, dynamic> json,
) {
  return _DecisionProposalElement.fromJson(json);
}

/// @nodoc
mixin _$DecisionProposalElement {
  String get slug => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get reason => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _numFromJson)
  double get score => throw _privateConstructorUsedError;
  String get confidence => throw _privateConstructorUsedError;
  List<String> get sources => throw _privateConstructorUsedError;
  List<String> get relations => throw _privateConstructorUsedError;

  /// Serializes this DecisionProposalElement to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DecisionProposalElement
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DecisionProposalElementCopyWith<DecisionProposalElement> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DecisionProposalElementCopyWith<$Res> {
  factory $DecisionProposalElementCopyWith(
    DecisionProposalElement value,
    $Res Function(DecisionProposalElement) then,
  ) = _$DecisionProposalElementCopyWithImpl<$Res, DecisionProposalElement>;
  @useResult
  $Res call({
    String slug,
    String type,
    String title,
    String reason,
    @JsonKey(fromJson: _numFromJson) double score,
    String confidence,
    List<String> sources,
    List<String> relations,
  });
}

/// @nodoc
class _$DecisionProposalElementCopyWithImpl<
  $Res,
  $Val extends DecisionProposalElement
>
    implements $DecisionProposalElementCopyWith<$Res> {
  _$DecisionProposalElementCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DecisionProposalElement
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? slug = null,
    Object? type = null,
    Object? title = null,
    Object? reason = null,
    Object? score = null,
    Object? confidence = null,
    Object? sources = null,
    Object? relations = null,
  }) {
    return _then(
      _value.copyWith(
            slug: null == slug
                ? _value.slug
                : slug // ignore: cast_nullable_to_non_nullable
                      as String,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as String,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            reason: null == reason
                ? _value.reason
                : reason // ignore: cast_nullable_to_non_nullable
                      as String,
            score: null == score
                ? _value.score
                : score // ignore: cast_nullable_to_non_nullable
                      as double,
            confidence: null == confidence
                ? _value.confidence
                : confidence // ignore: cast_nullable_to_non_nullable
                      as String,
            sources: null == sources
                ? _value.sources
                : sources // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            relations: null == relations
                ? _value.relations
                : relations // ignore: cast_nullable_to_non_nullable
                      as List<String>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DecisionProposalElementImplCopyWith<$Res>
    implements $DecisionProposalElementCopyWith<$Res> {
  factory _$$DecisionProposalElementImplCopyWith(
    _$DecisionProposalElementImpl value,
    $Res Function(_$DecisionProposalElementImpl) then,
  ) = __$$DecisionProposalElementImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String slug,
    String type,
    String title,
    String reason,
    @JsonKey(fromJson: _numFromJson) double score,
    String confidence,
    List<String> sources,
    List<String> relations,
  });
}

/// @nodoc
class __$$DecisionProposalElementImplCopyWithImpl<$Res>
    extends
        _$DecisionProposalElementCopyWithImpl<
          $Res,
          _$DecisionProposalElementImpl
        >
    implements _$$DecisionProposalElementImplCopyWith<$Res> {
  __$$DecisionProposalElementImplCopyWithImpl(
    _$DecisionProposalElementImpl _value,
    $Res Function(_$DecisionProposalElementImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DecisionProposalElement
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? slug = null,
    Object? type = null,
    Object? title = null,
    Object? reason = null,
    Object? score = null,
    Object? confidence = null,
    Object? sources = null,
    Object? relations = null,
  }) {
    return _then(
      _$DecisionProposalElementImpl(
        slug: null == slug
            ? _value.slug
            : slug // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        reason: null == reason
            ? _value.reason
            : reason // ignore: cast_nullable_to_non_nullable
                  as String,
        score: null == score
            ? _value.score
            : score // ignore: cast_nullable_to_non_nullable
                  as double,
        confidence: null == confidence
            ? _value.confidence
            : confidence // ignore: cast_nullable_to_non_nullable
                  as String,
        sources: null == sources
            ? _value._sources
            : sources // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        relations: null == relations
            ? _value._relations
            : relations // ignore: cast_nullable_to_non_nullable
                  as List<String>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DecisionProposalElementImpl implements _DecisionProposalElement {
  const _$DecisionProposalElementImpl({
    required this.slug,
    required this.type,
    required this.title,
    required this.reason,
    @JsonKey(fromJson: _numFromJson) required this.score,
    this.confidence = '',
    final List<String> sources = const <String>[],
    final List<String> relations = const <String>[],
  }) : _sources = sources,
       _relations = relations;

  factory _$DecisionProposalElementImpl.fromJson(Map<String, dynamic> json) =>
      _$$DecisionProposalElementImplFromJson(json);

  @override
  final String slug;
  @override
  final String type;
  @override
  final String title;
  @override
  final String reason;
  @override
  @JsonKey(fromJson: _numFromJson)
  final double score;
  @override
  @JsonKey()
  final String confidence;
  final List<String> _sources;
  @override
  @JsonKey()
  List<String> get sources {
    if (_sources is EqualUnmodifiableListView) return _sources;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_sources);
  }

  final List<String> _relations;
  @override
  @JsonKey()
  List<String> get relations {
    if (_relations is EqualUnmodifiableListView) return _relations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_relations);
  }

  @override
  String toString() {
    return 'DecisionProposalElement(slug: $slug, type: $type, title: $title, reason: $reason, score: $score, confidence: $confidence, sources: $sources, relations: $relations)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DecisionProposalElementImpl &&
            (identical(other.slug, slug) || other.slug == slug) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.reason, reason) || other.reason == reason) &&
            (identical(other.score, score) || other.score == score) &&
            (identical(other.confidence, confidence) ||
                other.confidence == confidence) &&
            const DeepCollectionEquality().equals(other._sources, _sources) &&
            const DeepCollectionEquality().equals(
              other._relations,
              _relations,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    slug,
    type,
    title,
    reason,
    score,
    confidence,
    const DeepCollectionEquality().hash(_sources),
    const DeepCollectionEquality().hash(_relations),
  );

  /// Create a copy of DecisionProposalElement
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DecisionProposalElementImplCopyWith<_$DecisionProposalElementImpl>
  get copyWith =>
      __$$DecisionProposalElementImplCopyWithImpl<
        _$DecisionProposalElementImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DecisionProposalElementImplToJson(this);
  }
}

abstract class _DecisionProposalElement implements DecisionProposalElement {
  const factory _DecisionProposalElement({
    required final String slug,
    required final String type,
    required final String title,
    required final String reason,
    @JsonKey(fromJson: _numFromJson) required final double score,
    final String confidence,
    final List<String> sources,
    final List<String> relations,
  }) = _$DecisionProposalElementImpl;

  factory _DecisionProposalElement.fromJson(Map<String, dynamic> json) =
      _$DecisionProposalElementImpl.fromJson;

  @override
  String get slug;
  @override
  String get type;
  @override
  String get title;
  @override
  String get reason;
  @override
  @JsonKey(fromJson: _numFromJson)
  double get score;
  @override
  String get confidence;
  @override
  List<String> get sources;
  @override
  List<String> get relations;

  /// Create a copy of DecisionProposalElement
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DecisionProposalElementImplCopyWith<_$DecisionProposalElementImpl>
  get copyWith => throw _privateConstructorUsedError;
}

DecisionProposal _$DecisionProposalFromJson(Map<String, dynamic> json) {
  return _DecisionProposal.fromJson(json);
}

/// @nodoc
mixin _$DecisionProposal {
  List<DecisionProposalElement> get elements =>
      throw _privateConstructorUsedError;
  String get comment => throw _privateConstructorUsedError;

  /// Serializes this DecisionProposal to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DecisionProposal
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DecisionProposalCopyWith<DecisionProposal> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DecisionProposalCopyWith<$Res> {
  factory $DecisionProposalCopyWith(
    DecisionProposal value,
    $Res Function(DecisionProposal) then,
  ) = _$DecisionProposalCopyWithImpl<$Res, DecisionProposal>;
  @useResult
  $Res call({List<DecisionProposalElement> elements, String comment});
}

/// @nodoc
class _$DecisionProposalCopyWithImpl<$Res, $Val extends DecisionProposal>
    implements $DecisionProposalCopyWith<$Res> {
  _$DecisionProposalCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DecisionProposal
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? elements = null, Object? comment = null}) {
    return _then(
      _value.copyWith(
            elements: null == elements
                ? _value.elements
                : elements // ignore: cast_nullable_to_non_nullable
                      as List<DecisionProposalElement>,
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
abstract class _$$DecisionProposalImplCopyWith<$Res>
    implements $DecisionProposalCopyWith<$Res> {
  factory _$$DecisionProposalImplCopyWith(
    _$DecisionProposalImpl value,
    $Res Function(_$DecisionProposalImpl) then,
  ) = __$$DecisionProposalImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<DecisionProposalElement> elements, String comment});
}

/// @nodoc
class __$$DecisionProposalImplCopyWithImpl<$Res>
    extends _$DecisionProposalCopyWithImpl<$Res, _$DecisionProposalImpl>
    implements _$$DecisionProposalImplCopyWith<$Res> {
  __$$DecisionProposalImplCopyWithImpl(
    _$DecisionProposalImpl _value,
    $Res Function(_$DecisionProposalImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DecisionProposal
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? elements = null, Object? comment = null}) {
    return _then(
      _$DecisionProposalImpl(
        elements: null == elements
            ? _value._elements
            : elements // ignore: cast_nullable_to_non_nullable
                  as List<DecisionProposalElement>,
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
class _$DecisionProposalImpl implements _DecisionProposal {
  const _$DecisionProposalImpl({
    final List<DecisionProposalElement> elements =
        const <DecisionProposalElement>[],
    this.comment = '',
  }) : _elements = elements;

  factory _$DecisionProposalImpl.fromJson(Map<String, dynamic> json) =>
      _$$DecisionProposalImplFromJson(json);

  final List<DecisionProposalElement> _elements;
  @override
  @JsonKey()
  List<DecisionProposalElement> get elements {
    if (_elements is EqualUnmodifiableListView) return _elements;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_elements);
  }

  @override
  @JsonKey()
  final String comment;

  @override
  String toString() {
    return 'DecisionProposal(elements: $elements, comment: $comment)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DecisionProposalImpl &&
            const DeepCollectionEquality().equals(other._elements, _elements) &&
            (identical(other.comment, comment) || other.comment == comment));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_elements),
    comment,
  );

  /// Create a copy of DecisionProposal
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DecisionProposalImplCopyWith<_$DecisionProposalImpl> get copyWith =>
      __$$DecisionProposalImplCopyWithImpl<_$DecisionProposalImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$DecisionProposalImplToJson(this);
  }
}

abstract class _DecisionProposal implements DecisionProposal {
  const factory _DecisionProposal({
    final List<DecisionProposalElement> elements,
    final String comment,
  }) = _$DecisionProposalImpl;

  factory _DecisionProposal.fromJson(Map<String, dynamic> json) =
      _$DecisionProposalImpl.fromJson;

  @override
  List<DecisionProposalElement> get elements;
  @override
  String get comment;

  /// Create a copy of DecisionProposal
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DecisionProposalImplCopyWith<_$DecisionProposalImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DecisionExplanationItem _$DecisionExplanationItemFromJson(
  Map<String, dynamic> json,
) {
  return _DecisionExplanationItem.fromJson(json);
}

/// @nodoc
mixin _$DecisionExplanationItem {
  String get subject => throw _privateConstructorUsedError;
  String get why => throw _privateConstructorUsedError;
  String get basis => throw _privateConstructorUsedError;
  String get confidence => throw _privateConstructorUsedError;

  /// Serializes this DecisionExplanationItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DecisionExplanationItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DecisionExplanationItemCopyWith<DecisionExplanationItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DecisionExplanationItemCopyWith<$Res> {
  factory $DecisionExplanationItemCopyWith(
    DecisionExplanationItem value,
    $Res Function(DecisionExplanationItem) then,
  ) = _$DecisionExplanationItemCopyWithImpl<$Res, DecisionExplanationItem>;
  @useResult
  $Res call({String subject, String why, String basis, String confidence});
}

/// @nodoc
class _$DecisionExplanationItemCopyWithImpl<
  $Res,
  $Val extends DecisionExplanationItem
>
    implements $DecisionExplanationItemCopyWith<$Res> {
  _$DecisionExplanationItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DecisionExplanationItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? subject = null,
    Object? why = null,
    Object? basis = null,
    Object? confidence = null,
  }) {
    return _then(
      _value.copyWith(
            subject: null == subject
                ? _value.subject
                : subject // ignore: cast_nullable_to_non_nullable
                      as String,
            why: null == why
                ? _value.why
                : why // ignore: cast_nullable_to_non_nullable
                      as String,
            basis: null == basis
                ? _value.basis
                : basis // ignore: cast_nullable_to_non_nullable
                      as String,
            confidence: null == confidence
                ? _value.confidence
                : confidence // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DecisionExplanationItemImplCopyWith<$Res>
    implements $DecisionExplanationItemCopyWith<$Res> {
  factory _$$DecisionExplanationItemImplCopyWith(
    _$DecisionExplanationItemImpl value,
    $Res Function(_$DecisionExplanationItemImpl) then,
  ) = __$$DecisionExplanationItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String subject, String why, String basis, String confidence});
}

/// @nodoc
class __$$DecisionExplanationItemImplCopyWithImpl<$Res>
    extends
        _$DecisionExplanationItemCopyWithImpl<
          $Res,
          _$DecisionExplanationItemImpl
        >
    implements _$$DecisionExplanationItemImplCopyWith<$Res> {
  __$$DecisionExplanationItemImplCopyWithImpl(
    _$DecisionExplanationItemImpl _value,
    $Res Function(_$DecisionExplanationItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DecisionExplanationItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? subject = null,
    Object? why = null,
    Object? basis = null,
    Object? confidence = null,
  }) {
    return _then(
      _$DecisionExplanationItemImpl(
        subject: null == subject
            ? _value.subject
            : subject // ignore: cast_nullable_to_non_nullable
                  as String,
        why: null == why
            ? _value.why
            : why // ignore: cast_nullable_to_non_nullable
                  as String,
        basis: null == basis
            ? _value.basis
            : basis // ignore: cast_nullable_to_non_nullable
                  as String,
        confidence: null == confidence
            ? _value.confidence
            : confidence // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DecisionExplanationItemImpl implements _DecisionExplanationItem {
  const _$DecisionExplanationItemImpl({
    required this.subject,
    required this.why,
    required this.basis,
    this.confidence = '',
  });

  factory _$DecisionExplanationItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$DecisionExplanationItemImplFromJson(json);

  @override
  final String subject;
  @override
  final String why;
  @override
  final String basis;
  @override
  @JsonKey()
  final String confidence;

  @override
  String toString() {
    return 'DecisionExplanationItem(subject: $subject, why: $why, basis: $basis, confidence: $confidence)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DecisionExplanationItemImpl &&
            (identical(other.subject, subject) || other.subject == subject) &&
            (identical(other.why, why) || other.why == why) &&
            (identical(other.basis, basis) || other.basis == basis) &&
            (identical(other.confidence, confidence) ||
                other.confidence == confidence));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, subject, why, basis, confidence);

  /// Create a copy of DecisionExplanationItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DecisionExplanationItemImplCopyWith<_$DecisionExplanationItemImpl>
  get copyWith =>
      __$$DecisionExplanationItemImplCopyWithImpl<
        _$DecisionExplanationItemImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DecisionExplanationItemImplToJson(this);
  }
}

abstract class _DecisionExplanationItem implements DecisionExplanationItem {
  const factory _DecisionExplanationItem({
    required final String subject,
    required final String why,
    required final String basis,
    final String confidence,
  }) = _$DecisionExplanationItemImpl;

  factory _DecisionExplanationItem.fromJson(Map<String, dynamic> json) =
      _$DecisionExplanationItemImpl.fromJson;

  @override
  String get subject;
  @override
  String get why;
  @override
  String get basis;
  @override
  String get confidence;

  /// Create a copy of DecisionExplanationItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DecisionExplanationItemImplCopyWith<_$DecisionExplanationItemImpl>
  get copyWith => throw _privateConstructorUsedError;
}

DecisionExplanation _$DecisionExplanationFromJson(Map<String, dynamic> json) {
  return _DecisionExplanation.fromJson(json);
}

/// @nodoc
mixin _$DecisionExplanation {
  List<DecisionExplanationItem> get items => throw _privateConstructorUsedError;

  /// Serializes this DecisionExplanation to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DecisionExplanation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DecisionExplanationCopyWith<DecisionExplanation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DecisionExplanationCopyWith<$Res> {
  factory $DecisionExplanationCopyWith(
    DecisionExplanation value,
    $Res Function(DecisionExplanation) then,
  ) = _$DecisionExplanationCopyWithImpl<$Res, DecisionExplanation>;
  @useResult
  $Res call({List<DecisionExplanationItem> items});
}

/// @nodoc
class _$DecisionExplanationCopyWithImpl<$Res, $Val extends DecisionExplanation>
    implements $DecisionExplanationCopyWith<$Res> {
  _$DecisionExplanationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DecisionExplanation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? items = null}) {
    return _then(
      _value.copyWith(
            items: null == items
                ? _value.items
                : items // ignore: cast_nullable_to_non_nullable
                      as List<DecisionExplanationItem>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DecisionExplanationImplCopyWith<$Res>
    implements $DecisionExplanationCopyWith<$Res> {
  factory _$$DecisionExplanationImplCopyWith(
    _$DecisionExplanationImpl value,
    $Res Function(_$DecisionExplanationImpl) then,
  ) = __$$DecisionExplanationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<DecisionExplanationItem> items});
}

/// @nodoc
class __$$DecisionExplanationImplCopyWithImpl<$Res>
    extends _$DecisionExplanationCopyWithImpl<$Res, _$DecisionExplanationImpl>
    implements _$$DecisionExplanationImplCopyWith<$Res> {
  __$$DecisionExplanationImplCopyWithImpl(
    _$DecisionExplanationImpl _value,
    $Res Function(_$DecisionExplanationImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DecisionExplanation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? items = null}) {
    return _then(
      _$DecisionExplanationImpl(
        items: null == items
            ? _value._items
            : items // ignore: cast_nullable_to_non_nullable
                  as List<DecisionExplanationItem>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DecisionExplanationImpl implements _DecisionExplanation {
  const _$DecisionExplanationImpl({
    final List<DecisionExplanationItem> items =
        const <DecisionExplanationItem>[],
  }) : _items = items;

  factory _$DecisionExplanationImpl.fromJson(Map<String, dynamic> json) =>
      _$$DecisionExplanationImplFromJson(json);

  final List<DecisionExplanationItem> _items;
  @override
  @JsonKey()
  List<DecisionExplanationItem> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  String toString() {
    return 'DecisionExplanation(items: $items)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DecisionExplanationImpl &&
            const DeepCollectionEquality().equals(other._items, _items));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_items));

  /// Create a copy of DecisionExplanation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DecisionExplanationImplCopyWith<_$DecisionExplanationImpl> get copyWith =>
      __$$DecisionExplanationImplCopyWithImpl<_$DecisionExplanationImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$DecisionExplanationImplToJson(this);
  }
}

abstract class _DecisionExplanation implements DecisionExplanation {
  const factory _DecisionExplanation({
    final List<DecisionExplanationItem> items,
  }) = _$DecisionExplanationImpl;

  factory _DecisionExplanation.fromJson(Map<String, dynamic> json) =
      _$DecisionExplanationImpl.fromJson;

  @override
  List<DecisionExplanationItem> get items;

  /// Create a copy of DecisionExplanation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DecisionExplanationImplCopyWith<_$DecisionExplanationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DecisionResult _$DecisionResultFromJson(Map<String, dynamic> json) {
  return _DecisionResult.fromJson(json);
}

/// @nodoc
mixin _$DecisionResult {
  DecisionIntent get intent => throw _privateConstructorUsedError;
  DecisionProposal get proposal => throw _privateConstructorUsedError;
  DecisionExplanation get explanation => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _numFromJson)
  double get confidence => throw _privateConstructorUsedError;
  bool get needsConfirmation => throw _privateConstructorUsedError;
  List<String> get questions => throw _privateConstructorUsedError;

  /// Serializes this DecisionResult to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DecisionResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DecisionResultCopyWith<DecisionResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DecisionResultCopyWith<$Res> {
  factory $DecisionResultCopyWith(
    DecisionResult value,
    $Res Function(DecisionResult) then,
  ) = _$DecisionResultCopyWithImpl<$Res, DecisionResult>;
  @useResult
  $Res call({
    DecisionIntent intent,
    DecisionProposal proposal,
    DecisionExplanation explanation,
    @JsonKey(fromJson: _numFromJson) double confidence,
    bool needsConfirmation,
    List<String> questions,
  });

  $DecisionIntentCopyWith<$Res> get intent;
  $DecisionProposalCopyWith<$Res> get proposal;
  $DecisionExplanationCopyWith<$Res> get explanation;
}

/// @nodoc
class _$DecisionResultCopyWithImpl<$Res, $Val extends DecisionResult>
    implements $DecisionResultCopyWith<$Res> {
  _$DecisionResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DecisionResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? intent = null,
    Object? proposal = null,
    Object? explanation = null,
    Object? confidence = null,
    Object? needsConfirmation = null,
    Object? questions = null,
  }) {
    return _then(
      _value.copyWith(
            intent: null == intent
                ? _value.intent
                : intent // ignore: cast_nullable_to_non_nullable
                      as DecisionIntent,
            proposal: null == proposal
                ? _value.proposal
                : proposal // ignore: cast_nullable_to_non_nullable
                      as DecisionProposal,
            explanation: null == explanation
                ? _value.explanation
                : explanation // ignore: cast_nullable_to_non_nullable
                      as DecisionExplanation,
            confidence: null == confidence
                ? _value.confidence
                : confidence // ignore: cast_nullable_to_non_nullable
                      as double,
            needsConfirmation: null == needsConfirmation
                ? _value.needsConfirmation
                : needsConfirmation // ignore: cast_nullable_to_non_nullable
                      as bool,
            questions: null == questions
                ? _value.questions
                : questions // ignore: cast_nullable_to_non_nullable
                      as List<String>,
          )
          as $Val,
    );
  }

  /// Create a copy of DecisionResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DecisionIntentCopyWith<$Res> get intent {
    return $DecisionIntentCopyWith<$Res>(_value.intent, (value) {
      return _then(_value.copyWith(intent: value) as $Val);
    });
  }

  /// Create a copy of DecisionResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DecisionProposalCopyWith<$Res> get proposal {
    return $DecisionProposalCopyWith<$Res>(_value.proposal, (value) {
      return _then(_value.copyWith(proposal: value) as $Val);
    });
  }

  /// Create a copy of DecisionResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DecisionExplanationCopyWith<$Res> get explanation {
    return $DecisionExplanationCopyWith<$Res>(_value.explanation, (value) {
      return _then(_value.copyWith(explanation: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$DecisionResultImplCopyWith<$Res>
    implements $DecisionResultCopyWith<$Res> {
  factory _$$DecisionResultImplCopyWith(
    _$DecisionResultImpl value,
    $Res Function(_$DecisionResultImpl) then,
  ) = __$$DecisionResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    DecisionIntent intent,
    DecisionProposal proposal,
    DecisionExplanation explanation,
    @JsonKey(fromJson: _numFromJson) double confidence,
    bool needsConfirmation,
    List<String> questions,
  });

  @override
  $DecisionIntentCopyWith<$Res> get intent;
  @override
  $DecisionProposalCopyWith<$Res> get proposal;
  @override
  $DecisionExplanationCopyWith<$Res> get explanation;
}

/// @nodoc
class __$$DecisionResultImplCopyWithImpl<$Res>
    extends _$DecisionResultCopyWithImpl<$Res, _$DecisionResultImpl>
    implements _$$DecisionResultImplCopyWith<$Res> {
  __$$DecisionResultImplCopyWithImpl(
    _$DecisionResultImpl _value,
    $Res Function(_$DecisionResultImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DecisionResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? intent = null,
    Object? proposal = null,
    Object? explanation = null,
    Object? confidence = null,
    Object? needsConfirmation = null,
    Object? questions = null,
  }) {
    return _then(
      _$DecisionResultImpl(
        intent: null == intent
            ? _value.intent
            : intent // ignore: cast_nullable_to_non_nullable
                  as DecisionIntent,
        proposal: null == proposal
            ? _value.proposal
            : proposal // ignore: cast_nullable_to_non_nullable
                  as DecisionProposal,
        explanation: null == explanation
            ? _value.explanation
            : explanation // ignore: cast_nullable_to_non_nullable
                  as DecisionExplanation,
        confidence: null == confidence
            ? _value.confidence
            : confidence // ignore: cast_nullable_to_non_nullable
                  as double,
        needsConfirmation: null == needsConfirmation
            ? _value.needsConfirmation
            : needsConfirmation // ignore: cast_nullable_to_non_nullable
                  as bool,
        questions: null == questions
            ? _value._questions
            : questions // ignore: cast_nullable_to_non_nullable
                  as List<String>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DecisionResultImpl implements _DecisionResult {
  const _$DecisionResultImpl({
    required this.intent,
    required this.proposal,
    required this.explanation,
    @JsonKey(fromJson: _numFromJson) required this.confidence,
    required this.needsConfirmation,
    final List<String> questions = const <String>[],
  }) : _questions = questions;

  factory _$DecisionResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$DecisionResultImplFromJson(json);

  @override
  final DecisionIntent intent;
  @override
  final DecisionProposal proposal;
  @override
  final DecisionExplanation explanation;
  @override
  @JsonKey(fromJson: _numFromJson)
  final double confidence;
  @override
  final bool needsConfirmation;
  final List<String> _questions;
  @override
  @JsonKey()
  List<String> get questions {
    if (_questions is EqualUnmodifiableListView) return _questions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_questions);
  }

  @override
  String toString() {
    return 'DecisionResult(intent: $intent, proposal: $proposal, explanation: $explanation, confidence: $confidence, needsConfirmation: $needsConfirmation, questions: $questions)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DecisionResultImpl &&
            (identical(other.intent, intent) || other.intent == intent) &&
            (identical(other.proposal, proposal) ||
                other.proposal == proposal) &&
            (identical(other.explanation, explanation) ||
                other.explanation == explanation) &&
            (identical(other.confidence, confidence) ||
                other.confidence == confidence) &&
            (identical(other.needsConfirmation, needsConfirmation) ||
                other.needsConfirmation == needsConfirmation) &&
            const DeepCollectionEquality().equals(
              other._questions,
              _questions,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    intent,
    proposal,
    explanation,
    confidence,
    needsConfirmation,
    const DeepCollectionEquality().hash(_questions),
  );

  /// Create a copy of DecisionResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DecisionResultImplCopyWith<_$DecisionResultImpl> get copyWith =>
      __$$DecisionResultImplCopyWithImpl<_$DecisionResultImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$DecisionResultImplToJson(this);
  }
}

abstract class _DecisionResult implements DecisionResult {
  const factory _DecisionResult({
    required final DecisionIntent intent,
    required final DecisionProposal proposal,
    required final DecisionExplanation explanation,
    @JsonKey(fromJson: _numFromJson) required final double confidence,
    required final bool needsConfirmation,
    final List<String> questions,
  }) = _$DecisionResultImpl;

  factory _DecisionResult.fromJson(Map<String, dynamic> json) =
      _$DecisionResultImpl.fromJson;

  @override
  DecisionIntent get intent;
  @override
  DecisionProposal get proposal;
  @override
  DecisionExplanation get explanation;
  @override
  @JsonKey(fromJson: _numFromJson)
  double get confidence;
  @override
  bool get needsConfirmation;
  @override
  List<String> get questions;

  /// Create a copy of DecisionResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DecisionResultImplCopyWith<_$DecisionResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
