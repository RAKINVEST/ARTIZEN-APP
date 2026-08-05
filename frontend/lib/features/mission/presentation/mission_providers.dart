import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/mission_model.dart';
import '../data/mission_repository_impl.dart';

/// Server state for the list of missions.
class MissionsController extends AutoDisposeAsyncNotifier<List<Mission>> {
  @override
  Future<List<Mission>> build() => ref.read(missionRepositoryProvider).list();

  Future<void> reload() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => ref.read(missionRepositoryProvider).list());
  }
}

final missionsProvider =
    AutoDisposeAsyncNotifierProvider<MissionsController, List<Mission>>(
  MissionsController.new,
);

/// A single mission, fetched fresh (detail screen; refreshed after each action).
final missionProvider = FutureProvider.autoDispose.family<Mission, String>(
  (ref, id) => ref.read(missionRepositoryProvider).get(id),
);
