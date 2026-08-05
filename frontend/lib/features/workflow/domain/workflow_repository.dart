import '../data/workflow_model.dart';

/// The contract the presentation layer depends on.
abstract class WorkflowRepository {
  Future<List<WorkflowDefinition>> definitions();
  Future<List<WorkflowInstance>> listInstances();
  Future<WorkflowInstance> start(String definitionSlug, Map<String, dynamic> context);
  Future<WorkflowInstance> instance(String id);

  /// Applies a transition (a step validation). May fail 409 if not allowed.
  Future<WorkflowInstance> transition(String id, String event);
}
