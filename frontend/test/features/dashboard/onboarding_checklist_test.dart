import 'package:artizen/features/dashboard/domain/dashboard_summary.dart';
import 'package:artizen/features/dashboard/presentation/widgets/onboarding_checklist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

DashboardSummary _summary({
  bool siret = false,
  int clients = 0,
  int items = 0,
  int quotes = 0,
}) =>
    DashboardSummary(
      clientCount: ApproximateCount(value: clients, capped: false),
      catalogItemCount: ApproximateCount(value: items, capped: false),
      quoteCount: ApproximateCount(value: quotes, capped: false),
      recentQuotes: const [],
      companyHasSiret: siret,
    );

Widget _host(DashboardSummary summary) => ProviderScope(
      child: MaterialApp(
        home: Scaffold(body: OnboardingChecklist(summary: summary)),
      ),
    );

void main() {
  testWidgets('shows the welcome header and a x/4 progress label', (tester) async {
    await tester.pumpWidget(_host(_summary(siret: true, clients: 2)));

    expect(find.text('Bienvenue ! Voici comment démarrer'), findsOneWidget);
    // Two of four steps done (company + clients).
    expect(find.text('2/4'), findsOneWidget);
    expect(find.text('Masquer'), findsOneWidget);
  });

  testWidgets('renders a check mark per completed step', (tester) async {
    await tester.pumpWidget(_host(_summary(siret: true, clients: 2)));

    expect(find.byIcon(Icons.check_circle), findsNWidgets(2));
    // The four step labels are always present, done or not.
    expect(find.text('Configurer mon entreprise'), findsOneWidget);
    expect(find.text('Ajouter un article'), findsOneWidget);
    expect(find.text('Ajouter un client'), findsOneWidget);
    expect(find.text('Créer mon premier devis'), findsOneWidget);
  });

  testWidgets('nothing done renders no check marks and 0/4', (tester) async {
    await tester.pumpWidget(_host(_summary()));

    expect(find.byIcon(Icons.check_circle), findsNothing);
    expect(find.text('0/4'), findsOneWidget);
  });
}
