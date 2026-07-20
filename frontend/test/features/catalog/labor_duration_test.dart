import 'package:artizen/features/catalog/domain/labor_duration.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LaborDuration.toMinutes', () {
    test('converts each unit to minutes', () {
      expect(LaborDuration.toMinutes('30', DurationUnit.minutes), 30);
      expect(LaborDuration.toMinutes('1', DurationUnit.hours), 60);
      expect(LaborDuration.toMinutes('2', DurationUnit.hours), 120);
      expect(LaborDuration.toMinutes('4', DurationUnit.hours), 240);
      expect(LaborDuration.toMinutes('1', DurationUnit.days), 420); // 1 working day = 7 h
      expect(LaborDuration.toMinutes('2', DurationUnit.days), 840);
    });

    test('supports fractional values', () {
      expect(LaborDuration.toMinutes('1.5', DurationUnit.hours), 90);
      expect(LaborDuration.toMinutes('1,5', DurationUnit.hours), 90); // French comma
      expect(LaborDuration.toMinutes('0.5', DurationUnit.days), 210);
    });

    test('returns null for empty or invalid input', () {
      expect(LaborDuration.toMinutes('', DurationUnit.minutes), isNull);
      expect(LaborDuration.toMinutes('   ', DurationUnit.hours), isNull);
      expect(LaborDuration.toMinutes('abc', DurationUnit.hours), isNull);
      expect(LaborDuration.toMinutes('-2', DurationUnit.hours), isNull);
    });
  });

  group('LaborDuration.fromMinutes', () {
    test('picks the largest unit that divides evenly', () {
      expect(LaborDuration.fromMinutes(420).unit, DurationUnit.days);
      expect(LaborDuration.fromMinutes(420).value, '1');

      expect(LaborDuration.fromMinutes(480).unit, DurationUnit.hours); // not a whole day
      expect(LaborDuration.fromMinutes(480).value, '8');

      expect(LaborDuration.fromMinutes(120).unit, DurationUnit.hours);
      expect(LaborDuration.fromMinutes(120).value, '2');

      expect(LaborDuration.fromMinutes(90).unit, DurationUnit.minutes); // not whole hours
      expect(LaborDuration.fromMinutes(90).value, '90');
    });

    test('null minutes -> an empty minutes field', () {
      final d = LaborDuration.fromMinutes(null);
      expect(d.value, '');
      expect(d.unit, DurationUnit.minutes);
    });

    test('zero stays as 0 minutes rather than 0 days', () {
      final d = LaborDuration.fromMinutes(0);
      expect(d.value, '0');
      expect(d.unit, DurationUnit.minutes);
    });

    test('round-trips a value entered in hours back to hours', () {
      final minutes = LaborDuration.toMinutes('3', DurationUnit.hours);
      final back = LaborDuration.fromMinutes(minutes);
      expect(back.value, '3');
      expect(back.unit, DurationUnit.hours);
    });
  });
}
