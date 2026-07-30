import 'dart:typed_data';

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

  /// Imports a logo image and reflects the new `logoPath` in the cached brand,
  /// then drops the cached preview bytes so the aperçu refetches.
  Future<void> uploadLogo({required String filename, required List<int> bytes}) async {
    final path =
        await ref.read(brandingRepositoryProvider).uploadLogo(filename: filename, bytes: bytes);
    _setBrandPaths(logoPath: path);
    ref.invalidate(brandAssetProvider(BrandAssetKind.logo));
  }

  Future<void> deleteLogo() async {
    await ref.read(brandingRepositoryProvider).deleteLogo();
    _setBrandPaths(clearLogo: true);
    ref.invalidate(brandAssetProvider(BrandAssetKind.logo));
  }

  /// Imports a signature image and reflects the new `signaturePath` in the
  /// cached brand, then drops the cached preview bytes so the aperçu refetches.
  Future<void> uploadSignature({required String filename, required List<int> bytes}) async {
    final path = await ref
        .read(brandingRepositoryProvider)
        .uploadSignature(filename: filename, bytes: bytes);
    _setBrandPaths(signaturePath: path);
    ref.invalidate(brandAssetProvider(BrandAssetKind.signature));
  }

  Future<void> deleteSignature() async {
    await ref.read(brandingRepositoryProvider).deleteSignature();
    _setBrandPaths(clearSignature: true);
    ref.invalidate(brandAssetProvider(BrandAssetKind.signature));
  }

  Future<void> uploadStamp({required String filename, required List<int> bytes}) async {
    final path =
        await ref.read(brandingRepositoryProvider).uploadStamp(filename: filename, bytes: bytes);
    _setBrandPaths(stampPath: path);
    ref.invalidate(brandAssetProvider(BrandAssetKind.stamp));
  }

  Future<void> deleteStamp() async {
    await ref.read(brandingRepositoryProvider).deleteStamp();
    _setBrandPaths(clearStamp: true);
    ref.invalidate(brandAssetProvider(BrandAssetKind.stamp));
  }

  /// Patches `brand.logoPath` / `brand.signaturePath` / `brand.stampPath` in the
  /// cached aggregate without a round-trip. The `clear*` flags exist because
  /// `copyWith` cannot tell "leave unchanged" from "set to null" through a
  /// single optional arg.
  void _setBrandPaths({
    String? logoPath,
    String? signaturePath,
    String? stampPath,
    bool clearLogo = false,
    bool clearSignature = false,
    bool clearStamp = false,
  }) {
    final current = state.valueOrNull;
    if (current == null) return;
    final brand = current.brand;
    state = AsyncValue.data(
      current.copyWith(
        brand: brand.copyWith(
          logoPath: clearLogo ? null : (logoPath ?? brand.logoPath),
          signaturePath: clearSignature ? null : (signaturePath ?? brand.signaturePath),
          stampPath: clearStamp ? null : (stampPath ?? brand.stampPath),
        ),
      ),
    );
  }
}

final brandingProfileNotifierProvider =
    AsyncNotifierProvider<BrandingProfileNotifier, BrandingProfile>(BrandingProfileNotifier.new);

/// Raw image bytes for a brand asset (logo/signature/stamp), fetched with the
/// auth header through Dio so `Image.memory` can render it. `autoDispose` and
/// keyed by kind: each preview re-fetches when its section is reopened, and
/// the notifier invalidates the relevant kind after a replace/delete so the
/// aperçu never shows a stale image. `null` means "no asset stored".
final brandAssetProvider = FutureProvider.autoDispose.family<Uint8List?, BrandAssetKind>(
  (ref, kind) => ref.watch(brandingRepositoryProvider).fetchAsset(kind),
);
