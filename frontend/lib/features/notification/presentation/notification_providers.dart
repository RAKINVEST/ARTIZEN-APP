import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/notification_model.dart';
import '../data/notification_repository_impl.dart';

/// Server state for the notification history.
class NotificationController
    extends AutoDisposeAsyncNotifier<List<AppNotification>> {
  @override
  Future<List<AppNotification>> build() =>
      ref.read(notificationRepositoryProvider).list();

  Future<void> reload() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(notificationRepositoryProvider).list(),
    );
  }
}

final notificationsProvider = AutoDisposeAsyncNotifierProvider<
    NotificationController, List<AppNotification>>(
  NotificationController.new,
);

final notificationProvider =
    FutureProvider.autoDispose.family<AppNotification, String>(
  (ref, id) => ref.read(notificationRepositoryProvider).get(id),
);
