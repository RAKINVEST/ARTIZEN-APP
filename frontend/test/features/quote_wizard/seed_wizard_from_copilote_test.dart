import 'package:artizen/features/catalog/data/catalog_models.dart';
import 'package:artizen/features/quote_wizard/data/quote_draft.dart';
import 'package:artizen/features/quote_wizard/presentation/quote_draft_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

/// The copilote IA → wizard bridge (V1.1 chantier #1): "Créer le devis" in the
/// copilote seeds the *wizard's* draft with the accepted articles, then lands
/// the artisan in the guided wizard (choisir le client → vérifier → créer).
/// These tests pin the seam — [seedWizardFromCatalogItems] — so a copilote line
/// and a hand-picked wizard line end up indistinguishable, and the artisan can
/// still adjust or drop what the AI proposed.
CatalogItem _item(
  String id,
  String designation, {
  String unit = 'u',
  String unitPriceHt = '10.00',
  String vatRate = '10.00',
}) =>
    CatalogItem(
      id: id,
      companyId: 'co1',
      categoryId: 'cat1',
      designation: designation,
      itemType: ItemType.service,
      unit: unit,
      unitPriceHt: unitPriceHt,
      vatRate: vatRate,
      active: true,
      createdAt: DateTime(2026),
      updatedAt: DateTime(2026),
    );

/// Pumps a bare [ProviderScope] and hands back a live [WidgetRef] — the exact
/// argument shape [seedWizardFromCatalogItems] takes when the copilote screen
/// calls it. The element stays mounted for the test, so `ref.read` is valid.
Future<WidgetRef> _pumpRef(WidgetTester tester) async {
  late WidgetRef captured;
  await tester.pumpWidget(
    ProviderScope(
      child: Consumer(
        builder: (context, ref, _) {
          captured = ref;
          return const SizedBox();
        },
      ),
    ),
  );
  return captured;
}

void main() {
  testWidgets('seeds the wizard draft from the accepted articles (nominal)', (
    tester,
  ) async {
    final ref = await _pumpRef(tester);

    seedWizardFromCatalogItems(ref, [
      (item: _item('a', 'Alpha'), quantity: 2),
      (
        item: _item('b', 'Beta', unit: 'ml', unitPriceHt: '5.50', vatRate: '20.00'),
        quantity: 1,
      ),
    ]);
    await tester.pump();

    final draft = ref.read(quoteDraftProvider);
    expect(draft.lines, hasLength(2));

    // The mapping CatalogItem -> DraftLine must be complete: nothing the
    // backend needs to price the line may be dropped on the way in.
    final alpha = draft.lines.firstWhere((l) => l.catalogItemId == 'a');
    expect(alpha.designation, 'Alpha');
    expect(alpha.unit, 'u');
    expect(alpha.quantity, 2);
    expect(alpha.unitPriceHt, '10.00');
    expect(alpha.vatRate, '10.00');

    final beta = draft.lines.firstWhere((l) => l.catalogItemId == 'b');
    expect(beta.unit, 'ml');
    expect(beta.quantity, 1);
    expect(beta.unitPriceHt, '5.50');
    expect(beta.vatRate, '20.00');

    // The copilote proposes lines only — the wizard's Client step decides who
    // the quote is for, so the seeded draft carries no client yet.
    expect(draft.hasClient, isFalse);
    expect(draft.hasLines, isTrue);
    // A brand-new quote, not an edit of an existing one, and not yet created.
    expect(ref.read(editingQuoteIdProvider), isNull);
    expect(ref.read(createdQuoteProvider), isNull);
  });

  testWidgets('the seeded lines are an ordinary wizard draft the artisan can '
      'still adjust or drop', (tester) async {
    final ref = await _pumpRef(tester);
    final notifier = ref.read(quoteDraftProvider.notifier);

    seedWizardFromCatalogItems(ref, [
      (item: _item('a', 'Alpha'), quantity: 2),
      (item: _item('b', 'Beta'), quantity: 1),
    ]);
    await tester.pump();

    // Adjust the AI's quantity — "possibilité de modifier".
    notifier.setQuantity('a', 5);
    expect(
      ref.read(quoteDraftProvider).lines.firstWhere((l) => l.catalogItemId == 'a').quantity,
      5,
    );

    // Drop a line the AI proposed.
    notifier.removeLine('b');
    final lines = ref.read(quoteDraftProvider).lines;
    expect(lines, hasLength(1));
    expect(lines.single.catalogItemId, 'a');
  });

  testWidgets('a fresh seed replaces any stale wizard draft', (tester) async {
    final ref = await _pumpRef(tester);
    final notifier = ref.read(quoteDraftProvider.notifier);

    // A leftover draft from a previous, abandoned wizard session.
    notifier.selectClient(id: 'old-client', label: 'Ancien client');
    notifier.addArticle(
      const DraftLine(
        catalogItemId: 'stale',
        designation: 'Ligne périmée',
        unit: 'u',
        quantity: 9,
        unitPriceHt: '99.00',
        vatRate: '20.00',
      ),
    );

    seedWizardFromCatalogItems(ref, [
      (item: _item('a', 'Alpha'), quantity: 1),
    ]);
    await tester.pump();

    final draft = ref.read(quoteDraftProvider);
    expect(draft.lines, hasLength(1));
    expect(draft.lines.single.catalogItemId, 'a');
    // reset() wiped the stale client too — the seed starts clean.
    expect(draft.hasClient, isFalse);
  });

  testWidgets('seeding an empty list yields an empty draft (no article '
      'resolved)', (tester) async {
    final ref = await _pumpRef(tester);

    seedWizardFromCatalogItems(ref, const []);
    await tester.pump();

    final draft = ref.read(quoteDraftProvider);
    expect(draft.lines, isEmpty);
    expect(draft.hasLines, isFalse);
    expect(draft.canCreate, isFalse);
  });
}
