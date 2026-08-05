// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'companion_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ChatResponse _$ChatResponseFromJson(Map<String, dynamic> json) {
  return _ChatResponse.fromJson(json);
}

/// @nodoc
mixin _$ChatResponse {
  String get sessionId => throw _privateConstructorUsedError;
  String get intent => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  Explanation get explanation => throw _privateConstructorUsedError;
  List<SourceRef> get sources => throw _privateConstructorUsedError;
  ProposedAction? get proposedAction => throw _privateConstructorUsedError;
  bool get needsConfirmation => throw _privateConstructorUsedError;
  List<String> get questions => throw _privateConstructorUsedError;
  bool get executed => throw _privateConstructorUsedError;
  Map<String, dynamic>? get result => throw _privateConstructorUsedError;

  /// Serializes this ChatResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChatResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChatResponseCopyWith<ChatResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatResponseCopyWith<$Res> {
  factory $ChatResponseCopyWith(
    ChatResponse value,
    $Res Function(ChatResponse) then,
  ) = _$ChatResponseCopyWithImpl<$Res, ChatResponse>;
  @useResult
  $Res call({
    String sessionId,
    String intent,
    String message,
    Explanation explanation,
    List<SourceRef> sources,
    ProposedAction? proposedAction,
    bool needsConfirmation,
    List<String> questions,
    bool executed,
    Map<String, dynamic>? result,
  });

  $ExplanationCopyWith<$Res> get explanation;
  $ProposedActionCopyWith<$Res>? get proposedAction;
}

