import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/companion_model.dart';
import 'companion_providers.dart';

/// Artisan-facing label for the capability that handled the turn. The brand
/// forbids engineering words ("moteur", raw engine slugs) on screen (BRAND.md,
/// "deux langues"), so provenance is shown in the artisan's own vocabulary.
String _capabilityLabel(String engine) => switch (engine) {
      'knowledge' => 'savoir-faire',
      'decision' => 'analyse',
      'orchestration' => 'organisation',
      'planning' => 'planning',
      'notification' => 'message',
      'quotes' => 'devis',
      _ => 'assistant',
    };

/// The conversational interface of Artizen. The artisan talks naturally; each
/// reply shows what the Companion understood, on which knowledge and engine, its
/// confidence, and — for any business action — a proposal to validate. Nothing
/// with an impact happens without an explicit confirmation.
class CompanionScreen extends ConsumerStatefulWidget {
  const CompanionScreen({super.key});

  @override
  ConsumerState<CompanionScreen> createState() => _CompanionScreenState();
}

class _CompanionScreenState extends ConsumerState<CompanionScreen> {
  final _input = TextEditingController();

  @override
  void dispose() {
    _input.dispose();
    super.dispose();
  }

  void _send() {
    final text = _input.text;
    if (text.trim().isEmpty) return;
    _input.clear();
    ref.read(companionControllerProvider.notifier).send(text);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(companionControllerProvider);
    ref.listen(companionControllerProvider.select((s) => s.error), (_, error) {
      if (error != null && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erreur : $error')));
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Assistant Artizen'),
        actions: [
          IconButton(
            tooltip: 'Nouvelle conversation',
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.read(companionControllerProvider.notifier).reset(),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: state.messages.isEmpty
                ? const _EmptyHint()
                : ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: state.messages.length,
                    itemBuilder: (context, index) {
                      final message = state.messages[index];
                      final isLast = index == state.messages.length - 1;
                      return _MessageBubble(message: message, actionable: isLast);
                    },
                  ),
          ),
          if (state.sending) const LinearProgressIndicator(minHeight: 2),
          _Composer(controller: _input, enabled: !state.sending, onSend: _send),
        ],
      ),
    );
  }
}

class _EmptyHint extends StatelessWidget {
  const _EmptyHint();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Text(
          'Dites-moi ce que vous voulez faire.\n'
          'Ex. « Comment purger un radiateur ? », « planifie une intervention », '
          '« prépare un devis ».',
          textAlign: TextAlign.center,
          style: TextStyle(color: Theme.of(context).colorScheme.outline),
        ),
      ),
    );
  }
}

class _MessageBubble extends ConsumerWidget {
  const _MessageBubble({required this.message, required this.actionable});

  final CompanionMessage message;
  final bool actionable;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;
    final align = message.isUser ? Alignment.centerRight : Alignment.centerLeft;
    final color = message.isUser ? scheme.primaryContainer : scheme.surfaceContainerHighest;
    final response = message.response;

    return Align(
      alignment: align,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.all(12),
        constraints: const BoxConstraints(maxWidth: 560),
        decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(message.text),
            if (response != null) ..._assistantExtras(context, ref, response),
          ],
        ),
      ),
    );
  }

  List<Widget> _assistantExtras(BuildContext context, WidgetRef ref, ChatResponse response) {
    final widgets = <Widget>[];

    // Explainability: engine + confidence + knowledge sources.
    widgets.add(const SizedBox(height: 8));
    widgets.add(
      Wrap(
        spacing: 6,
        runSpacing: 4,
        children: [
          Chip(
            visualDensity: VisualDensity.compact,
            avatar: const Icon(Icons.hub_outlined, size: 16),
            label: Text(_capabilityLabel(response.explanation.engine)),
          ),
          if (response.explanation.confidence > 0)
            Chip(
              visualDensity: VisualDensity.compact,
              label: Text('confiance ${(response.explanation.confidence * 100).round()} %'),
            ),
          for (final source in response.sources.take(4))
            Chip(
              visualDensity: VisualDensity.compact,
              avatar: const Icon(Icons.menu_book_outlined, size: 16),
              label: Text(source.title.isEmpty ? source.ref : source.title),
            ),
        ],
      ),
    );

    // Clarification questions.
    for (final question in response.questions) {
      widgets.add(Padding(
        padding: const EdgeInsets.only(top: 4),
        child: Text('• $question', style: Theme.of(context).textTheme.bodySmall),
      ));
    }

    // A proposed business action awaiting explicit validation.
    if (actionable && response.needsConfirmation && response.proposedAction != null) {
      widgets.add(_ConfirmBar(action: response.proposedAction!));
    }
    return widgets;
  }
}

class _ConfirmBar extends ConsumerWidget {
  const _ConfirmBar({required this.action});

  final ProposedAction action;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(companionControllerProvider.notifier);
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Wrap(
        spacing: 8,
        children: [
          FilledButton.icon(
            onPressed: () => notifier.confirm(),
            icon: const Icon(Icons.check),
            label: const Text('Valider'),
          ),
          OutlinedButton.icon(
            onPressed: () => notifier.cancel(),
            icon: const Icon(Icons.close),
            label: const Text('Annuler'),
          ),
        ],
      ),
    );
  }
}

class _Composer extends StatelessWidget {
  const _Composer({required this.controller, required this.enabled, required this.onSend});

  final TextEditingController controller;
  final bool enabled;
  final VoidCallback onSend;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                enabled: enabled,
                minLines: 1,
                maxLines: 4,
                textInputAction: TextInputAction.send,
                onSubmitted: (_) => onSend(),
                decoration: const InputDecoration(
                  hintText: 'Écrivez votre demande…',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(width: 8),
            IconButton.filled(
              onPressed: enabled ? onSend : null,
              icon: const Icon(Icons.send),
            ),
          ],
        ),
      ),
    );
  }
}
