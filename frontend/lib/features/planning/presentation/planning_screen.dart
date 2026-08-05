import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../data/planning_model.dart';
import 'planning_providers.dart';

String _hm(DateTime dt) =>
    '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';

String _dayKey(DateTime dt) => '${dt.year}-${dt.month.toString().padLeft(2, '0')}-'
    '${dt.day.toString().padLeft(2, '0')}';

/// The schedule, grouped by day (a simple calendar/agenda view). Entries are
/// ordered by start time server-side.
class PlanningScreen extends ConsumerWidget {
  const PlanningScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(planningProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Planning')),
      body: RefreshIndicator(
        onRefresh: () => ref.read(planningProvider.notifier).reload(),
        child: state.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('Erreur : $e')),
          data: (entries) => entries.isEmpty
              ? ListView(
                  children: const [
                    SizedBox(height: 120),
                    Center(child: Text('Aucun créneau planifié.')),
                  ],
                )
              : ListView(children: _buildDays(context, entries)),
        ),
      ),
    );
  }

  List<Widget> _buildDays(BuildContext context, List<PlanningEntry> entries) {
    final widgets = <Widget>[];
    String? currentDay;
    for (final entry in entries) {
      final day = _dayKey(entry.startAt);
      if (day != currentDay) {
        currentDay = day;
        widgets.add(
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
            child: Text(day, style: const TextStyle(fontWeight: FontWeight.w700)),
          ),
        );
      }
      widgets.add(
        Card(
          child: ListTile(
            leading: Text('${_hm(entry.startAt)}\n${_hm(entry.endAt)}',
                textAlign: TextAlign.center),
            title: Text(entry.artisan.isEmpty ? '(non affecté)' : entry.artisan),
            subtitle: Text('${entry.durationMinutes} min · ${entry.status}'),
            onTap: () => context.push('/planning/${entry.id}'),
          ),
        ),
      );
    }
    return widgets;
  }
}
