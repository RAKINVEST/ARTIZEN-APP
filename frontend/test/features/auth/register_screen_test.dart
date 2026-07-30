import 'package:artizen/features/auth/data/auth_repository.dart';
import 'package:artizen/features/auth/presentation/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../support/fake_auth_repository.dart';

Widget _host(Widget child, FakeAuthRepository repo) => ProviderScope(
      overrides: [authRepositoryProvider.overrideWithValue(repo)],
      child: MaterialApp(home: child),
    );

void main() {
  testWidgets('surfaces the CGU and privacy links so legal is reachable before signup',
      (tester) async {
    await tester.pumpWidget(_host(const RegisterScreen(), FakeAuthRepository()));

    expect(find.textContaining('En créant un compte'), findsOneWidget);
    expect(find.text('CGU'), findsOneWidget);
    expect(find.text('politique de confidentialité'), findsOneWidget);
  });
}
