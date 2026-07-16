import 'package:artizen/features/quote_assistant/data/quote_assistant_repository_impl.dart';
import 'package:artizen/features/quote_assistant/data/quote_suggestion_models.dart';
import 'package:artizen/features/quote_assistant/presentation/quote_assistant_providers.dart';
import 'package:artizen/shared/providers/current_company_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../support/fake_repositories.dart';

QuoteSuggestion _suggestion() => const QuoteSuggestion(
      items: [
        QuoteSuggestionItem(
          catalogItemId: 'item-1',
          designation: 'Chauffe-eau Atlantic 200 L',
          quantity: '1',
          reason: 'Correspondance directe',
        ),
      ],
      confidence: 0.9,
      comment: 'ok',
    );

void main() {
  test('QuoteAssistantNotifier.analyze populates the suggestion and accepted items', () async {
    final container = ProviderContainer(
      overrides: [
        currentCompanyIdProvider.overrideWith((ref) async => 'co1'),
        quoteAssistantRepositoryProvider.overrideWithValue(
          FakeQuoteAssistantRepository(_suggestion()),
        ),
      ],
    );
    addTearDown(container.dispose);

    await container.read(quoteAssistantNotifierProvider.notifier).analyze('description libre');

    final state = container.read(quoteAssistantNotifierProvider).value;
    expect(state, isNotNull);
    expect(state!.items, hasLength(1));

    final accepted = container.read(acceptedSuggestionItemsProvider);
    expect(accepted, hasLength(1));
    expect(accepted.first.catalogItemId, 'item-1');
  });

  test('AcceptedSuggestionItemsNotifier allows editing quantity and removing an item', () async {
    final container = ProviderContainer(
      overrides: [
        currentCompanyIdProvider.overrideWith((ref) async => 'co1'),
        quoteAssistantRepositoryProvider.overrideWithValue(
          FakeQuoteAssistantRepository(_suggestion()),
        ),
      ],
    );
    addTearDown(container.dispose);

    await container.read(quoteAssistantNotifierProvider.notifier).analyze('description libre');

    container.read(acceptedSuggestionItemsProvider.notifier).updateQuantity(0, '3');
    expect(container.read(acceptedSuggestionItemsProvider).first.quantity, '3');

    container.read(acceptedSuggestionItemsProvider.notifier).removeAt(0);
    expect(container.read(acceptedSuggestionItemsProvider), isEmpty);
  });

  test('AcceptedSuggestionItemsNotifier.addItem appends a manually-added line', () async {
    final container = ProviderContainer(
      overrides: [
        currentCompanyIdProvider.overrideWith((ref) async => 'co1'),
        quoteAssistantRepositoryProvider.overrideWithValue(
          FakeQuoteAssistantRepository(_suggestion()),
        ),
      ],
    );
    addTearDown(container.dispose);

    await container.read(quoteAssistantNotifierProvider.notifier).analyze('description libre');

    container.read(acceptedSuggestionItemsProvider.notifier).addItem(
          const QuoteSuggestionItem(
            catalogItemId: 'item-2',
            designation: 'Groupe de sécurité',
            quantity: '1',
            reason: 'Ajouté manuellement',
          ),
        );

    final accepted = container.read(acceptedSuggestionItemsProvider);
    expect(accepted, hasLength(2));
    expect(accepted.last.catalogItemId, 'item-2');
    expect(accepted.last.reason, 'Ajouté manuellement');
  });

  test('QuoteAssistantNotifier.clear resets both the suggestion and accepted items', () async {
    final container = ProviderContainer(
      overrides: [
        currentCompanyIdProvider.overrideWith((ref) async => 'co1'),
        quoteAssistantRepositoryProvider.overrideWithValue(
          FakeQuoteAssistantRepository(_suggestion()),
        ),
      ],
    );
    addTearDown(container.dispose);

    await container.read(quoteAssistantNotifierProvider.notifier).analyze('description libre');
    container.read(quoteAssistantNotifierProvider.notifier).clear();

    expect(container.read(quoteAssistantNotifierProvider).value, isNull);
    expect(container.read(acceptedSuggestionItemsProvider), isEmpty);
  });
}
