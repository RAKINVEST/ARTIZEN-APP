// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'api_exception.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ApiException {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() network,
    required TResult Function() timeout,
    required TResult Function(int statusCode, String code, String message)
    server,
    required TResult Function(String message) unknown,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? network,
    TResult? Function()? timeout,
    TResult? Function(int statusCode, String code, String message)? server,
    TResult? Function(String message)? unknown,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? network,
    TResult Function()? timeout,
    TResult Function(int statusCode, String code, String message)? server,
    TResult Function(String message)? unknown,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ApiNetworkException value) network,
    required TResult Function(ApiTimeoutException value) timeout,
    required TResult Function(ApiServerException value) server,
    required TResult Function(ApiUnknownException value) unknown,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ApiNetworkException value)? network,
    TResult? Function(ApiTimeoutException value)? timeout,
    TResult? Function(ApiServerException value)? server,
    TResult? Function(ApiUnknownException value)? unknown,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ApiNetworkException value)? network,
    TResult Function(ApiTimeoutException value)? timeout,
    TResult Function(ApiServerException value)? server,
    TResult Function(ApiUnknownException value)? unknown,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ApiExceptionCopyWith<$Res> {
  factory $ApiExceptionCopyWith(
    ApiException value,
    $Res Function(ApiException) then,
  ) = _$ApiExceptionCopyWithImpl<$Res, ApiException>;
}

/// @nodoc
class _$ApiExceptionCopyWithImpl<$Res, $Val extends ApiException>
    implements $ApiExceptionCopyWith<$Res> {
  _$ApiExceptionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ApiException
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$ApiNetworkExceptionImplCopyWith<$Res> {
  factory _$$ApiNetworkExceptionImplCopyWith(
    _$ApiNetworkExceptionImpl value,
    $Res Function(_$ApiNetworkExceptionImpl) then,
  ) = __$$ApiNetworkExceptionImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ApiNetworkExceptionImplCopyWithImpl<$Res>
    extends _$ApiExceptionCopyWithImpl<$Res, _$ApiNetworkExceptionImpl>
    implements _$$ApiNetworkExceptionImplCopyWith<$Res> {
  __$$ApiNetworkExceptionImplCopyWithImpl(
    _$ApiNetworkExceptionImpl _value,
    $Res Function(_$ApiNetworkExceptionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ApiException
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ApiNetworkExceptionImpl extends ApiNetworkException {
  const _$ApiNetworkExceptionImpl() : super._();

  @override
  String toString() {
    return 'ApiException.network()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ApiNetworkExceptionImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() network,
    required TResult Function() timeout,
    required TResult Function(int statusCode, String code, String message)
    server,
    required TResult Function(String message) unknown,
  }) {
    return network();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? network,
    TResult? Function()? timeout,
    TResult? Function(int statusCode, String code, String message)? server,
    TResult? Function(String message)? unknown,
  }) {
    return network?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? network,
    TResult Function()? timeout,
    TResult Function(int statusCode, String code, String message)? server,
    TResult Function(String message)? unknown,
    required TResult orElse(),
  }) {
    if (network != null) {
      return network();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ApiNetworkException value) network,
    required TResult Function(ApiTimeoutException value) timeout,
    required TResult Function(ApiServerException value) server,
    required TResult Function(ApiUnknownException value) unknown,
  }) {
    return network(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ApiNetworkException value)? network,
    TResult? Function(ApiTimeoutException value)? timeout,
    TResult? Function(ApiServerException value)? server,
    TResult? Function(ApiUnknownException value)? unknown,
  }) {
    return network?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ApiNetworkException value)? network,
    TResult Function(ApiTimeoutException value)? timeout,
    TResult Function(ApiServerException value)? server,
    TResult Function(ApiUnknownException value)? unknown,
    required TResult orElse(),
  }) {
    if (network != null) {
      return network(this);
    }
    return orElse();
  }
}

abstract class ApiNetworkException extends ApiException {
  const factory ApiNetworkException() = _$ApiNetworkExceptionImpl;
  const ApiNetworkException._() : super._();
}

