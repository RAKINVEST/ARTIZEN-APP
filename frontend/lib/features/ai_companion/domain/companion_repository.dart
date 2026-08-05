import '../data/companion_model.dart';

/// The contract the presentation layer depends on. Mirrors `/ai/*`.
abstract class CompanionRepository {
  Future<ChatResponse> chat(String message, {String? sessionId, Map<String, dynamic>? params});
  Future<ChatResponse> continueConversation(
    String sessionId,
    String message, {
    Map<String, dynamic>? params,
  });
  Future<ChatResponse> confirm(String sessionId);
  Future<ChatResponse> cancel(String sessionId);
  Future<void> deleteSession(String sessionId);
}
