import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../data/decision_model.dart';
import 'decision_providers.dart';
import 'widgets/explanation_view.dart';

/// The proposal screen: the artisan says what they want in plain words, the
/// Decision Engine proposes knowledge (sourced from the Knowledge Engine) with
/// its confidence and sources, and the artisan reviews. Nothing is saved — the
/// engine is read-side. Each proposal links to its Knowledge Card.
class DecisionScreen extends ConsumerStatefulWidget {
  const DecisionScreen({super.key});

  @override
  ConsumerState<DecisionScreen> createState() => _DecisionScreenState();
}

class _DecisionScreenState extends ConsumerState<DecisionScreen> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() {
    ref.read(decisionControllerProvider.notifier).propose(_controller.text);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(decisionControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Assistant décision')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Que voulez-vous faire ?',
                hintText: 'Ex : je remplace un chauffe-eau',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (_) => _submit(),
            ),
            const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: const Icon(Icons.auto_awesome),
              label: const Text('Préparer une proposition'),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: state.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, _) => Center(child: Text('Erreur : $error')),
                data: (result) => result == null
                    ? const Center(
                        child: Text('Décrivez votre intention pour commencer.'))
                    : _Result(result: result),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Result extends StatelessWidget {
  const _Result({required this.result});

  final DecisionResult result;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Text(result.proposal.comment,
            style: const TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        if (result.needsConfirmation)
          Card(
            color: Theme.of(context).colorScheme.secondaryContainer,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Quelques précisions',
                      style: TextStyle(fontWeight: FontWeight.w700)),
                  for (final q in result.questions)
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text('• $q'),
                    ),
                ],
              ),
            ),
          ),
        for (final element in result.proposal.elements)
          Card(
            child: ListTile(
              leading: const Icon(Icons.menu_book_outlined),
              title: Text(element.title),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(element.reason),
                  if (element.sources.isNotEmpty)
                    Text('Sources : ${element.sources.join(', ')}',
                        style: const TextStyle(fontStyle: FontStyle.italic)),
                ],
              ),
              isThreeLine: element.sources.isNotEmpty,
              trailing: element.confidence.isEmpty
                  ? const Icon(Icons.chevron_right)
                  : Chip(label: Text(element.confidence)),
              // Navigate to the source Knowledge Card (traceability).
              onTap: () =>
                  context.push('/knowledge/${element.type}/${element.slug}'),
            ),
          ),
        const SizedBox(height: 8),
        ExplanationView(explanation: result.explanation),
      ],
    );
  }
}