/// @nodoc
abstract class _$$ApiTimeoutExceptionImplCopyWith<$Res> {
  factory _$$ApiTimeoutExceptionImplCopyWith(
    _$ApiTimeoutExceptionImpl value,
    $Res Function(_$ApiTimeoutExceptionImpl) then,
  ) = __$$ApiTimeoutExceptionImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ApiTimeoutExceptionImplCopyWithImpl<$Res>
    extends _$ApiExceptionCopyWithImpl<$Res, _$ApiTimeoutExceptionImpl>
    implements _$$ApiTimeoutExceptionImplCopyWith<$Res> {
  __$$ApiTimeoutExceptionImplCopyWithImpl(
    _$ApiTimeoutExceptionImpl _value,
    $Res Function(_$ApiTimeoutExceptionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ApiException
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ApiTimeoutExceptionImpl extends ApiTimeoutException {
  const _$ApiTimeoutExceptionImpl() : super._();

  @override
  String toString() {
    return 'ApiException.timeout()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ApiTimeoutExceptionImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() network,
    required TResult Function() timeout,
    required TResult Function(int statusCode, String code, String message)
    server,
    required TResult Function(String message) unknown,
  }) {
    return timeout();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? network,
    TResult? Function()? timeout,
    TResult? Function(int statusCode, String code, String message)? server,
    TResult? Function(String message)? unknown,
  }) {
    return timeout?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? network,
    TResult Function()? timeout,
    TResult Function(int statusCode, String code, String message)? server,
    TResult Function(String message)? unknown,
    required TResult orElse(),
  }) {
    if (timeout != null) {
      return timeout();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ApiNetworkException value) network,
    required TResult Function(ApiTimeoutException value) timeout,
    required TResult Function(ApiServerException value) server,
    required TResult Function(ApiUnknownException value) unknown,
  }) {
    return timeout(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ApiNetworkException value)? network,
    TResult? Function(ApiTimeoutException value)? timeout,
    TResult? Function(ApiServerException value)? server,
    TResult? Function(ApiUnknownException value)? unknown,
  }) {
    return timeout?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ApiNetworkException value)? network,
    TResult Function(ApiTimeoutException value)? timeout,
    TResult Function(ApiServerException value)? server,
    TResult Function(ApiUnknownException value)? unknown,
    required TResult orElse(),
  }) {
    if (timeout != null) {
      return timeout(this);
    }
    return orElse();
  }
}

abstract class ApiTimeoutException extends ApiException {
  const factory ApiTimeoutException() = _$ApiTimeoutExceptionImpl;
  const ApiTimeoutException._() : super._();
}

/// @nodoc
abstract class _$$ApiServerExceptionImplCopyWith<$Res> {
  factory _$$ApiServerExceptionImplCopyWith(
    _$ApiServerExceptionImpl value,
    $Res Function(_$ApiServerExceptionImpl) then,
  ) = __$$ApiServerExceptionImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int statusCode, String code, String message});
}

/// @nodoc
class __$$ApiServerExceptionImplCopyWithImpl<$Res>
    extends _$ApiExceptionCopyWithImpl<$Res, _$ApiServerExceptionImpl>
    implements _$$ApiServerExceptionImplCopyWith<$Res> {
  __$$ApiServerExceptionImplCopyWithImpl(
    _$ApiServerExceptionImpl _value,
    $Res Function(_$ApiServerExceptionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ApiException
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? statusCode = null,
    Object? code = null,
    Object? message = null,
  }) {
    return _then(
      _$ApiServerExceptionImpl(
        statusCode: null == statusCode
            ? _value.statusCode
            : statusCode // ignore: cast_nullable_to_non_nullable
                  as int,
        code: null == code
            ? _value.code
            : code // ignore: cast_nullable_to_non_nullable
                  as String,
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$ApiServerExceptionImpl extends ApiServerException {
  const _$ApiServerExceptionImpl({
    required this.statusCode,
    required this.code,
    required this.message,
  }) : super._();

  @override
  final int statusCode;
  @override
  final String code;
  @override
  final String message;

  @override
  String toString() {
    return 'ApiException.server(statusCode: $statusCode, code: $code, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ApiServerExceptionImpl &&
            (identical(other.statusCode, statusCode) ||
                other.statusCode == statusCode) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, statusCode, code, message);

  /// Create a copy of ApiException
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ApiServerExceptionImplCopyWith<_$ApiServerExceptionImpl> get copyWith =>
      __$$ApiServerExceptionImplCopyWithImpl<_$ApiServerExceptionImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() network,
    required TResult Function() timeout,
    required TResult Function(int statusCode, String code, String message)
    server,
    required TResult Function(String message) unknown,
  }) {
    return server(statusCode, code, message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? network,
    TResult? Function()? timeout,
    TResult? Function(int statusCode, String code, String message)? server,
    TResult? Function(String message)? unknown,
  }) {
    return server?.call(statusCode, code, message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? network,
    TResult Function()? timeout,
    TResult Function(int statusCode, String code, String message)? server,
    TResult Function(String message)? unknown,
    required TResult orElse(),
  }) {
    if (server != null) {
      return server(statusCode, code, message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ApiNetworkException value) network,
    required TResult Function(ApiTimeoutException value) timeout,
    required TResult Function(ApiServerException value) server,
    required TResult Function(ApiUnknownException value) unknown,
  }) {
    return server(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ApiNetworkException value)? network,
    TResult? Function(ApiTimeoutException value)? timeout,
    TResult? Function(ApiServerException value)? server,
    TResult? Function(ApiUnknownException value)? unknown,
  }) {
    return server?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ApiNetworkException value)? network,
    TResult Function(ApiTimeoutException value)? timeout,
    TResult Function(ApiServerException value)? server,
    TResult Function(ApiUnknownException value)? unknown,
    required TResult orElse(),
  }) {
    if (server != null) {
      return server(this);
    }
    return orElse();
  }
}

