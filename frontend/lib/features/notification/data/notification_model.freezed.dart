// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

AppNotification _$AppNotificationFromJson(Map<String, dynamic> json) {
  return _AppNotification.fromJson(json);
}

/// @nodoc
mixin _$AppNotification {
  String get id => throw _privateConstructorUsedError;
  String get companyId => throw _privateConstructorUsedError;
  String get channel => throw _privateConstructorUsedError;
  String get recipient => throw _privateConstructorUsedError;
  String get subject => throw _privateConstructorUsedError;
  String get body => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String get templateKey => throw _privateConstructorUsedError;
  String get relatedType => throw _privateConstructorUsedError;
  String get relatedId => throw _privateConstructorUsedError;
  List<dynamic> get history => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this AppNotification to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AppNotification
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AppNotificationCopyWith<AppNotification> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppNotificationCopyWith<$Res> {
  factory $AppNotificationCopyWith(
    AppNotification value,
    $Res Function(AppNotification) then,
  ) = _$AppNotificationCopyWithImpl<$Res, AppNotification>;
  @useResult
  $Res call({
    String id,
    String companyId,
    String channel,
    String recipient,
    String subject,
    String body,
    String status,
    String templateKey,
    String relatedType,
    String relatedId,
    List<dynamic> history,
    DateTime createdAt,
    DateTime updatedAt,
  });
}

/// @nodoc
class _$AppNotificationCopyWithImpl<$Res, $Val extends AppNotification>
    implements $AppNotificationCopyWith<$Res> {
  _$AppNotificationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AppNotification
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? companyId = null,
    Object? channel = null,
    Object? recipient = null,
    Object? subject = null,
    Object? body = null,
    Object? status = null,
    Object? templateKey = null,
    Object? relatedType = null,
    Object? relatedId = null,
    Object? history = null,
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
            channel: null == channel
                ? _value.channel
                : channel // ignore: cast_nullable_to_non_nullable
                      as String,
            recipient: null == recipient
                ? _value.recipient
                : recipient // ignore: cast_nullable_to_non_nullable
                      as String,
            subject: null == subject
                ? _value.subject
                : subject // ignore: cast_nullable_to_non_nullable
                      as String,
            body: null == body
                ? _value.body
                : body // ignore: cast_nullable_to_non_nullable
                      as String,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            templateKey: null == templateKey
                ? _value.templateKey
                : templateKey // ignore: cast_nullable_to_non_nullable
                      as String,
            relatedType: null == relatedType
                ? _value.relatedType
                : relatedType // ignore: cast_nullable_to_non_nullable
                      as String,
            relatedId: null == relatedId
                ? _value.relatedId
                : relatedId // ignore: cast_nullable_to_non_nullable
                      as String,
            history: null == history
                ? _value.history
                : history // ignore: cast_nullable_to_non_nullable
                      as List<dynamic>,
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
abstract class _$$AppNotificationImplCopyWith<$Res>
    implements $AppNotificationCopyWith<$Res> {
  factory _$$AppNotificationImplCopyWith(
    _$AppNotificationImpl value,
    $Res Function(_$AppNotificationImpl) then,
  ) = __$$AppNotificationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String companyId,
    String channel,
    String recipient,
    String subject,
    String body,
    String status,
    String templateKey,
    String relatedType,
    String relatedId,
    List<dynamic> history,
    DateTime createdAt,
    DateTime updatedAt,
  });
}

