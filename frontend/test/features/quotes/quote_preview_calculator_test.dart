import 'package:artizen/features/catalog/data/catalog_models.dart';
import 'package:artizen/features/quotes/domain/quote_draft_line.dart';
import 'package:artizen/features/quotes/domain/quote_preview_calculator.dart';
import 'package:flutter_test/flutter_test.dart';

CatalogItem _item({
  String id = 'item-1',
  String unitPriceHt = '100.00',
  String vatRate = '20.00',
  String unit = 'u',
}) =>
    CatalogItem(
      id: id,
      companyId: 'co1',
      categoryId: 'cat-1',
      designation: 'Article',
      itemType: ItemType.service,
      unit: unit,
      unitPriceHt: unitPriceHt,
      vatRate: vatRate,
      active: true,
      createdAt: DateTime(2026),
      updatedAt: DateTime(2026),
    );

void main() {
  group('parseHundredths', () {
    test('parses plain and French-comma decimals into hundredths', () {
      expect(QuotePreviewCalculator.parseHundredths('2'), 200);
      expect(QuotePreviewCalculator.parseHundredths('2.5'), 250);
      expect(QuotePreviewCalculator.parseHundredths('2,5'), 250);
      expect(QuotePreviewCalculator.parseHundredths('0.05'), 5);
    });

    test('rejects empty, non-numeric and negative values', () {
      expect(QuotePreviewCalculator.parseHundredths(''), isNull);
      expect(QuotePreviewCalculator.parseHundredths('   '), isNull);
      expect(QuotePreviewCalculator.parseHundredths('abc'), isNull);
      expect(QuotePreviewCalculator.parseHundredths('-1'), isNull);
      expect(QuotePreviewCalculator.parseHundredths(null), isNull);
    });
  });

  group('line — mirrors backend QuoteCalculator.calculate_line', () {
    test('total = unit price × quantity (bug #5: quantity must move the price)', () {
      final one = QuotePreviewCalculator.line(quantity: '1', unitPriceHt: '100.00', vatRate: '20.00')!;
      expect(one.totalHtCents, 10000); // 100.00 €
      expect(one.totalVatCents, 2000); // 20.00 €
      expect(one.totalTtcCents, 12000); // 120.00 €

      final two = QuotePreviewCalculator.line(quantity: '2', unitPriceHt: '100.00', vatRate: '20.00')!;
      expect(two.totalHtCents, 20000); // 200.00 €  -> doubles with quantity
      expect(two.totalVatCents, 4000);
      expect(two.totalTtcCents, 24000); // 240.00 €

      final five = QuotePreviewCalculator.line(quantity: '5', unitPriceHt: '100.00', vatRate: '20.00')!;
      expect(five.totalHtCents, 50000);
      final ten = QuotePreviewCalculator.line(quantity: '10', unitPriceHt: '100.00', vatRate: '20.00')!;
      expect(ten.totalHtCents, 100000);
    });

    test('supports decimal quantities', () {
      final line = QuotePreviewCalculator.line(quantity: '2.5', unitPriceHt: '40.00', vatRate: '20.00')!;
      expect(line.totalHtCents, 10000); // 2.5 × 40 = 100.00 €
      expect(line.totalTtcCents, 12000);
    });

    test('rounds the HT to the cent with ROUND_HALF_UP (0.055 -> 0.06)', () {
      // 0.05 × 1.10 = 0.055 -> 0.06 €, exactly like the backend Decimal rule.
      final line = QuotePreviewCalculator.line(quantity: '0.05', unitPriceHt: '1.10', vatRate: '20.00')!;
      expect(line.totalHtCents, 6);
    });

    test('computes VAT on the already-rounded HT', () {
      final line = QuotePreviewCalculator.line(quantity: '1', unitPriceHt: '20.01', vatRate: '20.00')!;
      expect(line.totalHtCents, 2001); // 20.01 €
      expect(line.totalVatCents, 400); // round(20.01 × 20% = 4.002) = 4.00 €
      expect(line.totalTtcCents, 2401);
    });

    test('returns null when the quantity cannot be parsed', () {
      expect(QuotePreviewCalculator.line(quantity: '', unitPriceHt: '100.00', vatRate: '20.00'), isNull);
      expect(QuotePreviewCalculator.line(quantity: 'x', unitPriceHt: '100.00', vatRate: '20.00'), isNull);
    });
  });

  group('totals — sum of per-line rounded totals', () {
    test('adds up multiple lines', () {
      final totals = QuotePreviewCalculator.totals([
        QuoteDraftLine(item: _item(unitPriceHt: '100.00', vatRate: '20.00'), quantity: '2'),
        QuoteDraftLine(item: _item(id: 'item-2', unitPriceHt: '50.00', vatRate: '10.00'), quantity: '1'),
      ]);
      // Line 1: HT 200.00, VAT 40.00. Line 2: HT 50.00, VAT 5.00.
      expect(totals.totalHtCents, 25000); // 250.00 €
      expect(totals.totalVatCents, 4500); // 45.00 €
      expect(totals.totalTtcCents, 29500); // 295.00 €
    });

    test('ignores lines whose quantity is not parseable', () {
      final totals = QuotePreviewCalculator.totals([
        QuoteDraftLine(item: _item(unitPriceHt: '100.00', vatRate: '20.00'), quantity: '1'),
        QuoteDraftLine(item: _item(id: 'item-2', unitPriceHt: '50.00', vatRate: '20.00'), quantity: ''),
      ]);
      expect(totals.totalHtCents, 10000); // only the valid line counts
    });
  });

  group('centsToAmountString', () {
    test('formats integer cents as a two-decimal string', () {
      expect(QuotePreviewCalculator.centsToAmountString(24000), '240.00');
      expect(QuotePreviewCalculator.centsToAmountString(6), '0.06');
      expect(QuotePreviewCalculator.centsToAmountString(1234), '12.34');
      expect(QuotePreviewCalculator.centsToAmountString(0), '0.00');
    });
  });
}
