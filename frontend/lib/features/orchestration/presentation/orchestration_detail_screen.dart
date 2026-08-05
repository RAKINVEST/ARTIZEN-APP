import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/orchestration_model.dart';
import '../data/orchestration_repository_impl.dart';
import 'orchestration_providers.dart';

/// One orchestration: plan, saga timeline (steps, retries, compensations),
/// results, status. A failed one can be retried (re-runs the plan).
class OrchestrationDetailScreen extends ConsumerWidget {
  const OrchestrationDetailScreen({required this.id, super.key});

  final String id;

  Future<void> _retry(BuildContext context, WidgetRef ref) async {
    try {
      await ref.read(orchestrationRepositoryProvider).retry(id);
      ref.invalidate(orchestrationProvider(id));
      ref.invalidate(orchestrationsProvider);
    } catch (error) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Retry refusé : $error')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(orchestrationProvider(id));
    return Scaffold(
      appBar: AppBar(title: const Text('Orchestration')),
      body: async.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Introuvable : $e')),
        data: (o) => _Detail(o: o, onRetry: () => _retry(context, ref)),
      ),
    );
  }
}

class _Detail extends StatelessWidget {
  const _Detail({required this.o, required this.onRetry});

  final OrchestrationInstance o;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(o.planKind, style: Theme.of(context).textTheme.titleLarge),
        Text('#${o.correlationId}'),
        const SizedBox(height: 8),
        Row(
          children: [
            Chip(label: Text('Statut : ${o.status}')),
            const Spacer(),
            if (o.isTerminal)
              OutlinedButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.replay),
                label: const Text('Rejouer'),
              ),
          ],
        ),
        const SizedBox(height: 16),
        const Text('Plan', style: TextStyle(fontWeight: FontWeight.w700)),
        for (final step in o.plan)
          ListTile(
            dense: true,
            leading: const Icon(Icons.linear_scale),
            title: Text('${step['id']}'),
            subtitle: Text('${step['engine']} · ${step['action']}'),
          ),
        if (o.results.isNotEmpty) ...[
          const SizedBox(height: 8),
          const Text('Résultats', style: TextStyle(fontWeight: FontWeight.w700)),
          Text(o.results.toString()),
        ],
        const SizedBox(height: 16),
        const Text('Journal (saga)', style: TextStyle(fontWeight: FontWeight.w700)),
        for (final event in o.timeline)
          Card(
            child: ListTile(
              dense: true,
              leading: const Icon(Icons.bolt),
              title: Text('${event['type']}'
                  '${event['step'] != null && '${event['step']}'.isNotEmpty ? ' · ${event['step']}' : ''}'),
              subtitle: Text(
                '${event['detail'] ?? ''}'
                '${event['attempt'] != null ? ' (essai ${event['attempt']})' : ''}'
                '\n${event['at']}',
              ),
              isThreeLine: true,
            ),
          ),
      ],
    );
  }
}
