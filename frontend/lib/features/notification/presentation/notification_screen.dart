import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'notification_providers.dart';

IconData _channelIcon(String channel) => switch (channel) {
      'email' => Icons.email_outlined,
      'sms' => Icons.sms_outlined,
      'push' => Icons.notifications_outlined,
      _ => Icons.send_outlined,
    };

Color _statusColor(String status, ColorScheme scheme) => switch (status) {
      'sent' => scheme.primary,
      'failed' => scheme.error,
      _ => scheme.outline,
    };

/// The notification history — one row per notification with its channel,
/// recipient and delivery status. Ordered newest-first server-side.
class NotificationScreen extends ConsumerWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(notificationsProvider);
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: const Text('Notifications')),
      body: RefreshIndicator(
        onRefresh: () => ref.read(notificationsProvider.notifier).reload(),
        child: state.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('Erreur : $e')),
          data: (notifications) => notifications.isEmpty
              ? ListView(
                  children: const [
                    SizedBox(height: 120),
                    Center(child: Text('Aucune notification envoyée.')),
                  ],
                )
              : ListView.builder(
                  itemCount: notifications.length,
                  itemBuilder: (context, index) {
                    final n = notifications[index];
                    return Card(
                      child: ListTile(
                        leading: Icon(_channelIcon(n.channel)),
                        title: Text(n.subject.isEmpty ? n.recipient : n.subject),
                        subtitle: Text('${n.recipient} · ${n.channel}'),
                        trailing: Text(
                          n.status,
                          style: TextStyle(color: _statusColor(n.status, scheme)),
                        ),
                        onTap: () => context.push('/notifications/${n.id}'),
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}
