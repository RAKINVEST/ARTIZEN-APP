import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// ADR-020 guard rail. The shipping product is **Mode 1** (identité appliquée).
/// The words reserved for **Mode 2** (restitution fidèle) must never appear in
/// user-facing copy: claiming them would promise a fidelity the product does not
/// yet deliver. Reserved: « à l'identique », « restitution / restitué / restitue »,
/// « fidèle / fidélité », « identité retrouvée », « identité documentaire ».
///
/// This test scans `lib/` and fails on any new occurrence, so the promise on
/// screen can never silently drift ahead of the engine again.
void main() {
  // Occurrences awaiting the brand-promise decision (MEP G1-T04 — product /
  // strategic). They are the founding tagline / value-prop, not a stray word, so
  // rewording them is the founder's call. Once decided, they move to Mode-1 copy
  // and are removed from this allowlist.
  const pendingBrandDecision = <String>{
    'ARTIZEN restitue la vôtre.',
    'Une seule importation. Une identité retrouvée. ',
    'Votre identité retrouvée une seule fois.',
  };

  final reserved = RegExp(
    r"à l'identique|a l'identique|restitu|fidèl|fidelit|fidélit"
    r"|identité retrouvé|identite retrouve|identité documentaire|identite documentaire",
    caseSensitive: false,
  );

  test('no Mode-2 reserved vocabulary in user-facing copy (ADR-020)', () {
    final offenders = <String>[];
    for (final entity in Directory('lib').listSync(recursive: true)) {
      if (entity is! File || !entity.path.endsWith('.dart')) continue;
      final lines = entity.readAsLinesSync();
      for (var i = 0; i < lines.length; i++) {
        final line = lines[i];
        final trimmed = line.trimLeft();
        // Comments are not user-facing; only strings shown to the artisan count.
        if (trimmed.startsWith('//')) continue;
        if (!reserved.hasMatch(line)) continue;
        if (pendingBrandDecision.any(line.contains)) continue;
        offenders.add('${entity.path}:${i + 1}: ${line.trim()}');
      }
    }

    expect(
      offenders,
      isEmpty,
      reason: 'Mode-2 reserved words (ADR-020) reached the UI:\n${offenders.join('\n')}',
    );
  });
}
