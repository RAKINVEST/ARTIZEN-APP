import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/workflow_model.dart';
import '../data/workflow_repository_impl.dart';

/// Server state for the list of workflow instances.
class WorkflowInstancesController extends AutoDisposeAsyncNotifier<List<WorkflowInstance>> {
  @override
  Future<List<WorkflowInstance>> build() {
    return ref.read(workflowRepositoryProvider).listInstances();
  }

  Future<void> reload() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => ref.read(workflowRepositoryProvider).listInstances());
  }

  Future<WorkflowInstance> start(String slug, Map<String, dynamic> context) async {
    final created = await ref.read(workflowRepositoryProvider).start(slug, context);
    await reload();
    return created;
  }
}

final workflowInstancesProvider =
    AutoDisposeAsyncNotifierProvider<WorkflowInstancesController, List<WorkflowInstance>>(
  WorkflowInstancesController.new,
);

/// A single instance, fetched fresh (used by the detail screen and refreshed
/// after each transition).
final workflowInstanceProvider =
    FutureProvider.autoDispose.family<WorkflowInstance, String>(
  (ref, id) => ref.read(workflowRepositoryProvider).instance(id),
);
