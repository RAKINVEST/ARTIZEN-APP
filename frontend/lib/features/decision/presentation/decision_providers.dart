import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/decision_model.dart';
import '../data/decision_repository_impl.dart';

/// Holds the last decision result. `null` = nothing asked yet. Every request
/// funnels through [propose] so the screen renders one consistent async state
/// (CLAUDE.md: server state in an AsyncNotifier).
class DecisionController extends AutoDisposeAsyncNotifier<DecisionResult?> {
  @override
  Future<DecisionResult?> build() async => null;

  Future<void> propose(String intent) async {
    if (intent.trim().isEmpty) return;
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(decisionRepositoryProvider).propose(intent.trim()),
    );
  }

  void reset() => state = const AsyncData(null);
}

final decisionControllerProvider =
    AutoDisposeAsyncNotifierProvider<DecisionController, DecisionResult?>(
  DecisionController.new,
);
