import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../data/knowledge_model.dart';
import 'knowledge_providers.dart';

/// Search the knowledge corpus. Validated knowledge only by default; a toggle
/// includes drafts (the corpus is currently all-draft, so the default result is
/// legitimately empty — the screen says so instead of looking broken).
class KnowledgeSearchScreen extends ConsumerStatefulWidget {
  const KnowledgeSearchScreen({super.key});

  @override
  ConsumerState<KnowledgeSearchScreen> createState() => _KnowledgeSearchScreenState();
}

class _KnowledgeSearchScreenState extends ConsumerState<KnowledgeSearchScreen> {
  final _query = TextEditingController();
  final _metier = TextEditingController();
  bool _includeDrafts = false;

  @override
  void dispose() {
    _query.dispose();
    _metier.dispose();
    super.dispose();
  }

  void _search() {
    ref.read(knowledgeSearchProvider.notifier).search(
          _query.text,
          metier: _metier.text,
          includeDrafts: _includeDrafts,
        );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(knowledgeSearchProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Base de savoir')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _query,
              decoration: const InputDecoration(
                labelText: 'Rechercher',
                hintText: 'Ex : mitigeur, fuite, chauffe-eau',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (_) => _search(),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _metier,
              decoration: const InputDecoration(
                labelText: 'Métier (filtre)',
                hintText: 'Ex : plomberie',
                border: OutlineInputBorder(),
              ),
            ),
            SwitchListTile(
              value: _includeDrafts,
              onChanged: (v) => setState(() => _includeDrafts = v),
              title: const Text('Inclure les brouillons'),
              contentPadding: EdgeInsets.zero,
            ),
            FilledButton.icon(
              onPressed: _search,
              icon: const Icon(Icons.search),
              label: const Text('Rechercher'),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: state.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, _) => Center(child: Text('Erreur : $e')),
                data: (result) => _Results(result: result, includeDrafts: _includeDrafts),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Results extends StatelessWidget {
  const _Results({required this.result, required this.includeDrafts});

  final KnowledgeSearchResult? result;
  final bool includeDrafts;

  @override
  Widget build(BuildContext context) {
    if (result == null) {
      return const Center(child: Text('Lancez une recherche.'));
    }
    if (result!.matches.isEmpty) {
      return Center(
        child: Text(
          includeDrafts
              ? 'Aucun résultat.'
              : 'Aucune connaissance validée pour cette recherche.\n'
                  'Activez « Inclure les brouillons » pour voir le corpus en cours.',
          textAlign: TextAlign.center,
        ),
      );
    }
    return ListView(
      children: [
        for (final match in result!.matches)
          Card(
            child: ListTile(
              title: Text(match.item.title),
              subtitle: Text(match.why),
              trailing: Text(
                '${match.item.status}'
                '${match.item.confidence.isNotEmpty ? ' · ${match.item.confidence}' : ''}',
              ),
              onTap: () => context.push('/knowledge/${match.item.type}/${match.item.slug}'),
            ),
          ),
      ],
    );
  }
}
