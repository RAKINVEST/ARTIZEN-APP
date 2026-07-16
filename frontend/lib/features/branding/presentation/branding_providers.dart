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
}

final brandingProfileNotifierProvider =
    AsyncNotifierProvider<BrandingProfileNotifier, BrandingProfile>(BrandingProfileNotifier.new);
