import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/orchestration_model.dart';
import '../data/orchestration_repository_impl.dart';

/// Server state for the list of orchestrations.
class OrchestrationsController
    extends AutoDisposeAsyncNotifier<List<OrchestrationInstance>> {
  @override
  Future<List<OrchestrationInstance>> build() =>
      ref.read(orchestrationRepositoryProvider).list();

  Future<void> reload() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(orchestrationRepositoryProvider).list(),
    );
  }
}

final orchestrationsProvider = AutoDisposeAsyncNotifierProvider<
    OrchestrationsController, List<OrchestrationInstance>>(
  OrchestrationsController.new,
);

final orchestrationProvider =
    FutureProvider.autoDispose.family<OrchestrationInstance, String>(
  (ref, id) => ref.read(orchestrationRepositoryProvider).get(id),
);
