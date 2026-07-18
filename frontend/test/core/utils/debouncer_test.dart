import 'package:artizen/core/utils/debouncer.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('runs only the last action of a burst', () async {
    final debouncer = Debouncer(const Duration(milliseconds: 50));
    final fired = <int>[];

    debouncer.run(() => fired.add(1));
    debouncer.run(() => fired.add(2));
    debouncer.run(() => fired.add(3));

    // Nothing has fired synchronously — the window is still open.
    expect(fired, isEmpty);

    await Future<void>.delayed(const Duration(milliseconds: 120));
    expect(fired, [3]);
  });

  test('cancel drops a pending action but leaves the debouncer reusable', () async {
    final debouncer = Debouncer(const Duration(milliseconds: 50));
    final fired = <int>[];

    debouncer.run(() => fired.add(1));
    debouncer.cancel();
    await Future<void>.delayed(const Duration(milliseconds: 120));
    expect(fired, isEmpty);

    debouncer.run(() => fired.add(2));
    await Future<void>.delayed(const Duration(milliseconds: 120));
    expect(fired, [2]);
  });
}
