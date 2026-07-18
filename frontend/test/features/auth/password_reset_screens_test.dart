import 'package:artizen/core/api/api_exception.dart';
import 'package:artizen/features/auth/data/auth_repository.dart';
import 'package:artizen/features/auth/presentation/forgot_password_screen.dart';
import 'package:artizen/features/auth/presentation/reset_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../support/fake_auth_repository.dart';

/// Wraps a screen with the ProviderScope + MaterialApp it needs, overriding
/// the auth repository with an in-memory fake so no HTTP is attempted.
Widget _host(Widget child, FakeAuthRepository repo) => ProviderScope(
      overrides: [authRepositoryProvider.overrideWithValue(repo)],
      child: MaterialApp(home: child),
    );

void main() {
  group('ForgotPasswordScreen', () {
    testWidgets('sends the email and shows the neutral anti-enumeration message',
        (tester) async {
      final repo = FakeAuthRepository();
      await tester.pumpWidget(_host(const ForgotPasswordScreen(), repo));

      await tester.enterText(find.byType(TextFormField), 'a@artizen-qa.io');
      await tester.tap(find.byType(FilledButton));
      await tester.pumpAndSettle();

      expect(repo.lastForgotPasswordEmail, 'a@artizen-qa.io');
      // Must never confirm whether the account exists.
      expect(find.textContaining('Si un compte existe pour cet email'), findsOneWidget);
    });

    testWidgets('blocks an obviously malformed email before any request', (tester) async {
      final repo = FakeAuthRepository();
      await tester.pumpWidget(_host(const ForgotPasswordScreen(), repo));

      await tester.enterText(find.byType(TextFormField), 'not-an-email');
      await tester.tap(find.byType(FilledButton));
      await tester.pump();

      expect(find.text('Email invalide'), findsOneWidget);
      expect(repo.lastForgotPasswordEmail, isNull);
    });
  });

  group('ResetPasswordScreen', () {
    testWidgets('rejects mismatched passwords without calling the backend', (tester) async {
      final repo = FakeAuthRepository();
      await tester.pumpWidget(_host(const ResetPasswordScreen(token: 'tok'), repo));

      await tester.enterText(find.byType(TextFormField).at(0), 'secret123');
      await tester.enterText(find.byType(TextFormField).at(1), 'different1');
      await tester.tap(find.byType(FilledButton));
      await tester.pump();

      expect(find.text('Les mots de passe ne correspondent pas'), findsOneWidget);
      expect(repo.lastResetToken, isNull);
    });

    testWidgets('maps a 400 to the "invalid or expired" message', (tester) async {
      final repo = FakeAuthRepository()
        ..resetPasswordError = const ApiException.server(
          statusCode: 400,
          code: 'invalid_token',
          message: 'raw backend message',
        );
      await tester.pumpWidget(_host(const ResetPasswordScreen(token: 'tok'), repo));

      await tester.enterText(find.byType(TextFormField).at(0), 'secret123');
      await tester.enterText(find.byType(TextFormField).at(1), 'secret123');
      await tester.tap(find.byType(FilledButton));
      await tester.pumpAndSettle();

      expect(find.textContaining('invalide ou expiré'), findsOneWidget);
    });

    testWidgets('with no token, shows the invalid-link state and no form', (tester) async {
      await tester.pumpWidget(_host(const ResetPasswordScreen(token: null), FakeAuthRepository()));

      expect(find.textContaining('invalide ou expiré'), findsOneWidget);
      expect(find.byType(TextFormField), findsNothing);
    });
  });
}