/// @nodoc
class _$ChatResponseCopyWithImpl<$Res, $Val extends ChatResponse>
    implements $ChatResponseCopyWith<$Res> {
  _$ChatResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChatResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sessionId = null,
    Object? intent = null,
    Object? message = null,
    Object? explanation = null,
    Object? sources = null,
    Object? proposedAction = freezed,
    Object? needsConfirmation = null,
    Object? questions = null,
    Object? executed = null,
    Object? result = freezed,
  }) {
    return _then(
      _value.copyWith(
            sessionId: null == sessionId
                ? _value.sessionId
                : sessionId // ignore: cast_nullable_to_non_nullable
                      as String,
            intent: null == intent
                ? _value.intent
                : intent // ignore: cast_nullable_to_non_nullable
                      as String,
            message: null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String,
            explanation: null == explanation
                ? _value.explanation
                : explanation // ignore: cast_nullable_to_non_nullable
                      as Explanation,
            sources: null == sources
                ? _value.sources
                : sources // ignore: cast_nullable_to_non_nullable
                      as List<SourceRef>,
            proposedAction: freezed == proposedAction
                ? _value.proposedAction
                : proposedAction // ignore: cast_nullable_to_non_nullable
                      as ProposedAction?,
            needsConfirmation: null == needsConfirmation
                ? _value.needsConfirmation
                : needsConfirmation // ignore: cast_nullable_to_non_nullable
                      as bool,
            questions: null == questions
                ? _value.questions
                : questions // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            executed: null == executed
                ? _value.executed
                : executed // ignore: cast_nullable_to_non_nullable
                      as bool,
            result: freezed == result
                ? _value.result
                : result // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>?,
          )
          as $Val,
    );
  }

  /// Create a copy of ChatResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ExplanationCopyWith<$Res> get explanation {
    return $ExplanationCopyWith<$Res>(_value.explanation, (value) {
      return _then(_value.copyWith(explanation: value) as $Val);
    });
  }

  /// Create a copy of ChatResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ProposedActionCopyWith<$Res>? get proposedAction {
    if (_value.proposedAction == null) {
      return null;
    }

    return $ProposedActionCopyWith<$Res>(_value.proposedAction!, (value) {
      return _then(_value.copyWith(proposedAction: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ChatResponseImplCopyWith<$Res>
    implements $ChatResponseCopyWith<$Res> {
  factory _$$ChatResponseImplCopyWith(
    _$ChatResponseImpl value,
    $Res Function(_$ChatResponseImpl) then,
  ) = __$$ChatResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String sessionId,
    String intent,
    String message,
    Explanation explanation,
    List<SourceRef> sources,
    ProposedAction? proposedAction,
    bool needsConfirmation,
    List<String> questions,
    bool executed,
    Map<String, dynamic>? result,
  });

  @override
  $ExplanationCopyWith<$Res> get explanation;
  @override
  $ProposedActionCopyWith<$Res>? get proposedAction;
}

/// @nodoc
class __$$ChatResponseImplCopyWithImpl<$Res>
    extends _$ChatResponseCopyWithImpl<$Res, _$ChatResponseImpl>
    implements _$$ChatResponseImplCopyWith<$Res> {
  __$$ChatResponseImplCopyWithImpl(
    _$ChatResponseImpl _value,
    $Res Function(_$ChatResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChatResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sessionId = null,
    Object? intent = null,
    Object? message = null,
    Object? explanation = null,
    Object? sources = null,
    Object? proposedAction = freezed,
    Object? needsConfirmation = null,
    Object? questions = null,
    Object? executed = null,
    Object? result = freezed,
  }) {
    return _then(
      _$ChatResponseImpl(
        sessionId: null == sessionId
            ? _value.sessionId
            : sessionId // ignore: cast_nullable_to_non_nullable
                  as String,
        intent: null == intent
            ? _value.intent
            : intent // ignore: cast_nullable_to_non_nullable
                  as String,
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        explanation: null == explanation
            ? _value.explanation
            : explanation // ignore: cast_nullable_to_non_nullable
                  as Explanation,
        sources: null == sources
            ? _value._sources
            : sources // ignore: cast_nullable_to_non_nullable
                  as List<SourceRef>,
        proposedAction: freezed == proposedAction
            ? _value.proposedAction
            : proposedAction // ignore: cast_nullable_to_non_nullable
                  as ProposedAction?,
        needsConfirmation: null == needsConfirmation
            ? _value.needsConfirmation
            : needsConfirmation // ignore: cast_nullable_to_non_nullable
                  as bool,
        questions: null == questions
            ? _value._questions
            : questions // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        executed: null == executed
            ? _value.executed
            : executed // ignore: cast_nullable_to_non_nullable
                  as bool,
        result: freezed == result
            ? _value._result
            : result // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ChatResponseImpl implements _ChatResponse {
  const _$ChatResponseImpl({
    required this.sessionId,
    required this.intent,
    required this.message,
    required this.explanation,
    final List<SourceRef> sources = const <SourceRef>[],
    this.proposedAction,
    this.needsConfirmation = false,
    final List<String> questions = const <String>[],
    this.executed = false,
    final Map<String, dynamic>? result,
  }) : _sources = sources,
       _questions = questions,
       _result = result;

  factory _$ChatResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChatResponseImplFromJson(json);

  @override
  final String sessionId;
  @override
  final String intent;
  @override
  final String message;
  @override
  final Explanation explanation;
  final List<SourceRef> _sources;
  @override
  @JsonKey()
  List<SourceRef> get sources {
    if (_sources is EqualUnmodifiableListView) return _sources;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_sources);
  }

  @override
  final ProposedAction? proposedAction;
  @override
  @JsonKey()
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
  @JsonKey()
  final bool executed;
  final Map<String, dynamic>? _result;
  @override
  Map<String, dynamic>? get result {
    final value = _result;
    if (value == null) return null;
    if (_result is EqualUnmodifiableMapView) return _result;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'ChatResponse(sessionId: $sessionId, intent: $intent, message: $message, explanation: $explanation, sources: $sources, proposedAction: $proposedAction, needsConfirmation: $needsConfirmation, questions: $questions, executed: $executed, result: $result)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatResponseImpl &&
            (identical(other.sessionId, sessionId) ||
                other.sessionId == sessionId) &&
            (identical(other.intent, intent) || other.intent == intent) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.explanation, explanation) ||
                other.explanation == explanation) &&
            const DeepCollectionEquality().equals(other._sources, _sources) &&
            (identical(other.proposedAction, proposedAction) ||
                other.proposedAction == proposedAction) &&
            (identical(other.needsConfirmation, needsConfirmation) ||
                other.needsConfirmation == needsConfirmation) &&
            const DeepCollectionEquality().equals(
              other._questions,
              _questions,
            ) &&
            (identical(other.executed, executed) ||
                other.executed == executed) &&
            const DeepCollectionEquality().equals(other._result, _result));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    sessionId,
    intent,
    message,
    explanation,
    const DeepCollectionEquality().hash(_sources),
    proposedAction,
    needsConfirmation,
    const DeepCollectionEquality().hash(_questions),
    executed,
    const DeepCollectionEquality().hash(_result),
  );

  /// Create a copy of ChatResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatResponseImplCopyWith<_$ChatResponseImpl> get copyWith =>
      __$$ChatResponseImplCopyWithImpl<_$ChatResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChatResponseImplToJson(this);
  }
}

