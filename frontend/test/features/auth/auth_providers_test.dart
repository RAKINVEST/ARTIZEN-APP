import 'package:artizen/core/api/auth_session.dart';
import 'package:artizen/features/auth/data/auth_repository.dart';
import 'package:artizen/features/auth/presentation/auth_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../support/fake_auth_repository.dart';

void main() {
  test('build() reflects the repository\'s initial isLoggedIn state', () async {
    final repo = FakeAuthRepository()..loggedIn = true;
    final container = ProviderContainer(
      overrides: [authRepositoryProvider.overrideWithValue(repo)],
    );
    addTearDown(container.dispose);

    expect(await container.read(authNotifierProvider.future), isTrue);
  });

  test('login() delegates to the repository and flips state to true', () async {
    final repo = FakeAuthRepository();
    final container = ProviderContainer(
      overrides: [authRepositoryProvider.overrideWithValue(repo)],
    );
    addTearDown(container.dispose);
    await container.read(authNotifierProvider.future);

    await container.read(authNotifierProvider.notifier).login(email: 'a@artizen-qa.io', password: 'secret123');

    expect(repo.lastLoginEmail, 'a@artizen-qa.io');
    expect(container.read(authNotifierProvider).value, isTrue);
  });

  test('login() propagates repository failures without changing state', () async {
    final repo = FakeAuthRepository()..shouldFailLogin = true;
    final container = ProviderContainer(
      overrides: [authRepositoryProvider.overrideWithValue(repo)],
    );
    addTearDown(container.dispose);
    await container.read(authNotifierProvider.future);

    await expectLater(
      container.read(authNotifierProvider.notifier).login(email: 'a@artizen-qa.io', password: 'wrong'),
      throwsException,
    );
    expect(container.read(authNotifierProvider).value, isFalse);
  });

  test('register() delegates to the repository and flips state to true', () async {
    final repo = FakeAuthRepository();
    final container = ProviderContainer(
      overrides: [authRepositoryProvider.overrideWithValue(repo)],
    );
    addTearDown(container.dispose);
    await container.read(authNotifierProvider.future);

    await container.read(authNotifierProvider.notifier).register(
          email: 'new@artizen-qa.io',
          password: 'secret123',
          companyName: 'Atelier Test',
        );

    expect(repo.lastRegisterCompanyName, 'Atelier Test');
    expect(container.read(authNotifierProvider).value, isTrue);
  });

  test('logout() delegates to the repository and flips state to false', () async {
    final repo = FakeAuthRepository()..loggedIn = true;
    final container = ProviderContainer(
      overrides: [authRepositoryProvider.overrideWithValue(repo)],
    );
    addTearDown(container.dispose);
    await container.read(authNotifierProvider.future);

    await container.read(authNotifierProvider.notifier).logout();

    expect(repo.loggedIn, isFalse);
    expect(container.read(authNotifierProvider).value, isFalse);
  });

  test('bumping the session epoch re-checks the repository (401 clearing the token mid-session)', () async {
    final repo = FakeAuthRepository()..loggedIn = true;
    final container = ProviderContainer(
      overrides: [authRepositoryProvider.overrideWithValue(repo)],
    );
    addTearDown(container.dispose);
    expect(await container.read(authNotifierProvider.future), isTrue);

    // Simulates ErrorInterceptor's onUnauthorized clearing the token via
    // AuthTokenStorage directly (see core/api/dio_client.dart) — the fake
    // repository has no real token storage, so flipping `loggedIn` stands
    // in for "the token is now gone".
    repo.loggedIn = false;
    container.read(authSessionEpochProvider.notifier).state++;

    expect(await container.read(authNotifierProvider.future), isFalse);
  });
}
