import 'package:artizen/features/quote_wizard/data/quote_draft.dart';
import 'package:artizen/features/quote_wizard/presentation/quote_draft_provider.dart';
import 'package:artizen/features/quotes/data/quote_models.dart';
import 'package:artizen/features/quotes/data/quotes_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../support/fake_repositories.dart';

/// V1.1 #2 — lignes libres + prix personnalisé (décision 5). These pin the
/// data path: a free line is a full snapshot with no catalog item, two free
/// lines never collapse into one, a catalog line's price can be overridden, and
/// the wire stays byte-identical for an untouched catalog line (so the backend
/// keeps re-reading the current catalog price). No amount is computed here.
DraftLine _catalog(String id, {String price = '10.00', num quantity = 1}) =>
    DraftLine(
      id: id,
      catalogItemId: id,
      designation: 'Article $id',
      unit: 'u',
      quantity: quantity,
      unitPriceHt: price,
      vatRate: '20.00',
    );

DraftLine _free({
  String designation = 'Péage A6',
  String unit = 'trajet',
  num quantity = 2,
  String price = '12.50',
  String vat = '20.00',
}) => DraftLine(
  id: newFreeLineId(),
  designation: designation,
  unit: unit,
  quantity: quantity,
  unitPriceHt: price,
  vatRate: vat,
);

/// Pumps a bare [ProviderScope] and returns a live [WidgetRef] — the argument
/// shape [loadQuoteForEdit] takes. The element stays mounted for the test.
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

/// A persisted [QuoteLine] (read model) as it comes back from the backend.
QuoteLine _readLine(
  String id, {
  String? catalogItemId,
  required String designation,
  String unitPriceHt = '10.00',
}) => QuoteLine(
  id: id,
  catalogItemId: catalogItemId,
  designation: designation,
  unit: 'u',
  quantity: '1',
  unitPriceHt: unitPriceHt,
  vatRate: '20.00',
  totalHt: unitPriceHt,
  totalVat: '0.00',
  totalTtc: unitPriceHt,
);

void main() {
  ProviderContainer makeContainer() {
    final container = ProviderContainer(
      overrides: [
        quotesRepositoryProvider.overrideWithValue(
          FakeQuotesRepository(const []),
        ),
      ],
    );
    addTearDown(container.dispose);
    return container;
  }

  group('free lines', () {
    test('a free line has no catalogItemId and maps to a full payload', () {
      final line = _free();
      expect(line.catalogItemId, isNull);

      final json = line.toInput().toJson();
      // catalog_item_id omitted (include_if_null: false), whole snapshot sent.
      expect(json.containsKey('catalog_item_id'), isFalse);
      expect(json['designation'], 'Péage A6');
      expect(json['unit'], 'trajet');
      expect(json['unit_price_ht'], '12.50');
      expect(json['vat_rate'], '20.00');
      expect(json['quantity'], '2');
    });

    test('two distinct free lines coexist — a null catalog id never dedups', () {
      final container = makeContainer();
      final draft = container.read(quoteDraftProvider.notifier);
      draft.addArticle(_free(designation: 'Péage'));
      draft.addArticle(_free(designation: 'Location nacelle'));
      expect(container.read(quoteDraftProvider).lines, hasLength(2));
    });

    test('a free line can be fully edited then removed', () {
      final container = makeContainer();
      final draft = container.read(quoteDraftProvider.notifier);
      final line = _free(designation: 'Péage', price: '10.00');
      draft.addArticle(line);

      draft.updateFreeLine(
        line.id,
        designation: 'Péage A6 aller-retour',
        unit: 'trajet',
        quantity: 4,
        unitPriceHt: '11.00',
        vatRate: '10.00',
      );
      final edited = container.read(quoteDraftProvider).lines.single;
      expect(edited.designation, 'Péage A6 aller-retour');
      expect(edited.quantity, 4);
      expect(edited.unitPriceHt, '11.00');
      expect(edited.vatRate, '10.00');
      expect(edited.catalogItemId, isNull); // still a free line

      draft.removeLine(line.id);
      expect(container.read(quoteDraftProvider).lines, isEmpty);
    });
  });

  group('custom price on a catalog line', () {
    test('a plain catalog line sends no price (backend re-reads the catalog)', () {
      final json = _catalog('a').toInput().toJson();
      expect(json['catalog_item_id'], 'a');
      expect(json.containsKey('unit_price_ht'), isFalse);
      expect(json.keys.toSet(), {'catalog_item_id', 'quantity'});
    });

    test('overriding the price flags the line and sends the override', () {
      final container = makeContainer();
      final draft = container.read(quoteDraftProvider.notifier);
      draft.addArticle(_catalog('a', price: '10.00'));

      draft.setUnitPrice('a', '15.50');

      final line = container.read(quoteDraftProvider).lines.single;
      expect(line.priceOverridden, isTrue);
      expect(line.unitPriceHt, '15.50');

      final json = line.toInput().toJson();
      expect(json['catalog_item_id'], 'a');
      expect(json['unit_price_ht'], '15.50');
    });
  });

  group('reopening a draft (loadQuoteForEdit)', () {
    testWidgets(
      'a reopened catalog line keeps its custom price; a free line is preserved',
      (tester) async {
        final ref = await _pumpRef(tester);

        // A brouillon whose catalog line carries a price (150.00) the artisan
        // set by hand — different from any live catalog value — alongside a
        // free line. Reopening it must preserve exactly what was shown.
        final quote = Quote(
          id: 'q1',
          companyId: 'co1',
          clientId: 'cl1',
          quoteNumber: 'DEV-2026-0001',
          status: QuoteStatus.draft,
          totalHt: '162.50',
          totalVat: '32.50',
          totalTtc: '195.00',
          createdAt: DateTime(2026),
          updatedAt: DateTime(2026),
          lines: [
            _readLine(
              'ql1',
              catalogItemId: 'item-1',
              designation: 'Chaudière',
              unitPriceHt: '150.00',
            ),
            _readLine(
              'ql2',
              catalogItemId: null,
              designation: 'Péage',
              unitPriceHt: '12.50',
            ),
          ],
        );

        loadQuoteForEdit(ref, quote, clientLabel: 'Client X');
        await tester.pump();

        final lines = ref.read(quoteDraftProvider).lines;
        expect(lines, hasLength(2));

        // (4)(5) the catalog line is marked overridden and keeps its snapshot.
        final catalog = lines.firstWhere((l) => l.catalogItemId == 'item-1');
        expect(catalog.priceOverridden, isTrue);
        expect(catalog.unitPriceHt, '150.00');
        // (6)(7) toInput transmits the price, so the recreated quote keeps the
        // custom 150.00 instead of re-fetching the catalog price.
        final catInput = catalog.toInput().toJson();
        expect(catInput['catalog_item_id'], 'item-1');
        expect(catInput['unit_price_ht'], '150.00');

        // The free line still travels as a full snapshot, no catalog id.
        final free = lines.firstWhere((l) => l.catalogItemId == null);
        final freeInput = free.toInput().toJson();
        expect(freeInput.containsKey('catalog_item_id'), isFalse);
        expect(freeInput['designation'], 'Péage');
        expect(freeInput['unit_price_ht'], '12.50');
      },
    );
  });
}