abstract class _ChatResponse implements ChatResponse {
  const factory _ChatResponse({
    required final String sessionId,
    required final String intent,
    required final String message,
    required final Explanation explanation,
    final List<SourceRef> sources,
    final ProposedAction? proposedAction,
    final bool needsConfirmation,
    final List<String> questions,
    final bool executed,
    final Map<String, dynamic>? result,
  }) = _$ChatResponseImpl;

  factory _ChatResponse.fromJson(Map<String, dynamic> json) =
      _$ChatResponseImpl.fromJson;

  @override
  String get sessionId;
  @override
  String get intent;
  @override
  String get message;
  @override
  Explanation get explanation;
  @override
  List<SourceRef> get sources;
  @override
  ProposedAction? get proposedAction;
  @override
  bool get needsConfirmation;
  @override
  List<String> get questions;
  @override
  bool get executed;
  @override
  Map<String, dynamic>? get result;

  /// Create a copy of ChatResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChatResponseImplCopyWith<_$ChatResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Explanation _$ExplanationFromJson(Map<String, dynamic> json) {
  return _Explanation.fromJson(json);
}

/// @nodoc
mixin _$Explanation {
  String get why => throw _privateConstructorUsedError;
  String get engine => throw _privateConstructorUsedError;
  List<String> get knowledgeUsed => throw _privateConstructorUsedError;
  double get confidence => throw _privateConstructorUsedError;
  bool get needsConfirmation => throw _privateConstructorUsedError;

  /// Serializes this Explanation to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Explanation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ExplanationCopyWith<Explanation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExplanationCopyWith<$Res> {
  factory $ExplanationCopyWith(
    Explanation value,
    $Res Function(Explanation) then,
  ) = _$ExplanationCopyWithImpl<$Res, Explanation>;
  @useResult
  $Res call({
    String why,
    String engine,
    List<String> knowledgeUsed,
    double confidence,
    bool needsConfirmation,
  });
}

