// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'workflow_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

WfTransition _$WfTransitionFromJson(Map<String, dynamic> json) {
  return _WfTransition.fromJson(json);
}

/// @nodoc
mixin _$WfTransition {
  String get event => throw _privateConstructorUsedError;
  String get source => throw _privateConstructorUsedError;
  String get target => throw _privateConstructorUsedError;
  bool get requiresValidation => throw _privateConstructorUsedError;

  /// Serializes this WfTransition to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WfTransition
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WfTransitionCopyWith<WfTransition> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WfTransitionCopyWith<$Res> {
  factory $WfTransitionCopyWith(
    WfTransition value,
    $Res Function(WfTransition) then,
  ) = _$WfTransitionCopyWithImpl<$Res, WfTransition>;
  @useResult
  $Res call({
    String event,
    String source,
    String target,
    bool requiresValidation,
  });
}

/// @nodoc
class _$WfTransitionCopyWithImpl<$Res, $Val extends WfTransition>
    implements $WfTransitionCopyWith<$Res> {
  _$WfTransitionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WfTransition
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? event = null,
    Object? source = null,
    Object? target = null,
    Object? requiresValidation = null,
  }) {
    return _then(
      _value.copyWith(
            event: null == event
                ? _value.event
                : event // ignore: cast_nullable_to_non_nullable
                      as String,
            source: null == source
                ? _value.source
                : source // ignore: cast_nullable_to_non_nullable
                      as String,
            target: null == target
                ? _value.target
                : target // ignore: cast_nullable_to_non_nullable
                      as String,
            requiresValidation: null == requiresValidation
                ? _value.requiresValidation
                : requiresValidation // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$WfTransitionImplCopyWith<$Res>
    implements $WfTransitionCopyWith<$Res> {
  factory _$$WfTransitionImplCopyWith(
    _$WfTransitionImpl value,
    $Res Function(_$WfTransitionImpl) then,
  ) = __$$WfTransitionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String event,
    String source,
    String target,
    bool requiresValidation,
  });
}

/// @nodoc
class __$$WfTransitionImplCopyWithImpl<$Res>
    extends _$WfTransitionCopyWithImpl<$Res, _$WfTransitionImpl>
    implements _$$WfTransitionImplCopyWith<$Res> {
  __$$WfTransitionImplCopyWithImpl(
    _$WfTransitionImpl _value,
    $Res Function(_$WfTransitionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WfTransition
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? event = null,
    Object? source = null,
    Object? target = null,
    Object? requiresValidation = null,
  }) {
    return _then(
      _$WfTransitionImpl(
        event: null == event
            ? _value.event
            : event // ignore: cast_nullable_to_non_nullable
                  as String,
        source: null == source
            ? _value.source
            : source // ignore: cast_nullable_to_non_nullable
                  as String,
        target: null == target
            ? _value.target
            : target // ignore: cast_nullable_to_non_nullable
                  as String,
        requiresValidation: null == requiresValidation
            ? _value.requiresValidation
            : requiresValidation // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$WfTransitionImpl implements _WfTransition {
  const _$WfTransitionImpl({
    required this.event,
    required this.source,
    required this.target,
    this.requiresValidation = false,
  });

  factory _$WfTransitionImpl.fromJson(Map<String, dynamic> json) =>
      _$$WfTransitionImplFromJson(json);

  @override
  final String event;
  @override
  final String source;
  @override
  final String target;
  @override
  @JsonKey()
  final bool requiresValidation;

  @override
  String toString() {
    return 'WfTransition(event: $event, source: $source, target: $target, requiresValidation: $requiresValidation)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WfTransitionImpl &&
            (identical(other.event, event) || other.event == event) &&
            (identical(other.source, source) || other.source == source) &&
            (identical(other.target, target) || other.target == target) &&
            (identical(other.requiresValidation, requiresValidation) ||
                other.requiresValidation == requiresValidation));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, event, source, target, requiresValidation);

  /// Create a copy of WfTransition
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WfTransitionImplCopyWith<_$WfTransitionImpl> get copyWith =>
      __$$WfTransitionImplCopyWithImpl<_$WfTransitionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WfTransitionImplToJson(this);
  }
}

abstract class _WfTransition implements WfTransition {
  const factory _WfTransition({
    required final String event,
    required final String source,
    required final String target,
    final bool requiresValidation,
  }) = _$WfTransitionImpl;

  factory _WfTransition.fromJson(Map<String, dynamic> json) =
      _$WfTransitionImpl.fromJson;

  @override
  String get event;
  @override
  String get source;
  @override
  String get target;
  @override
  bool get requiresValidation;

  /// Create a copy of WfTransition
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WfTransitionImplCopyWith<_$WfTransitionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

WorkflowDefinition _$WorkflowDefinitionFromJson(Map<String, dynamic> json) {
  return _WorkflowDefinition.fromJson(json);
}

/// @nodoc
mixin _$WorkflowDefinition {
  String get slug => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get initialState => throw _privateConstructorUsedError;
  List<String> get states => throw _privateConstructorUsedError;
  List<String> get terminalStates => throw _privateConstructorUsedError;
  List<WfTransition> get transitions => throw _privateConstructorUsedError;

  /// Serializes this WorkflowDefinition to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WorkflowDefinition
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WorkflowDefinitionCopyWith<WorkflowDefinition> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WorkflowDefinitionCopyWith<$Res> {
  factory $WorkflowDefinitionCopyWith(
    WorkflowDefinition value,
    $Res Function(WorkflowDefinition) then,
  ) = _$WorkflowDefinitionCopyWithImpl<$Res, WorkflowDefinition>;
  @useResult
  $Res call({
    String slug,
    String name,
    String initialState,
    List<String> states,
    List<String> terminalStates,
    List<WfTransition> transitions,
  });
}

/// @nodoc
class _$WorkflowDefinitionCopyWithImpl<$Res, $Val extends WorkflowDefinition>
    implements $WorkflowDefinitionCopyWith<$Res> {
  _$WorkflowDefinitionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WorkflowDefinition
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? slug = null,
    Object? name = null,
    Object? initialState = null,
    Object? states = null,
    Object? terminalStates = null,
    Object? transitions = null,
  }) {
    return _then(
      _value.copyWith(
            slug: null == slug
                ? _value.slug
                : slug // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            initialState: null == initialState
                ? _value.initialState
                : initialState // ignore: cast_nullable_to_non_nullable
                      as String,
            states: null == states
                ? _value.states
                : states // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            terminalStates: null == terminalStates
                ? _value.terminalStates
                : terminalStates // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            transitions: null == transitions
                ? _value.transitions
                : transitions // ignore: cast_nullable_to_non_nullable
                      as List<WfTransition>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$WorkflowDefinitionImplCopyWith<$Res>
    implements $WorkflowDefinitionCopyWith<$Res> {
  factory _$$WorkflowDefinitionImplCopyWith(
    _$WorkflowDefinitionImpl value,
    $Res Function(_$WorkflowDefinitionImpl) then,
  ) = __$$WorkflowDefinitionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String slug,
    String name,
    String initialState,
    List<String> states,
    List<String> terminalStates,
    List<WfTransition> transitions,
  });
}

/// @nodoc
class __$$WorkflowDefinitionImplCopyWithImpl<$Res>
    extends _$WorkflowDefinitionCopyWithImpl<$Res, _$WorkflowDefinitionImpl>
    implements _$$WorkflowDefinitionImplCopyWith<$Res> {
  __$$WorkflowDefinitionImplCopyWithImpl(
    _$WorkflowDefinitionImpl _value,
    $Res Function(_$WorkflowDefinitionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WorkflowDefinition
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? slug = null,
    Object? name = null,
    Object? initialState = null,
    Object? states = null,
    Object? terminalStates = null,
    Object? transitions = null,
  }) {
    return _then(
      _$WorkflowDefinitionImpl(
        slug: null == slug
            ? _value.slug
            : slug // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        initialState: null == initialState
            ? _value.initialState
            : initialState // ignore: cast_nullable_to_non_nullable
                  as String,
        states: null == states
            ? _value._states
            : states // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        terminalStates: null == terminalStates
            ? _value._terminalStates
            : terminalStates // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        transitions: null == transitions
            ? _value._transitions
            : transitions // ignore: cast_nullable_to_non_nullable
                  as List<WfTransition>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$WorkflowDefinitionImpl implements _WorkflowDefinition {
  const _$WorkflowDefinitionImpl({
    required this.slug,
    required this.name,
    required this.initialState,
    final List<String> states = const <String>[],
    final List<String> terminalStates = const <String>[],
    final List<WfTransition> transitions = const <WfTransition>[],
  }) : _states = states,
       _terminalStates = terminalStates,
       _transitions = transitions;

  factory _$WorkflowDefinitionImpl.fromJson(Map<String, dynamic> json) =>
      _$$WorkflowDefinitionImplFromJson(json);

  @override
  final String slug;
  @override
  final String name;
  @override
  final String initialState;
  final List<String> _states;
  @override
  @JsonKey()
  List<String> get states {
    if (_states is EqualUnmodifiableListView) return _states;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_states);
  }

  final List<String> _terminalStates;
  @override
  @JsonKey()
  List<String> get terminalStates {
    if (_terminalStates is EqualUnmodifiableListView) return _terminalStates;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_terminalStates);
  }

  final List<WfTransition> _transitions;
  @override
  @JsonKey()
  List<WfTransition> get transitions {
    if (_transitions is EqualUnmodifiableListView) return _transitions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_transitions);
  }

  @override
  String toString() {
    return 'WorkflowDefinition(slug: $slug, name: $name, initialState: $initialState, states: $states, terminalStates: $terminalStates, transitions: $transitions)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WorkflowDefinitionImpl &&
            (identical(other.slug, slug) || other.slug == slug) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.initialState, initialState) ||
                other.initialState == initialState) &&
            const DeepCollectionEquality().equals(other._states, _states) &&
            const DeepCollectionEquality().equals(
              other._terminalStates,
              _terminalStates,
            ) &&
            const DeepCollectionEquality().equals(
              other._transitions,
              _transitions,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    slug,
    name,
    initialState,
    const DeepCollectionEquality().hash(_states),
    const DeepCollectionEquality().hash(_terminalStates),
    const DeepCollectionEquality().hash(_transitions),
  );

  /// Create a copy of WorkflowDefinition
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WorkflowDefinitionImplCopyWith<_$WorkflowDefinitionImpl> get copyWith =>
      __$$WorkflowDefinitionImplCopyWithImpl<_$WorkflowDefinitionImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$WorkflowDefinitionImplToJson(this);
  }
}

abstract class _WorkflowDefinition implements WorkflowDefinition {
  const factory _WorkflowDefinition({
    required final String slug,
    required final String name,
    required final String initialState,
    final List<String> states,
    final List<String> terminalStates,
    final List<WfTransition> transitions,
  }) = _$WorkflowDefinitionImpl;

  factory _WorkflowDefinition.fromJson(Map<String, dynamic> json) =
      _$WorkflowDefinitionImpl.fromJson;

  @override
  String get slug;
  @override
  String get name;
  @override
  String get initialState;
  @override
  List<String> get states;
  @override
  List<String> get terminalStates;
  @override
  List<WfTransition> get transitions;

  /// Create a copy of WorkflowDefinition
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WorkflowDefinitionImplCopyWith<_$WorkflowDefinitionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

WorkflowInstance _$WorkflowInstanceFromJson(Map<String, dynamic> json) {
  return _WorkflowInstance.fromJson(json);
}

/// @nodoc
mixin _$WorkflowInstance {
  String get id => throw _privateConstructorUsedError;
  String get companyId => throw _privateConstructorUsedError;
  String get definitionSlug => throw _privateConstructorUsedError;
  String get currentState => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  Map<String, dynamic> get context =>
      throw _privateConstructorUsedError; // History entries are {event, from, to, actor, at}; typed as dynamic to
  // avoid a Freezed @Default parsing bug on nested generics (<Map<..>>[]).
  List<dynamic> get history => throw _privateConstructorUsedError;
  List<String> get availableEvents => throw _privateConstructorUsedError;
  bool get isTerminal => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this WorkflowInstance to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WorkflowInstance
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WorkflowInstanceCopyWith<WorkflowInstance> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WorkflowInstanceCopyWith<$Res> {
  factory $WorkflowInstanceCopyWith(
    WorkflowInstance value,
    $Res Function(WorkflowInstance) then,
  ) = _$WorkflowInstanceCopyWithImpl<$Res, WorkflowInstance>;
  @useResult
  $Res call({
    String id,
    String companyId,
    String definitionSlug,
    String currentState,
    String status,
    Map<String, dynamic> context,
    List<dynamic> history,
    List<String> availableEvents,
    bool isTerminal,
    DateTime createdAt,
    DateTime updatedAt,
  });
}

/// @nodoc
class _$WorkflowInstanceCopyWithImpl<$Res, $Val extends WorkflowInstance>
    implements $WorkflowInstanceCopyWith<$Res> {
  _$WorkflowInstanceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WorkflowInstance
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? companyId = null,
    Object? definitionSlug = null,
    Object? currentState = null,
    Object? status = null,
    Object? context = null,
    Object? history = null,
    Object? availableEvents = null,
    Object? isTerminal = null,
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
            definitionSlug: null == definitionSlug
                ? _value.definitionSlug
                : definitionSlug // ignore: cast_nullable_to_non_nullable
                      as String,
            currentState: null == currentState
                ? _value.currentState
                : currentState // ignore: cast_nullable_to_non_nullable
                      as String,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            context: null == context
                ? _value.context
                : context // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>,
            history: null == history
                ? _value.history
                : history // ignore: cast_nullable_to_non_nullable
                      as List<dynamic>,
            availableEvents: null == availableEvents
                ? _value.availableEvents
                : availableEvents // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            isTerminal: null == isTerminal
                ? _value.isTerminal
                : isTerminal // ignore: cast_nullable_to_non_nullable
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
abstract class _$$WorkflowInstanceImplCopyWith<$Res>
    implements $WorkflowInstanceCopyWith<$Res> {
  factory _$$WorkflowInstanceImplCopyWith(
    _$WorkflowInstanceImpl value,
    $Res Function(_$WorkflowInstanceImpl) then,
  ) = __$$WorkflowInstanceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String companyId,
    String definitionSlug,
    String currentState,
    String status,
    Map<String, dynamic> context,
    List<dynamic> history,
    List<String> availableEvents,
    bool isTerminal,
    DateTime createdAt,
    DateTime updatedAt,
  });
}

/// @nodoc
class __$$WorkflowInstanceImplCopyWithImpl<$Res>
    extends _$WorkflowInstanceCopyWithImpl<$Res, _$WorkflowInstanceImpl>
    implements _$$WorkflowInstanceImplCopyWith<$Res> {
  __$$WorkflowInstanceImplCopyWithImpl(
    _$WorkflowInstanceImpl _value,
    $Res Function(_$WorkflowInstanceImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WorkflowInstance
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? companyId = null,
    Object? definitionSlug = null,
    Object? currentState = null,
    Object? status = null,
    Object? context = null,
    Object? history = null,
    Object? availableEvents = null,
    Object? isTerminal = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _$WorkflowInstanceImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        companyId: null == companyId
            ? _value.companyId
            : companyId // ignore: cast_nullable_to_non_nullable
                  as String,
        definitionSlug: null == definitionSlug
            ? _value.definitionSlug
            : definitionSlug // ignore: cast_nullable_to_non_nullable
                  as String,
        currentState: null == currentState
            ? _value.currentState
            : currentState // ignore: cast_nullable_to_non_nullable
                  as String,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        context: null == context
            ? _value._context
            : context // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>,
        history: null == history
            ? _value._history
            : history // ignore: cast_nullable_to_non_nullable
                  as List<dynamic>,
        availableEvents: null == availableEvents
            ? _value._availableEvents
            : availableEvents // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        isTerminal: null == isTerminal
            ? _value.isTerminal
            : isTerminal // ignore: cast_nullable_to_non_nullable
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
class _$WorkflowInstanceImpl implements _WorkflowInstance {
  const _$WorkflowInstanceImpl({
    required this.id,
    required this.companyId,
    required this.definitionSlug,
    required this.currentState,
    required this.status,
    final Map<String, dynamic> context = const <String, dynamic>{},
    final List<dynamic> history = const <dynamic>[],
    final List<String> availableEvents = const <String>[],
    required this.isTerminal,
    required this.createdAt,
    required this.updatedAt,
  }) : _context = context,
       _history = history,
       _availableEvents = availableEvents;

  factory _$WorkflowInstanceImpl.fromJson(Map<String, dynamic> json) =>
      _$$WorkflowInstanceImplFromJson(json);

  @override
  final String id;
  @override
  final String companyId;
  @override
  final String definitionSlug;
  @override
  final String currentState;
  @override
  final String status;
  final Map<String, dynamic> _context;
  @override
  @JsonKey()
  Map<String, dynamic> get context {
    if (_context is EqualUnmodifiableMapView) return _context;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_context);
  }

  // History entries are {event, from, to, actor, at}; typed as dynamic to
  // avoid a Freezed @Default parsing bug on nested generics (<Map<..>>[]).
  final List<dynamic> _history;
  // History entries are {event, from, to, actor, at}; typed as dynamic to
  // avoid a Freezed @Default parsing bug on nested generics (<Map<..>>[]).
  @override
  @JsonKey()
  List<dynamic> get history {
    if (_history is EqualUnmodifiableListView) return _history;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_history);
  }

  final List<String> _availableEvents;
  @override
  @JsonKey()
  List<String> get availableEvents {
    if (_availableEvents is EqualUnmodifiableListView) return _availableEvents;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_availableEvents);
  }

  @override
  final bool isTerminal;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'WorkflowInstance(id: $id, companyId: $companyId, definitionSlug: $definitionSlug, currentState: $currentState, status: $status, context: $context, history: $history, availableEvents: $availableEvents, isTerminal: $isTerminal, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WorkflowInstanceImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.companyId, companyId) ||
                other.companyId == companyId) &&
            (identical(other.definitionSlug, definitionSlug) ||
                other.definitionSlug == definitionSlug) &&
            (identical(other.currentState, currentState) ||
                other.currentState == currentState) &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(other._context, _context) &&
            const DeepCollectionEquality().equals(other._history, _history) &&
            const DeepCollectionEquality().equals(
              other._availableEvents,
              _availableEvents,
            ) &&
            (identical(other.isTerminal, isTerminal) ||
                other.isTerminal == isTerminal) &&
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
    definitionSlug,
    currentState,
    status,
    const DeepCollectionEquality().hash(_context),
    const DeepCollectionEquality().hash(_history),
    const DeepCollectionEquality().hash(_availableEvents),
    isTerminal,
    createdAt,
    updatedAt,
  );

  /// Create a copy of WorkflowInstance
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WorkflowInstanceImplCopyWith<_$WorkflowInstanceImpl> get copyWith =>
      __$$WorkflowInstanceImplCopyWithImpl<_$WorkflowInstanceImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$WorkflowInstanceImplToJson(this);
  }
}

abstract class _WorkflowInstance implements WorkflowInstance {
  const factory _WorkflowInstance({
    required final String id,
    required final String companyId,
    required final String definitionSlug,
    required final String currentState,
    required final String status,
    final Map<String, dynamic> context,
    final List<dynamic> history,
    final List<String> availableEvents,
    required final bool isTerminal,
    required final DateTime createdAt,
    required final DateTime updatedAt,
  }) = _$WorkflowInstanceImpl;

  factory _WorkflowInstance.fromJson(Map<String, dynamic> json) =
      _$WorkflowInstanceImpl.fromJson;

  @override
  String get id;
  @override
  String get companyId;
  @override
  String get definitionSlug;
  @override
  String get currentState;
  @override
  String get status;
  @override
  Map<String, dynamic> get context; // History entries are {event, from, to, actor, at}; typed as dynamic to
  // avoid a Freezed @Default parsing bug on nested generics (<Map<..>>[]).
  @override
  List<dynamic> get history;
  @override
  List<String> get availableEvents;
  @override
  bool get isTerminal;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;

  /// Create a copy of WorkflowInstance
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WorkflowInstanceImplCopyWith<_$WorkflowInstanceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
