import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/planning_model.dart';
import '../data/planning_repository_impl.dart';

/// Server state for the schedule.
class PlanningController extends AutoDisposeAsyncNotifier<List<PlanningEntry>> {
  @override
  Future<List<PlanningEntry>> build() => ref.read(planningRepositoryProvider).list();

  Future<void> reload() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => ref.read(planningRepositoryProvider).list());
  }
}

final planningProvider =
    AutoDisposeAsyncNotifierProvider<PlanningController, List<PlanningEntry>>(
  PlanningController.new,
);

final planningEntryProvider =
    FutureProvider.autoDispose.family<PlanningEntry, String>(
  (ref, id) => ref.read(planningRepositoryProvider).get(id),
);
