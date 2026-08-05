import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'orchestration_providers.dart';

/// Lists the company's orchestrations (saga runs coordinating the engines).
class OrchestrationScreen extends ConsumerWidget {
  const OrchestrationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(orchestrationsProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Orchestrations')),
      body: RefreshIndicator(
        onRefresh: () => ref.read(orchestrationsProvider.notifier).reload(),
        child: state.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('Erreur : $e')),
          data: (items) => items.isEmpty
              ? ListView(
                  children: const [
                    SizedBox(height: 120),
                    Center(child: Text('Aucune orchestration.')),
                  ],
                )
              : ListView(
                  children: [
                    for (final o in items)
                      Card(
                        child: ListTile(
                          title: Text(o.planKind),
                          subtitle: Text('#${o.correlationId}'),
                          trailing: _StatusChip(status: o.status),
                          onTap: () => context.push('/orchestrations/${o.id}'),
                        ),
                      ),
                  ],
                ),
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
      'reussi' => Colors.green,
      'echec' => Colors.red,
      'partiellement_reussi' => Colors.orange,
      _ => Colors.blue,
    };
    return Chip(label: Text(status), backgroundColor: color.withValues(alpha: 0.15));
  }
}