/// @nodoc
class _$ExplanationCopyWithImpl<$Res, $Val extends Explanation>
    implements $ExplanationCopyWith<$Res> {
  _$ExplanationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Explanation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? why = null,
    Object? engine = null,
    Object? knowledgeUsed = null,
    Object? confidence = null,
    Object? needsConfirmation = null,
  }) {
    return _then(
      _value.copyWith(
            why: null == why
                ? _value.why
                : why // ignore: cast_nullable_to_non_nullable
                      as String,
            engine: null == engine
                ? _value.engine
                : engine // ignore: cast_nullable_to_non_nullable
                      as String,
            knowledgeUsed: null == knowledgeUsed
                ? _value.knowledgeUsed
                : knowledgeUsed // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            confidence: null == confidence
                ? _value.confidence
                : confidence // ignore: cast_nullable_to_non_nullable
                      as double,
            needsConfirmation: null == needsConfirmation
                ? _value.needsConfirmation
                : needsConfirmation // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ExplanationImplCopyWith<$Res>
    implements $ExplanationCopyWith<$Res> {
  factory _$$ExplanationImplCopyWith(
    _$ExplanationImpl value,
    $Res Function(_$ExplanationImpl) then,
  ) = __$$ExplanationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String why,
    String engine,
    List<String> knowledgeUsed,
    double confidence,
    bool needsConfirmation,
  });
}

/// @nodoc
class __$$ExplanationImplCopyWithImpl<$Res>
    extends _$ExplanationCopyWithImpl<$Res, _$ExplanationImpl>
    implements _$$ExplanationImplCopyWith<$Res> {
  __$$ExplanationImplCopyWithImpl(
    _$ExplanationImpl _value,
    $Res Function(_$ExplanationImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Explanation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? why = null,
    Object? engine = null,
    Object? knowledgeUsed = null,
    Object? confidence = null,
    Object? needsConfirmation = null,
  }) {
    return _then(
      _$ExplanationImpl(
        why: null == why
            ? _value.why
            : why // ignore: cast_nullable_to_non_nullable
                  as String,
        engine: null == engine
            ? _value.engine
            : engine // ignore: cast_nullable_to_non_nullable
                  as String,
        knowledgeUsed: null == knowledgeUsed
            ? _value._knowledgeUsed
            : knowledgeUsed // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        confidence: null == confidence
            ? _value.confidence
            : confidence // ignore: cast_nullable_to_non_nullable
                  as double,
        needsConfirmation: null == needsConfirmation
            ? _value.needsConfirmation
            : needsConfirmation // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ExplanationImpl implements _Explanation {
  const _$ExplanationImpl({
    this.why = '',
    this.engine = 'companion',
    final List<String> knowledgeUsed = const <String>[],
    this.confidence = 0,
    this.needsConfirmation = false,
  }) : _knowledgeUsed = knowledgeUsed;

  factory _$ExplanationImpl.fromJson(Map<String, dynamic> json) =>
      _$$ExplanationImplFromJson(json);

  @override
  @JsonKey()
  final String why;
  @override
  @JsonKey()
  final String engine;
  final List<String> _knowledgeUsed;
  @override
  @JsonKey()
  List<String> get knowledgeUsed {
    if (_knowledgeUsed is EqualUnmodifiableListView) return _knowledgeUsed;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_knowledgeUsed);
  }

  @override
  @JsonKey()
  final double confidence;
  @override
  @JsonKey()
  final bool needsConfirmation;

  @override
  String toString() {
    return 'Explanation(why: $why, engine: $engine, knowledgeUsed: $knowledgeUsed, confidence: $confidence, needsConfirmation: $needsConfirmation)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExplanationImpl &&
            (identical(other.why, why) || other.why == why) &&
            (identical(other.engine, engine) || other.engine == engine) &&
            const DeepCollectionEquality().equals(
              other._knowledgeUsed,
              _knowledgeUsed,
            ) &&
            (identical(other.confidence, confidence) ||
                other.confidence == confidence) &&
            (identical(other.needsConfirmation, needsConfirmation) ||
                other.needsConfirmation == needsConfirmation));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    why,
    engine,
    const DeepCollectionEquality().hash(_knowledgeUsed),
    confidence,
    needsConfirmation,
  );

  /// Create a copy of Explanation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ExplanationImplCopyWith<_$ExplanationImpl> get copyWith =>
      __$$ExplanationImplCopyWithImpl<_$ExplanationImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ExplanationImplToJson(this);
  }
}

abstract class _Explanation implements Explanation {
  const factory _Explanation({
    final String why,
    final String engine,
    final List<String> knowledgeUsed,
    final double confidence,
    final bool needsConfirmation,
  }) = _$ExplanationImpl;

  factory _Explanation.fromJson(Map<String, dynamic> json) =
      _$ExplanationImpl.fromJson;

  @override
  String get why;
  @override
  String get engine;
  @override
  List<String> get knowledgeUsed;
  @override
  double get confidence;
  @override
  bool get needsConfirmation;

  /// Create a copy of Explanation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ExplanationImplCopyWith<_$ExplanationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ProposedAction _$ProposedActionFromJson(Map<String, dynamic> json) {
  return _ProposedAction.fromJson(json);
}

/// @nodoc
mixin _$ProposedAction {
  String get tool => throw _privateConstructorUsedError;
  String get engine => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  Map<String, dynamic>? get params => throw _privateConstructorUsedError;
  List<String> get missing => throw _privateConstructorUsedError;

  /// Serializes this ProposedAction to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ProposedAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProposedActionCopyWith<ProposedAction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProposedActionCopyWith<$Res> {
  factory $ProposedActionCopyWith(
    ProposedAction value,
    $Res Function(ProposedAction) then,
  ) = _$ProposedActionCopyWithImpl<$Res, ProposedAction>;
  @useResult
  $Res call({
    String tool,
    String engine,
    String description,
    Map<String, dynamic>? params,
    List<String> missing,
  });
}

/// @nodoc
class _$ProposedActionCopyWithImpl<$Res, $Val extends ProposedAction>
    implements $ProposedActionCopyWith<$Res> {
  _$ProposedActionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProposedAction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tool = null,
    Object? engine = null,
    Object? description = null,
    Object? params = freezed,
    Object? missing = null,
  }) {
    return _then(
      _value.copyWith(
            tool: null == tool
                ? _value.tool
                : tool // ignore: cast_nullable_to_non_nullable
                      as String,
            engine: null == engine
                ? _value.engine
                : engine // ignore: cast_nullable_to_non_nullable
                      as String,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            params: freezed == params
                ? _value.params
                : params // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>?,
            missing: null == missing
                ? _value.missing
                : missing // ignore: cast_nullable_to_non_nullable
                      as List<String>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ProposedActionImplCopyWith<$Res>
    implements $ProposedActionCopyWith<$Res> {
  factory _$$ProposedActionImplCopyWith(
    _$ProposedActionImpl value,
    $Res Function(_$ProposedActionImpl) then,
  ) = __$$ProposedActionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String tool,
    String engine,
    String description,
    Map<String, dynamic>? params,
    List<String> missing,
  });
}

/// @nodoc
class __$$ProposedActionImplCopyWithImpl<$Res>
    extends _$ProposedActionCopyWithImpl<$Res, _$ProposedActionImpl>
    implements _$$ProposedActionImplCopyWith<$Res> {
  __$$ProposedActionImplCopyWithImpl(
    _$ProposedActionImpl _value,
    $Res Function(_$ProposedActionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ProposedAction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tool = null,
    Object? engine = null,
    Object? description = null,
    Object? params = freezed,
    Object? missing = null,
  }) {
    return _then(
      _$ProposedActionImpl(
        tool: null == tool
            ? _value.tool
            : tool // ignore: cast_nullable_to_non_nullable
                  as String,
        engine: null == engine
            ? _value.engine
            : engine // ignore: cast_nullable_to_non_nullable
                  as String,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        params: freezed == params
            ? _value._params
            : params // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>?,
        missing: null == missing
            ? _value._missing
            : missing // ignore: cast_nullable_to_non_nullable
                  as List<String>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ProposedActionImpl implements _ProposedAction {
  const _$ProposedActionImpl({
    required this.tool,
    required this.engine,
    this.description = '',
    final Map<String, dynamic>? params,
    final List<String> missing = const <String>[],
  }) : _params = params,
       _missing = missing;

  factory _$ProposedActionImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProposedActionImplFromJson(json);

  @override
  final String tool;
  @override
  final String engine;
  @override
  @JsonKey()
  final String description;
  final Map<String, dynamic>? _params;
  @override
  Map<String, dynamic>? get params {
    final value = _params;
    if (value == null) return null;
    if (_params is EqualUnmodifiableMapView) return _params;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  final List<String> _missing;
  @override
  @JsonKey()
  List<String> get missing {
    if (_missing is EqualUnmodifiableListView) return _missing;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_missing);
  }

  @override
  String toString() {
    return 'ProposedAction(tool: $tool, engine: $engine, description: $description, params: $params, missing: $missing)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProposedActionImpl &&
            (identical(other.tool, tool) || other.tool == tool) &&
            (identical(other.engine, engine) || other.engine == engine) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(other._params, _params) &&
            const DeepCollectionEquality().equals(other._missing, _missing));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    tool,
    engine,
    description,
    const DeepCollectionEquality().hash(_params),
    const DeepCollectionEquality().hash(_missing),
  );

  /// Create a copy of ProposedAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProposedActionImplCopyWith<_$ProposedActionImpl> get copyWith =>
      __$$ProposedActionImplCopyWithImpl<_$ProposedActionImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ProposedActionImplToJson(this);
  }
}

abstract class _ProposedAction implements ProposedAction {
  const factory _ProposedAction({
    required final String tool,
    required final String engine,
    final String description,
    final Map<String, dynamic>? params,
    final List<String> missing,
  }) = _$ProposedActionImpl;

  factory _ProposedAction.fromJson(Map<String, dynamic> json) =
      _$ProposedActionImpl.fromJson;

  @override
  String get tool;
  @override
  String get engine;
  @override
  String get description;
  @override
  Map<String, dynamic>? get params;
  @override
  List<String> get missing;

  /// Create a copy of ProposedAction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProposedActionImplCopyWith<_$ProposedActionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SourceRef _$SourceRefFromJson(Map<String, dynamic> json) {
  return _SourceRef.fromJson(json);
}

/// @nodoc
mixin _$SourceRef {
  String get kind => throw _privateConstructorUsedError;
  String get ref => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;

  /// Serializes this SourceRef to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SourceRef
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SourceRefCopyWith<SourceRef> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SourceRefCopyWith<$Res> {
  factory $SourceRefCopyWith(SourceRef value, $Res Function(SourceRef) then) =
      _$SourceRefCopyWithImpl<$Res, SourceRef>;
  @useResult
  $Res call({String kind, String ref, String title});
}

/// @nodoc
class _$SourceRefCopyWithImpl<$Res, $Val extends SourceRef>
    implements $SourceRefCopyWith<$Res> {
  _$SourceRefCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SourceRef
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? kind = null, Object? ref = null, Object? title = null}) {
    return _then(
      _value.copyWith(
            kind: null == kind
                ? _value.kind
                : kind // ignore: cast_nullable_to_non_nullable
                      as String,
            ref: null == ref
                ? _value.ref
                : ref // ignore: cast_nullable_to_non_nullable
                      as String,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SourceRefImplCopyWith<$Res>
    implements $SourceRefCopyWith<$Res> {
  factory _$$SourceRefImplCopyWith(
    _$SourceRefImpl value,
    $Res Function(_$SourceRefImpl) then,
  ) = __$$SourceRefImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String kind, String ref, String title});
}

/// @nodoc
class __$$SourceRefImplCopyWithImpl<$Res>
    extends _$SourceRefCopyWithImpl<$Res, _$SourceRefImpl>
    implements _$$SourceRefImplCopyWith<$Res> {
  __$$SourceRefImplCopyWithImpl(
    _$SourceRefImpl _value,
    $Res Function(_$SourceRefImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SourceRef
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? kind = null, Object? ref = null, Object? title = null}) {
    return _then(
      _$SourceRefImpl(
        kind: null == kind
            ? _value.kind
            : kind // ignore: cast_nullable_to_non_nullable
                  as String,
        ref: null == ref
            ? _value.ref
            : ref // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SourceRefImpl implements _SourceRef {
  const _$SourceRefImpl({required this.kind, this.ref = '', this.title = ''});

  factory _$SourceRefImpl.fromJson(Map<String, dynamic> json) =>
      _$$SourceRefImplFromJson(json);

  @override
  final String kind;
  @override
  @JsonKey()
  final String ref;
  @override
  @JsonKey()
  final String title;

  @override
  String toString() {
    return 'SourceRef(kind: $kind, ref: $ref, title: $title)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SourceRefImpl &&
            (identical(other.kind, kind) || other.kind == kind) &&
            (identical(other.ref, ref) || other.ref == ref) &&
            (identical(other.title, title) || other.title == title));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, kind, ref, title);

  /// Create a copy of SourceRef
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SourceRefImplCopyWith<_$SourceRefImpl> get copyWith =>
      __$$SourceRefImplCopyWithImpl<_$SourceRefImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SourceRefImplToJson(this);
  }
}

abstract class _SourceRef implements SourceRef {
  const factory _SourceRef({
    required final String kind,
    final String ref,
    final String title,
  }) = _$SourceRefImpl;

  factory _SourceRef.fromJson(Map<String, dynamic> json) =
      _$SourceRefImpl.fromJson;

  @override
  String get kind;
  @override
  String get ref;
  @override
  String get title;

  /// Create a copy of SourceRef
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SourceRefImplCopyWith<_$SourceRefImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
