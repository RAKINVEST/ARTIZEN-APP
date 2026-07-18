import 'dart:typed_data';

import 'package:artizen/features/branding/data/branding_models.dart';
import 'package:artizen/features/branding/data/branding_repository_impl.dart';
import 'package:artizen/features/branding/domain/branding_repository.dart';
import 'package:artizen/features/branding/presentation/branding_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

BrandingProfile _profile({String? signaturePath, String? stampPath}) => BrandingProfile(
      company: const Company(id: 'co1'),
      brand: BrandProfile(id: 'b1', signaturePath: signaturePath, stampPath: stampPath),
      templates: const [],
    );

/// Records what the notifier asks of the repository and lets each call return
/// a canned value, so we can assert how the notifier patches its cache.
class _RecordingBrandingRepository implements BrandingRepository {
  _RecordingBrandingRepository(this.profile);

  BrandingProfile profile;

  @override
  Future<BrandingProfile> getProfile() async => profile;

  @override
  Future<String> uploadSignature({required String filename, required List<int> bytes}) async =>
      'brand/signature/new.png';

  @override
  Future<void> deleteSignature() async {}

  @override
  Future<String> uploadStamp({required String filename, required List<int> bytes}) async =>
      'brand/stamp/new.png';

  @override
  Future<void> deleteStamp() async {}

  @override
  Future<Uint8List?> fetchAsset(BrandAssetKind kind) async => null;

  @override
  Future<Company> updateCompany(CompanyUpdateInput input) async => throw UnimplementedError();

  @override
  Future<BrandProfile> updateBrandProfile(BrandProfileUpdateInput input) async =>
      throw UnimplementedError();
}

void main() {
  ProviderContainer containerFor(BrandingProfile initial) {
    final container = ProviderContainer(
      overrides: [
        brandingRepositoryProvider.overrideWithValue(_RecordingBrandingRepository(initial)),
      ],
    );
    addTearDown(container.dispose);
    return container;
  }

  test('uploadSignature reflects the new signaturePath in the cached brand', () async {
    final container = containerFor(_profile());
    await container.read(brandingProfileNotifierProvider.future);

    await container
        .read(brandingProfileNotifierProvider.notifier)
        .uploadSignature(filename: 'sign.png', bytes: [1, 2, 3]);

    final brand = container.read(brandingProfileNotifierProvider).value!.brand;
    expect(brand.signaturePath, 'brand/signature/new.png');
    // The stamp must stay untouched by a signature upload.
    expect(brand.stampPath, isNull);
  });

  test('deleteStamp clears stampPath while leaving the signature intact', () async {
    final container = containerFor(_profile(signaturePath: 'keep/sig.png', stampPath: 'old/stamp.png'));
    await container.read(brandingProfileNotifierProvider.future);

    await container.read(brandingProfileNotifierProvider.notifier).deleteStamp();

    final brand = container.read(brandingProfileNotifierProvider).value!.brand;
    expect(brand.stampPath, isNull);
    expect(brand.signaturePath, 'keep/sig.png');
  });
}
