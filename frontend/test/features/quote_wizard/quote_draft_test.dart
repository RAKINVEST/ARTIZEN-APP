import 'package:artizen/features/quote_wizard/data/quote_draft.dart';
import 'package:artizen/features/quote_wizard/presentation/quote_draft_provider.dart';
import 'package:artizen/features/quote_wizard/presentation/wizard_step.dart';
import 'package:artizen/features/quotes/data/quotes_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../support/fake_repositories.dart';

DraftLine _line(String id, {num quantity = 1}) => DraftLine(
  // A catalog line's identity is its catalog item id (id == catalogItemId), so
  // operations keyed on either behave the same.
  id: id,
  catalogItemId: id,
  designation: 'Article $id',
  unit: 'unité',
  quantity: quantity,
  unitPriceHt: '10.00',
  vatRate: '10.00',
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

  test('a fresh draft is empty', () {
    final container = makeContainer();
    expect(container.read(quoteDraftProvider).isEmpty, isTrue);
    expect(container.read(quoteDraftProvider).canCreate, isFalse);
  });

  test('selectClient records the chosen client', () {
    final container = makeContainer();
    container
        .read(quoteDraftProvider.notifier)
        .selectClient(id: 'cl1', label: 'Martin Dubois');
    final draft = container.read(quoteDraftProvider);
    expect(draft.clientId, 'cl1');
    expect(draft.clientLabel, 'Martin Dubois');
    expect(draft.hasClient, isTrue);
  });

  test('adding the same article bumps its quantity instead of duplicating', () {
    final container = makeContainer();
    final draft = container.read(quoteDraftProvider.notifier);
    draft.addArticle(_line('a', quantity: 1));
    draft.addArticle(_line('a', quantity: 2));
    expect(container.read(quoteDraftProvider).lines, hasLength(1));
    expect(container.read(quoteDraftProvider).lines.single.quantity, 3);
  });

  test('setQuantity to zero removes the line', () {
    final container = makeContainer();
    final draft = container.read(quoteDraftProvider.notifier);
    draft.addArticle(_line('a'));
    draft.setQuantity('a', 0);
    expect(container.read(quoteDraftProvider).lines, isEmpty);
  });

  test('removeLine removes only that line', () {
    final container = makeContainer();
    final draft = container.read(quoteDraftProvider.notifier);
    draft.addArticle(_line('a'));
    draft.addArticle(_line('b'));
    draft.removeLine('a');
    expect(container.read(quoteDraftProvider).lines.single.catalogItemId, 'b');
  });

  test(
    'recalculate stores the server calculation; an empty draft clears it',
    () async {
      final container = makeContainer();
      final draft = container.read(quoteDraftProvider.notifier);
      draft.addArticle(_line('a'));
      draft.addArticle(_line('b'));

      await draft.recalculate();

      final calculation = container.read(quoteDraftProvider).calculation;
      expect(calculation, isNotNull);
      expect(calculation!.lines, hasLength(2));
      expect(calculation.totalTtc, '2'); // fake echoes the line count

      draft.removeLine('a');
      draft.removeLine('b');
      await draft.recalculate();
      expect(container.read(quoteDraftProvider).calculation, isNull);
    },
  );

  test('step completion is decided from the draft, not the widgets', () {
    final container = makeContainer();
    final draft = container.read(quoteDraftProvider.notifier);

    // Client step needs a client.
    expect(container.read(stepCompleteProvider(WizardStep.client)), isFalse);
    draft.selectClient(id: 'cl1', label: 'Martin');
    expect(container.read(stepCompleteProvider(WizardStep.client)), isTrue);

    // The single Catalogue step (browse / articles / caisse à outils) needs at
    // least one line on the quote.
    expect(container.read(stepCompleteProvider(WizardStep.catalogue)), isFalse);
    draft.addArticle(_line('a'));
    expect(container.read(stepCompleteProvider(WizardStep.catalogue)), isTrue);
  });

  test('reset clears the client and the lines', () {
    final container = makeContainer();
    final draft = container.read(quoteDraftProvider.notifier);
    draft.selectClient(id: 'cl1', label: 'Martin');
    draft.addArticle(_line('a'));
    draft.reset();
    expect(container.read(quoteDraftProvider).isEmpty, isTrue);
  });

  test('clearClient forgets the client but keeps the lines', () {
    final container = makeContainer();
    final draft = container.read(quoteDraftProvider.notifier);
    draft.selectClient(id: 'cl1', label: 'Martin');
    draft.addArticle(_line('a'));

    draft.clearClient();

    final state = container.read(quoteDraftProvider);
    expect(state.hasClient, isFalse);
    expect(state.clientLabel, isNull);
    expect(state.lines, hasLength(1)); // lines untouched
    expect(container.read(stepCompleteProvider(WizardStep.client)), isFalse);
  });

  // --- Objet du devis (V1.1 #6) ---

  test('setObject stores a trimmed objet; blank or null clears it', () {
    final container = makeContainer();
    final draft = container.read(quoteDraftProvider.notifier);

    draft.setObject('  Rénovation SDB — M. Dupont  ');
    expect(
      container.read(quoteDraftProvider).object,
      'Rénovation SDB — M. Dupont',
    );

    draft.setObject('   ');
    expect(container.read(quoteDraftProvider).object, isNull);

    draft.setObject('Pose chaudière');
    draft.setObject(null);
    expect(container.read(quoteDraftProvider).object, isNull);
  });

  test('the objet never gates a step (it is optional)', () {
    final container = makeContainer();
    final draft = container.read(quoteDraftProvider.notifier);
    draft.addArticle(_line('a'));
    // Personnaliser is complete on its lines alone, with or without an objet.
    expect(
      container.read(stepCompleteProvider(WizardStep.personnaliser)),
      isTrue,
    );
    draft.setObject('Un objet');
    expect(
      container.read(stepCompleteProvider(WizardStep.personnaliser)),
      isTrue,
    );
  });

  test('reset clears the objet', () {
    final container = makeContainer();
    final draft = container.read(quoteDraftProvider.notifier);
    draft.setObject('Pose chaudière');
    draft.reset();
    expect(container.read(quoteDraftProvider).object, isNull);
  });
}
