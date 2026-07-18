import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/branding_models.dart';
import '../data/branding_repository_impl.dart';

/// Holds the full company/brand/templates profile — separate from the
/// lightweight `currentCompanyIdProvider` (`shared/providers/`), which
/// every feature bootstraps from for just the `company_id`. This one is
/// only watched by screens that actually show/edit the company's
/// identity (Paramètres, template import), so most screens never pay
/// for the extra fields.
class BrandingProfileNotifier extends AsyncNotifier<BrandingProfile> {
  @override
  Future<BrandingProfile> build() => ref.watch(brandingRepositoryProvider).getProfile();

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => ref.read(brandingRepositoryProvider).getProfile());
  }

  /// Persists a partial company update (`PUT /branding/company`) and patches
  /// the cached aggregate in place with the returned `CompanyRead`. It stays
  /// out of the loading state on purpose: the edit form drives its own submit
  /// spinner, and flipping the whole profile to `loading` here would blank the
  /// screen that is showing the form. Falls back to a full refetch only if the
  /// aggregate isn't loaded yet (nothing to patch).
  Future<Company> updateCompany(CompanyUpdateInput input) async {
    final updated = await ref.read(brandingRepositoryProvider).updateCompany(input);
    final current = state.valueOrNull;
    if (current != null) {
      state = AsyncValue.data(current.copyWith(company: updated));
    } else {
      await refresh();
    }
    return updated;
  }
}

final brandingProfileNotifierProvider =
    AsyncNotifierProvider<BrandingProfileNotifier, BrandingProfile>(BrandingProfileNotifier.new);