/// @nodoc
class __$$AppNotificationImplCopyWithImpl<$Res>
    extends _$AppNotificationCopyWithImpl<$Res, _$AppNotificationImpl>
    implements _$$AppNotificationImplCopyWith<$Res> {
  __$$AppNotificationImplCopyWithImpl(
    _$AppNotificationImpl _value,
    $Res Function(_$AppNotificationImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AppNotification
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? companyId = null,
    Object? channel = null,
    Object? recipient = null,
    Object? subject = null,
    Object? body = null,
    Object? status = null,
    Object? templateKey = null,
    Object? relatedType = null,
    Object? relatedId = null,
    Object? history = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _$AppNotificationImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        companyId: null == companyId
            ? _value.companyId
            : companyId // ignore: cast_nullable_to_non_nullable
                  as String,
        channel: null == channel
            ? _value.channel
            : channel // ignore: cast_nullable_to_non_nullable
                  as String,
        recipient: null == recipient
            ? _value.recipient
            : recipient // ignore: cast_nullable_to_non_nullable
                  as String,
        subject: null == subject
            ? _value.subject
            : subject // ignore: cast_nullable_to_non_nullable
                  as String,
        body: null == body
            ? _value.body
            : body // ignore: cast_nullable_to_non_nullable
                  as String,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        templateKey: null == templateKey
            ? _value.templateKey
            : templateKey // ignore: cast_nullable_to_non_nullable
                  as String,
        relatedType: null == relatedType
            ? _value.relatedType
            : relatedType // ignore: cast_nullable_to_non_nullable
                  as String,
        relatedId: null == relatedId
            ? _value.relatedId
            : relatedId // ignore: cast_nullable_to_non_nullable
                  as String,
        history: null == history
            ? _value._history
            : history // ignore: cast_nullable_to_non_nullable
                  as List<dynamic>,
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
class _$AppNotificationImpl implements _AppNotification {
  const _$AppNotificationImpl({
    required this.id,
    required this.companyId,
    required this.channel,
    required this.recipient,
    this.subject = '',
    this.body = '',
    required this.status,
    this.templateKey = '',
    this.relatedType = '',
    this.relatedId = '',
    final List<dynamic> history = const <dynamic>[],
    required this.createdAt,
    required this.updatedAt,
  }) : _history = history;

  factory _$AppNotificationImpl.fromJson(Map<String, dynamic> json) =>
      _$$AppNotificationImplFromJson(json);

  @override
  final String id;
  @override
  final String companyId;
  @override
  final String channel;
  @override
  final String recipient;
  @override
  @JsonKey()
  final String subject;
  @override
  @JsonKey()
  final String body;
  @override
  final String status;
  @override
  @JsonKey()
  final String templateKey;
  @override
  @JsonKey()
  final String relatedType;
  @override
  @JsonKey()
  final String relatedId;
  final List<dynamic> _history;
  @override
  @JsonKey()
  List<dynamic> get history {
    if (_history is EqualUnmodifiableListView) return _history;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_history);
  }

  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'AppNotification(id: $id, companyId: $companyId, channel: $channel, recipient: $recipient, subject: $subject, body: $body, status: $status, templateKey: $templateKey, relatedType: $relatedType, relatedId: $relatedId, history: $history, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppNotificationImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.companyId, companyId) ||
                other.companyId == companyId) &&
            (identical(other.channel, channel) || other.channel == channel) &&
            (identical(other.recipient, recipient) ||
                other.recipient == recipient) &&
            (identical(other.subject, subject) || other.subject == subject) &&
            (identical(other.body, body) || other.body == body) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.templateKey, templateKey) ||
                other.templateKey == templateKey) &&
            (identical(other.relatedType, relatedType) ||
                other.relatedType == relatedType) &&
            (identical(other.relatedId, relatedId) ||
                other.relatedId == relatedId) &&
            const DeepCollectionEquality().equals(other._history, _history) &&
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
    channel,
    recipient,
    subject,
    body,
    status,
    templateKey,
    relatedType,
    relatedId,
    const DeepCollectionEquality().hash(_history),
    createdAt,
    updatedAt,
  );

  /// Create a copy of AppNotification
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AppNotificationImplCopyWith<_$AppNotificationImpl> get copyWith =>
      __$$AppNotificationImplCopyWithImpl<_$AppNotificationImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$AppNotificationImplToJson(this);
  }
}

abstract class _AppNotification implements AppNotification {
  const factory _AppNotification({
    required final String id,
    required final String companyId,
    required final String channel,
    required final String recipient,
    final String subject,
    final String body,
    required final String status,
    final String templateKey,
    final String relatedType,
    final String relatedId,
    final List<dynamic> history,
    required final DateTime createdAt,
    required final DateTime updatedAt,
  }) = _$AppNotificationImpl;

  factory _AppNotification.fromJson(Map<String, dynamic> json) =
      _$AppNotificationImpl.fromJson;

  @override
  String get id;
  @override
  String get companyId;
  @override
  String get channel;
  @override
  String get recipient;
  @override
  String get subject;
  @override
  String get body;
  @override
  String get status;
  @override
  String get templateKey;
  @override
  String get relatedType;
  @override
  String get relatedId;
  @override
  List<dynamic> get history;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;

  /// Create a copy of AppNotification
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AppNotificationImplCopyWith<_$AppNotificationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
