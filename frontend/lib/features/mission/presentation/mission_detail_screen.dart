import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/mission_model.dart';
import '../data/mission_repository_impl.dart';
import 'mission_providers.dart';

/// One mission: progression, lifecycle actions, attachments and the append-only
/// timeline. Status actions and notes are human decisions (Loi 7/18); the server
/// enforces valid transitions (409) and refuses a hard delete (Loi 5).
class MissionDetailScreen extends ConsumerStatefulWidget {
  const MissionDetailScreen({required this.id, super.key});

  final String id;

  @override
  ConsumerState<MissionDetailScreen> createState() => _MissionDetailScreenState();
}

class _MissionDetailScreenState extends ConsumerState<MissionDetailScreen> {
  final _note = TextEditingController();

  @override
  void dispose() {
    _note.dispose();
    super.dispose();
  }

  Future<void> _run(Future<void> Function() action) async {
    try {
      await action();
      ref.invalidate(missionProvider(widget.id));
      ref.invalidate(missionsProvider);
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Action refusée : $error')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(missionProvider(widget.id));
    return Scaffold(
      appBar: AppBar(title: const Text('Mission')),
      body: async.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Introuvable : $e')),
        data: (mission) => _Detail(
          mission: mission,
          noteController: _note,
          onStatus: (target) => _run(
            () => ref.read(missionRepositoryProvider).changeStatus(widget.id, target),
          ),
          onAddNote: () {
            final text = _note.text.trim();
            if (text.isEmpty) return;
            _note.clear();
            _run(
              () => ref
                  .read(missionRepositoryProvider)
                  .addAttachment(widget.id, kind: 'note', text: text),
            );
          },
        ),
      ),
    );
  }
}

const _statusTargets = ['ouverte', 'en_cours', 'cloturee', 'annulee'];

class _Detail extends StatelessWidget {
  const _Detail({
    required this.mission,
    required this.noteController,
    required this.onStatus,
    required this.onAddNote,
  });

  final Mission mission;
  final TextEditingController noteController;
  final void Function(String target) onStatus;
  final VoidCallback onAddNote;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(mission.title, style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 8),
        Row(
          children: [
            Chip(label: Text('État : ${mission.status}')),
            const Spacer(),
            Text('${mission.progress} %'),
          ],
        ),
        const SizedBox(height: 8),
        LinearProgressIndicator(value: mission.progress / 100),
        if (!mission.isTerminal) ...[
          const SizedBox(height: 16),
          const Text('Actions', style: TextStyle(fontWeight: FontWeight.w700)),
          Wrap(
            spacing: 8,
            children: [
              for (final target in _statusTargets)
                if (target != mission.status)
                  OutlinedButton(onPressed: () => onStatus(target), child: Text(target)),
            ],
          ),
        ],
        const SizedBox(height: 16),
        const Text('Ajouter une note', style: TextStyle(fontWeight: FontWeight.w700)),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: noteController,
                decoration: const InputDecoration(
                  hintText: 'Ex : client absent',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(width: 8),
            IconButton.filled(onPressed: onAddNote, icon: const Icon(Icons.add)),
          ],
        ),
        if (mission.attachments.isNotEmpty) ...[
          const SizedBox(height: 16),
          const Text('Pièces jointes', style: TextStyle(fontWeight: FontWeight.w700)),
          for (final a in mission.attachments)
            Card(
              child: ListTile(
                leading: const Icon(Icons.attach_file),
                title: Text('${a['kind']}'),
                subtitle: Text('${a['text'] ?? ''}${a['reference'] ?? ''}${a['label'] ?? ''}'),
              ),
            ),
        ],
        const SizedBox(height: 16),
        const Text('Historique', style: TextStyle(fontWeight: FontWeight.w700)),
        for (final entry in mission.timeline)
          Card(
            child: ListTile(
              leading: const Icon(Icons.timeline),
              title: Text('${entry['event']}'),
              subtitle: Text('${entry['detail'] ?? ''}\n${entry['at']}'),
              isThreeLine: true,
            ),
          ),
      ],
    );
  }
}
