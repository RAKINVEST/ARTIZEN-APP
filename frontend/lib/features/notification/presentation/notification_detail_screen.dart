import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/notification_repository_impl.dart';
import 'notification_providers.dart';

/// One notification: its channel, recipient, rendered content, delivery status,
/// a resend action, and its append-only history. A failed send is shown as
/// such — never hidden — and can be retried.
class NotificationDetailScreen extends ConsumerWidget {
  const NotificationDetailScreen({required this.id, super.key});

  final String id;

  Future<void> _resend(BuildContext context, WidgetRef ref) async {
    try {
      await ref.read(notificationRepositoryProvider).resend(id);
      ref.invalidate(notificationProvider(id));
      ref.invalidate(notificationsProvider);
    } catch (error) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Renvoi refusé : $error')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(notificationProvider(id));
    return Scaffold(
      appBar: AppBar(title: const Text('Notification')),
      body: async.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Introuvable : $e')),
        data: (n) => ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text(
              n.subject.isEmpty ? '(sans objet)' : n.subject,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: [
                Chip(label: Text(n.channel)),
                Chip(label: Text(n.status)),
                if (n.templateKey.isNotEmpty)
                  Chip(label: Text('modèle: ${n.templateKey}')),
              ],
            ),
            const SizedBox(height: 8),
            Text('À : ${n.recipient}'),
            if (n.body.isNotEmpty) ...[
              const SizedBox(height: 12),
              Text(n.body),
            ],
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: () => _resend(context, ref),
              icon: const Icon(Icons.refresh),
              label: const Text('Renvoyer'),
            ),
            const SizedBox(height: 16),
            const Text('Historique', style: TextStyle(fontWeight: FontWeight.w700)),
            for (final event in n.history)
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
