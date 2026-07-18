import 'package:artizen/features/clients/data/client_model.dart';
import 'package:artizen/features/clients/data/clients_repository_impl.dart';
import 'package:artizen/features/clients/presentation/clients_providers.dart';
import 'package:artizen/shared/providers/current_company_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../support/fake_repositories.dart';

Client _client(String id, String lastName) => Client(
      id: id,
      companyId: 'co1',
      lastName: lastName,
      createdAt: DateTime(2026),
      updatedAt: DateTime(2026),
    );

ProviderContainer _containerWith(List<Client> clients) {
  final container = ProviderContainer(
    overrides: [
      currentCompanyIdProvider.overrideWith((ref) async => 'co1'),
      clientsRepositoryProvider.overrideWithValue(FakeClientsRepository(clients)),
    ],
  );
  addTearDown(container.dispose);
  return container;
}

void main() {
  test('ClientsNotifier loads the initial page through the repository', () async {
    final container = _containerWith([_client('c1', 'Dupont')]);

    final page = await container.read(clientsNotifierProvider.future);

    expect(page.items, hasLength(1));
    expect(page.items.first.lastName, 'Dupont');
    expect(page.hasMore, isFalse);
  });

  test('ClientsNotifier.search narrows the list via the repository (server ?q=)', () async {
    final container = _containerWith([_client('c1', 'Dupont'), _client('c2', 'Martin')]);

    await container.read(clientsNotifierProvider.future);
    await container.read(clientsNotifierProvider.notifier).search('dup');

    final page = container.read(clientsNotifierProvider).value;
    expect(page!.items, hasLength(1));
    expect(page.items.first.lastName, 'Dupont');
  });

  test('ClientsNotifier.search keeps the previous rows visible while loading', () async {
    final container = _containerWith([_client('c1', 'Dupont'), _client('c2', 'Martin')]);

    await container.read(clientsNotifierProvider.future);
    final future = container.read(clientsNotifierProvider.notifier).search('dup');

    // Mid-search the state is loading, but the previous page is still there —
    // this is what stops the list from blanking on every keystroke.
    final duringSearch = container.read(clientsNotifierProvider);
    expect(duringSearch.isLoading, isTrue);
    expect(duringSearch.value, isNotNull);
    expect(duringSearch.value!.items, hasLength(2));

    await future;
  });

  test('ClientsNotifier.loadMore appends the next page and updates hasMore', () async {
    // 35 rows over a page size of 30: first page is full (hasMore), the
    // second brings the last 5 and closes it.
    final clients = [for (var i = 0; i < 35; i++) _client('c$i', 'Client$i')];
    final container = _containerWith(clients);

    final firstPage = await container.read(clientsNotifierProvider.future);
    expect(firstPage.items, hasLength(30));
    expect(firstPage.hasMore, isTrue);

    await container.read(clientsNotifierProvider.notifier).loadMore();

    final merged = container.read(clientsNotifierProvider).value!;
    expect(merged.items, hasLength(35));
    expect(merged.hasMore, isFalse);
  });
}
