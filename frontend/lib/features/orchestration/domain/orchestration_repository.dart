import '../data/orchestration_model.dart';

/// The contract the presentation layer depends on.
abstract class OrchestrationRepository {
  Future<List<OrchestrationInstance>> list();
  Future<OrchestrationInstance> start(String planKind, Map<String, dynamic> context);
  Future<OrchestrationInstance> get(String id);
  Future<OrchestrationInstance> retry(String id);
}
