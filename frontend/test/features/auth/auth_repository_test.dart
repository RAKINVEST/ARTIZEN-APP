import 'package:artizen/features/auth/data/auth_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../support/fake_auth_token_storage.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late MockDio dio;
  late FakeAuthTokenStorage tokenStorage;
  late AuthRepository repository;

  setUp(() {
    dio = MockDio();
    tokenStorage = FakeAuthTokenStorage();
    repository = AuthRepository(dio, tokenStorage);
  });

  test('isLoggedIn() is false with no stored token', () async {
    expect(await repository.isLoggedIn(), isFalse);
  });

  test('login() posts credentials and persists the returned access token', () async {
    when(() => dio.post<Map<String, dynamic>>(
          '/auth/login',
          data: {'email': 'a@artizen-qa.io', 'password': 'secret123'},
        )).thenAnswer(
      (_) async => Response(
        requestOptions: RequestOptions(path: '/auth/login'),
        statusCode: 200,
        data: {'access_token': 'jwt-token', 'token_type': 'bearer'},
      ),
    );

    await repository.login(email: 'a@artizen-qa.io', password: 'secret123');

    expect(await tokenStorage.readToken(), 'jwt-token');
  });

  test('register() omits blank optional fields and persists the returned token', () async {
    when(() => dio.post<Map<String, dynamic>>(
          '/auth/register',
          data: {'email': 'new@artizen-qa.io', 'password': 'secret123'},
        )).thenAnswer(
      (_) async => Response(
        requestOptions: RequestOptions(path: '/auth/register'),
        statusCode: 201,
        data: {'access_token': 'new-jwt', 'token_type': 'bearer'},
      ),
    );

    await repository.register(email: 'new@artizen-qa.io', password: 'secret123', fullName: '  ', companyName: '');

    expect(await tokenStorage.readToken(), 'new-jwt');
  });

  test('register() includes full name and company name when provided', () async {
    when(() => dio.post<Map<String, dynamic>>(
          '/auth/register',
          data: {
            'email': 'new@artizen-qa.io',
            'password': 'secret123',
            'full_name': 'Jane Doe',
            'company_name': 'Atelier Jane',
          },
        )).thenAnswer(
      (_) async => Response(
        requestOptions: RequestOptions(path: '/auth/register'),
        statusCode: 201,
        data: {'access_token': 'new-jwt', 'token_type': 'bearer'},
      ),
    );

    await repository.register(
      email: 'new@artizen-qa.io',
      password: 'secret123',
      fullName: 'Jane Doe',
      companyName: 'Atelier Jane',
    );

    verify(() => dio.post<Map<String, dynamic>>(
          '/auth/register',
          data: {
            'email': 'new@artizen-qa.io',
            'password': 'secret123',
            'full_name': 'Jane Doe',
            'company_name': 'Atelier Jane',
          },
        )).called(1);
  });

  test('logout() clears the stored token', () async {
    await tokenStorage.saveToken('jwt-token');

    await repository.logout();

    expect(await tokenStorage.readToken(), isNull);
  });

  test('requestPasswordReset() posts the email and ignores the (204) body', () async {
    when(() => dio.post<void>(
          '/auth/forgot-password',
          data: {'email': 'a@artizen-qa.io'},
        )).thenAnswer(
      (_) async => Response(
        requestOptions: RequestOptions(path: '/auth/forgot-password'),
        statusCode: 204,
      ),
    );

    await repository.requestPasswordReset('a@artizen-qa.io');

    verify(() => dio.post<void>(
          '/auth/forgot-password',
          data: {'email': 'a@artizen-qa.io'},
        )).called(1);
  });

  test('resetPassword() posts the token and the new password', () async {
    when(() => dio.post<void>(
          '/auth/reset-password',
          data: {'token': 'reset-tok', 'password': 'secret123'},
        )).thenAnswer(
      (_) async => Response(
        requestOptions: RequestOptions(path: '/auth/reset-password'),
        statusCode: 204,
      ),
    );

    await repository.resetPassword(token: 'reset-tok', password: 'secret123');

    verify(() => dio.post<void>(
          '/auth/reset-password',
          data: {'token': 'reset-tok', 'password': 'secret123'},
        )).called(1);
  });
}
