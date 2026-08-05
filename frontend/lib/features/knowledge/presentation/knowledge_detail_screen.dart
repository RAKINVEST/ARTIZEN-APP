import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../data/knowledge_model.dart';
import 'knowledge_providers.dart';

/// One knowledge item and its resolved relations. Read-only.
class KnowledgeDetailScreen extends ConsumerWidget {
  const KnowledgeDetailScreen({required this.type, required this.slug, super.key});

  final String type;
  final String slug;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(knowledgeDetailProvider((type: type, slug: slug)));
    return Scaffold(
      appBar: AppBar(title: const Text('Fiche savoir')),
      body: async.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Introuvable : $e')),
        data: (detail) => _Detail(detail: detail),
      ),
    );
  }
}

class _Detail extends StatelessWidget {
  const _Detail({required this.detail});

  final KnowledgeDetail detail;

  @override
  Widget build(BuildContext context) {
    final item = detail.item;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(item.title, style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 8),
        Wrap(
          spacing: 6,
          children: [
            Chip(label: Text(item.type)),
            Chip(label: Text(item.status)),
            if (item.confidence.isNotEmpty) Chip(label: Text('confiance ${item.confidence}')),
            if (item.profession.isNotEmpty) Chip(label: Text(item.profession)),
          ],
        ),
        if (item.summary.isNotEmpty) ...[
          const SizedBox(height: 12),
          Text(item.summary),
        ],
        if (item.tags.isNotEmpty) ...[
          const SizedBox(height: 12),
          const Text('Tags', style: TextStyle(fontWeight: FontWeight.w700)),
          Wrap(spacing: 6, children: [for (final t in item.tags) Chip(label: Text(t))]),
        ],
        if (item.sources.isNotEmpty) ...[
          const SizedBox(height: 12),
          const Text('Sources', style: TextStyle(fontWeight: FontWeight.w700)),
          for (final s in item.sources) Text('• $s'),
        ],
        if (detail.related.isNotEmpty) ...[
          const SizedBox(height: 12),
          const Text('Relations', style: TextStyle(fontWeight: FontWeight.w700)),
          for (final rel in detail.related)
            Card(
              child: ListTile(
                title: Text(rel.title),
                subtitle: Text(rel.type),
                onTap: () => context.push('/knowledge/${rel.type}/${rel.slug}'),
              ),
            ),
        ],
      ],
    );
  }
}
