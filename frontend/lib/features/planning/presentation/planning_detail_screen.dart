import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/planning_repository_impl.dart';
import 'planning_providers.dart';

/// One planning entry: its slot, assignment, status, actions (auto-assign,
/// cancel) and append-only history. The server enforces conflicts (409) and
/// refuses a hard delete (Loi 5).
class PlanningDetailScreen extends ConsumerWidget {
  const PlanningDetailScreen({required this.id, super.key});

  final String id;

  // Demo candidate artisans; a real list would come from the company's team.
  static const _candidates = ['alice', 'bob', 'claire'];

  Future<void> _run(BuildContext context, WidgetRef ref, Future<void> Function() action) async {
    try {
      await action();
      ref.invalidate(planningEntryProvider(id));
      ref.invalidate(planningProvider);
    } catch (error) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Action refusée : $error')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(planningEntryProvider(id));
    final repo = ref.read(planningRepositoryProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Créneau')),
      body: async.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Introuvable : $e')),
        data: (entry) => ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text('${entry.startAt} → ${entry.endAt}',
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: [
                Chip(label: Text(entry.status)),
                if (entry.artisan.isNotEmpty) Chip(label: Text('artisan: ${entry.artisan}')),
                if (entry.team.isNotEmpty) Chip(label: Text('équipe: ${entry.team}')),
                if (entry.vehicle.isNotEmpty) Chip(label: Text('véhicule: ${entry.vehicle}')),
              ],
            ),
            if (!entry.isTerminal) ...[
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                children: [
                  FilledButton.icon(
                    onPressed: () =>
                        _run(context, ref, () => repo.assignAuto(id, _candidates)),
                    icon: const Icon(Icons.person_search),
                    label: const Text('Affecter automatiquement'),
                  ),
                  OutlinedButton.icon(
                    onPressed: () => _run(context, ref, () => repo.cancel(id)),
                    icon: const Icon(Icons.cancel),
                    label: const Text('Annuler'),
                  ),
                ],
              ),
            ],
            const SizedBox(height: 16),
            const Text('Historique', style: TextStyle(fontWeight: FontWeight.w700)),
            for (final event in entry.history)
              Card(
                child: ListTile(
                  dense: true,
                  leading: const Icon(Icons.event_note),
                  title: Text('${event['event']}'),
                  subtitle: Text('${event['detail'] ?? ''}\n${event['at']}'),
                  isThreeLine: true,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
