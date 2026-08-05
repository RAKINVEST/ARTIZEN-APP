import '../data/decision_model.dart';

/// The contract the presentation layer depends on. One Dio-backed
/// implementation exists; the interface keeps providers/tests swappable — the
/// same reasoning as the other features.
abstract class DecisionRepository {
  /// `POST /decision/propose` — intention → explained proposal (read-side).
  Future<DecisionResult> propose(String intent);

  /// `POST /decision/interpret` — understands the intention only.
  Future<DecisionIntent> interpret(String intent);
}
