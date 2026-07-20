import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/metiers_models.dart';
import '../data/metiers_repository_impl.dart';

/// Server state for "Mes métiers" — the activities on offer and their status.
/// No company id is bootstrapped here: the endpoint scopes to the JWT.
class ActivitiesNotifier extends AsyncNotifier<List<CatalogSource>> {
  @override
  Future<List<CatalogSource>> build() {
    return ref.watch(metiersRepositoryProvider).listActivities();
  }

  Future<void> refresh() async {
    // Keep the cards on screen during the refresh (no spinner flash).
    state = const AsyncValue<List<CatalogSource>>.loading().copyWithPrevious(state);
    state = await AsyncValue.guard(
      () => ref.read(metiersRepositoryProvider).listActivities(),
    );
  }

  /// Import or update, then refresh so the card flips to its new status.
  Future<CatalogImportResult> import(String slug) async {
    final result = await ref.read(metiersRepositoryProvider).importActivity(slug);
    await refresh();
    return result;
  }

  Future<void> remove(String slug) async {
    await ref.read(metiersRepositoryProvider).removeActivity(slug);
    await refresh();
  }
}

final activitiesNotifierProvider =
    AsyncNotifierProvider<ActivitiesNotifier, List<CatalogSource>>(ActivitiesNotifier.new);

/// Server state for "Mes qualifications" (PG, RGE…). Same shape, its own list.
class QualificationsNotifier extends AsyncNotifier<List<CatalogSource>> {
  @override
  Future<List<CatalogSource>> build() {
    return ref.watch(metiersRepositoryProvider).listQualifications();
  }

  Future<void> refresh() async {
    state = const AsyncValue<List<CatalogSource>>.loading().copyWithPrevious(state);
    state = await AsyncValue.guard(
      () => ref.read(metiersRepositoryProvider).listQualifications(),
    );
  }

  Future<CatalogImportResult> import(String slug) async {
    final result = await ref.read(metiersRepositoryProvider).importQualification(slug);
    await refresh();
    return result;
  }

  Future<void> remove(String slug) async {
    await ref.read(metiersRepositoryProvider).removeQualification(slug);
    await refresh();
  }
}

final qualificationsNotifierProvider =
    AsyncNotifierProvider<QualificationsNotifier, List<CatalogSource>>(
  QualificationsNotifier.new,
);
