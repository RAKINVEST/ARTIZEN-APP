import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/companion_model.dart';
import '../data/companion_repository_impl.dart';

/// One line in the conversation: a user message, or an assistant reply carrying
/// its full explainable [ChatResponse] (reasoning, sources, proposed action).
class CompanionMessage {
  const CompanionMessage({required this.role, required this.text, this.response});

  final String role; // user | assistant
  final String text;
  final ChatResponse? response;

  bool get isUser => role == 'user';
}

class CompanionState {
  const CompanionState({
    this.sessionId,
    this.messages = const [],
    this.sending = false,
    this.error,
  });

  final String? sessionId;
  final List<CompanionMessage> messages;
  final bool sending;
  final String? error;

  CompanionState copyWith({
    String? sessionId,
    List<CompanionMessage>? messages,
    bool? sending,
    String? error,
  }) {
    return CompanionState(
      sessionId: sessionId ?? this.sessionId,
      messages: messages ?? this.messages,
      sending: sending ?? this.sending,
      error: error,
    );
  }
}

/// Holds the running conversation and talks to the Companion. Pure client state:
/// the server owns the real session (memory, pending action) — this mirrors it.
class CompanionController extends AutoDisposeNotifier<CompanionState> {
  @override
  CompanionState build() => const CompanionState();

  Future<void> send(String text, {Map<String, dynamic>? params}) async {
    final trimmed = text.trim();
    if (trimmed.isEmpty || state.sending) return;
    state = state.copyWith(
      messages: [...state.messages, CompanionMessage(role: 'user', text: trimmed)],
      sending: true,
      error: null,
    );
    await _run(() {
      final repo = ref.read(companionRepositoryProvider);
      final sessionId = state.sessionId;
      return sessionId == null
          ? repo.chat(trimmed, params: params)
          : repo.continueConversation(sessionId, trimmed, params: params);
    });
  }

  Future<void> confirm() async {
    final sessionId = state.sessionId;
    if (sessionId == null || state.sending) return;
    state = state.copyWith(sending: true, error: null);
    await _run(() => ref.read(companionRepositoryProvider).confirm(sessionId));
  }

  Future<void> cancel() async {
    final sessionId = state.sessionId;
    if (sessionId == null || state.sending) return;
    state = state.copyWith(sending: true, error: null);
    await _run(() => ref.read(companionRepositoryProvider).cancel(sessionId));
  }

  void reset() => state = const CompanionState();

  Future<void> _run(Future<ChatResponse> Function() call) async {
    try {
      final response = await call();
      state = state.copyWith(
        sessionId: response.sessionId,
        messages: [
          ...state.messages,
          CompanionMessage(role: 'assistant', text: response.message, response: response),
        ],
        sending: false,
      );
    } catch (error) {
      state = state.copyWith(sending: false, error: error.toString());
    }
  }
}

final companionControllerProvider =
    AutoDisposeNotifierProvider<CompanionController, CompanionState>(
  CompanionController.new,
);
