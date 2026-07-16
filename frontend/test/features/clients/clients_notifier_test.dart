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

void main() {
  test('ClientsNotifier loads the initial list through the repository', () async {
    final container = ProviderContainer(
      overrides: [
        currentCompanyIdProvider.overrideWith((ref) async => 'co1'),
        clientsRepositoryProvider.overrideWithValue(
          FakeClientsRepository([_client('c1', 'Dupont')]),
        ),
      ],
    );
    addTearDown(container.dispose);

    final clients = await container.read(clientsNotifierProvider.future);

    expect(clients, hasLength(1));
    expect(clients.first.lastName, 'Dupont');
  });

  test('ClientsNotifier.search narrows the list via the repository', () async {
    final container = ProviderContainer(
      overrides: [
        currentCompanyIdProvider.overrideWith((ref) async => 'co1'),
        clientsRepositoryProvider.overrideWithValue(
          FakeClientsRepository([_client('c1', 'Dupont'), _client('c2', 'Martin')]),
        ),
      ],
    );
    addTearDown(container.dispose);

    await container.read(clientsNotifierProvider.future);
    await container.read(clientsNotifierProvider.notifier).search('dup');

    final result = container.read(clientsNotifierProvider).value;
    expect(result, hasLength(1));
    expect(result!.first.lastName, 'Dupont');
  });
}
