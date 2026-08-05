import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/workflow_model.dart';
import '../data/workflow_repository_impl.dart';
import 'workflow_providers.dart';

/// One workflow instance: current state, progression, append-only history
/// (timeline) and the available steps. Tapping a step validates the transition
/// (a human decision — Loi 7/18); the server refuses an invalid one (409).
class WorkflowDetailScreen extends ConsumerWidget {
  const WorkflowDetailScreen({required this.id, super.key});

  final String id;

  Future<void> _transition(BuildContext context, WidgetRef ref, String event) async {
    try {
      await ref.read(workflowRepositoryProvider).transition(id, event);
      ref.invalidate(workflowInstanceProvider(id));
      ref.invalidate(workflowInstancesProvider);
    } catch (error) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Transition refusée : $error')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(workflowInstanceProvider(id));
    return Scaffold(
      appBar: AppBar(title: const Text('Processus')),
      body: async.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Introuvable : $e')),
        data: (wf) => _Detail(
          wf: wf,
          onEvent: (event) => _transition(context, ref, event),
        ),
      ),
    );
  }
}

class _Detail extends StatelessWidget {
  const _Detail({required this.wf, required this.onEvent});

  final WorkflowInstance wf;
  final void Function(String event) onEvent;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(wf.definitionSlug, style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 8),
        Row(
          children: [
            Chip(label: Text('État : ${wf.currentState}')),
            const SizedBox(width: 8),
            Chip(label: Text(wf.status)),
          ],
        ),
        if (!wf.isTerminal && wf.availableEvents.isNotEmpty) ...[
          const SizedBox(height: 16),
          const Text('Étapes possibles', style: TextStyle(fontWeight: FontWeight.w700)),
          Wrap(
            spacing: 8,
            children: [
              for (final event in wf.availableEvents)
                FilledButton(onPressed: () => onEvent(event), child: Text(event)),
            ],
          ),
        ],
        const SizedBox(height: 16),
        const Text('Historique', style: TextStyle(fontWeight: FontWeight.w700)),
        for (final entry in wf.history)
          Card(
            child: ListTile(
              leading: const Icon(Icons.timeline),
              title: Text('${entry['event']}'),
              subtitle: Text(
                '${entry['from'] == '' ? '(début)' : entry['from']} → ${entry['to']}'
                '\n${entry['at']}',
              ),
              isThreeLine: true,
            ),
          ),
      ],
    );
  }
}
