import 'package:artizen/features/dashboard/domain/dashboard_summary.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ApproximateCount', () {
    test('shows the plain number when the page was not full', () {
      const count = ApproximateCount(value: 12, capped: false);

      expect(count.display, '12');
    });

    test('shows "N+" when the page filled up, because N is a floor', () {
      // The dashboard counts a paginated list, so a full page means "at
      // least 100" — never "100". An artisan with 250 clients was shown a
      // flat "100" forever, with nothing to hint it was wrong.
      const count = ApproximateCount(value: 100, capped: true);

      expect(count.display, '100+');
    });

    test('an empty result is still an exact zero', () {
      const count = ApproximateCount(value: 0, capped: false);

      expect(count.display, '0');
    });
  });
}
