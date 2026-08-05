import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'mission_providers.dart';

/// Lists the company's missions with their progression. A mission is created
/// from a client/workflow context (see the Mission Engine); this screen is the
/// field view of ongoing interventions.
class MissionScreen extends ConsumerWidget {
  const MissionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(missionsProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Missions')),
      body: RefreshIndicator(
        onRefresh: () => ref.read(missionsProvider.notifier).reload(),
        child: state.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('Erreur : $e')),
          data: (missions) => missions.isEmpty
              ? ListView(
                  children: const [
                    SizedBox(height: 120),
                    Center(child: Text('Aucune mission pour le moment.')),
                  ],
                )
              : ListView(
                  children: [
                    for (final m in missions)
                      Card(
                        child: ListTile(
                          title: Text(m.title),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('État : ${m.status}'),
                              const SizedBox(height: 4),
                              LinearProgressIndicator(value: m.progress / 100),
                            ],
                          ),
                          trailing: Text('${m.progress} %'),
                          onTap: () => context.push('/missions/${m.id}'),
                        ),
                      ),
                  ],
                ),
        ),
      ),
    );
  }
}
