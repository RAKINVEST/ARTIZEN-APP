import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'workflow_providers.dart';

/// Lists the company's workflow instances and lets the artisan start one.
/// A validated decision would start a workflow the same way (same endpoint).
class WorkflowScreen extends ConsumerWidget {
  const WorkflowScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(workflowInstancesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Processus')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final created = await ref.read(workflowInstancesProvider.notifier).start(
            'intervention',
            {'intent': 'Nouvelle intervention'},
          );
          if (context.mounted) context.push('/workflow/${created.id}');
        },
        icon: const Icon(Icons.add),
        label: const Text('Intervention'),
      ),
      body: state.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Erreur : $e')),
        data: (instances) => instances.isEmpty
            ? const Center(child: Text('Aucun processus. Démarrez une intervention avec « + ».'))
            : ListView(
                children: [
                  for (final wf in instances)
                    Card(
                      child: ListTile(
                        title: Text(wf.definitionSlug),
                        subtitle: Text('État : ${wf.currentState}'),
                        trailing: _StatusChip(status: wf.status),
                        onTap: () => context.push('/workflow/${wf.id}'),
                      ),
                    ),
                ],
              ),
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.status});

  final String status;

  @override
  Widget build(BuildContext context) {
    final color = switch (status) {
      'completed' => Colors.green,
      'cancelled' => Colors.red,
      _ => Colors.blue,
    };
    return Chip(
      label: Text(status),
      backgroundColor: color.withValues(alpha: 0.15),
    );
  }
}