abstract class ApiServerException extends ApiException {
  const factory ApiServerException({
    required final int statusCode,
    required final String code,
    required final String message,
  }) = _$ApiServerExceptionImpl;
  const ApiServerException._() : super._();

  int get statusCode;
  String get code;
  String get message;

  /// Create a copy of ApiException
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ApiServerExceptionImplCopyWith<_$ApiServerExceptionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ApiUnknownExceptionImplCopyWith<$Res> {
  factory _$$ApiUnknownExceptionImplCopyWith(
    _$ApiUnknownExceptionImpl value,
    $Res Function(_$ApiUnknownExceptionImpl) then,
  ) = __$$ApiUnknownExceptionImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$ApiUnknownExceptionImplCopyWithImpl<$Res>
    extends _$ApiExceptionCopyWithImpl<$Res, _$ApiUnknownExceptionImpl>
    implements _$$ApiUnknownExceptionImplCopyWith<$Res> {
  __$$ApiUnknownExceptionImplCopyWithImpl(
    _$ApiUnknownExceptionImpl _value,
    $Res Function(_$ApiUnknownExceptionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ApiException
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$ApiUnknownExceptionImpl(
        null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$ApiUnknownExceptionImpl extends ApiUnknownException {
  const _$ApiUnknownExceptionImpl(this.message) : super._();

  @override
  final String message;

  @override
  String toString() {
    return 'ApiException.unknown(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ApiUnknownExceptionImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of ApiException
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ApiUnknownExceptionImplCopyWith<_$ApiUnknownExceptionImpl> get copyWith =>
      __$$ApiUnknownExceptionImplCopyWithImpl<_$ApiUnknownExceptionImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() network,
    required TResult Function() timeout,
    required TResult Function(int statusCode, String code, String message)
    server,
    required TResult Function(String message) unknown,
  }) {
    return unknown(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? network,
    TResult? Function()? timeout,
    TResult? Function(int statusCode, String code, String message)? server,
    TResult? Function(String message)? unknown,
  }) {
    return unknown?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? network,
    TResult Function()? timeout,
    TResult Function(int statusCode, String code, String message)? server,
    TResult Function(String message)? unknown,
    required TResult orElse(),
  }) {
    if (unknown != null) {
      return unknown(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ApiNetworkException value) network,
    required TResult Function(ApiTimeoutException value) timeout,
    required TResult Function(ApiServerException value) server,
    required TResult Function(ApiUnknownException value) unknown,
  }) {
    return unknown(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ApiNetworkException value)? network,
    TResult? Function(ApiTimeoutException value)? timeout,
    TResult? Function(ApiServerException value)? server,
    TResult? Function(ApiUnknownException value)? unknown,
  }) {
    return unknown?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ApiNetworkException value)? network,
    TResult Function(ApiTimeoutException value)? timeout,
    TResult Function(ApiServerException value)? server,
    TResult Function(ApiUnknownException value)? unknown,
    required TResult orElse(),
  }) {
    if (unknown != null) {
      return unknown(this);
    }
    return orElse();
  }
}

abstract class ApiUnknownException extends ApiException {
  const factory ApiUnknownException(final String message) =
      _$ApiUnknownExceptionImpl;
  const ApiUnknownException._() : super._();

  String get message;

  /// Create a copy of ApiException
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ApiUnknownExceptionImplCopyWith<_$ApiUnknownExceptionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
