import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http_parser/http_parser.dart';

import '../../../core/api/api_exception.dart';
import '../../../core/api/dio_client.dart';
import '../domain/branding_repository.dart';
import 'branding_models.dart';

/// Talks to `/branding/profile`, `/branding/company` and `/branding/brand`
/// (`app/branding/router.py`). No business logic here — this module never
/// decides *what* the company's identity should be, only reads/writes it.
class BrandingRepositoryImpl implements BrandingRepository {
  BrandingRepositoryImpl(this._dio);

  final Dio _dio;

  @override
  Future<BrandingProfile> getProfile() async {
    final response = await _dio.get<Map<String, dynamic>>('/branding/profile');
    return BrandingProfile.fromJson(response.data!);
  }

  @override
  Future<Company> updateCompany(CompanyUpdateInput input) async {
    final response = await _dio.put<Map<String, dynamic>>(
      '/branding/company',
      data: input.toJson(),
    );
    return Company.fromJson(response.data!);
  }

  @override
  Future<BrandProfile> updateBrandProfile(BrandProfileUpdateInput input) async {
    final response = await _dio.put<Map<String, dynamic>>(
      '/branding/brand',
      data: input.toJson(),
    );
    return BrandProfile.fromJson(response.data!);
  }

  @override
  Future<String> uploadLogo({required String filename, required List<int> bytes}) =>
      _uploadAsset('/branding/logo', filename: filename, bytes: bytes);

  @override
  Future<void> deleteLogo() async {
    await _dio.delete<void>('/branding/logo');
  }

  @override
  Future<String> uploadSignature({required String filename, required List<int> bytes}) =>
      _uploadAsset('/branding/signature', filename: filename, bytes: bytes);

  @override
  Future<void> deleteSignature() async {
    await _dio.delete<void>('/branding/signature');
  }

  @override
  Future<String> uploadStamp({required String filename, required List<int> bytes}) =>
      _uploadAsset('/branding/stamp', filename: filename, bytes: bytes);

  @override
  Future<void> deleteStamp() async {
    await _dio.delete<void>('/branding/stamp');
  }

  @override
  Future<Uint8List?> fetchAsset(BrandAssetKind kind) async {
    try {
      // responseType: bytes — the endpoint streams raw image bytes, not JSON.
      final response = await _dio.get<List<int>>(
        '/branding/asset/${kind.name}',
        options: Options(responseType: ResponseType.bytes),
      );
      final data = response.data;
      if (data == null || data.isEmpty) return null;
      return Uint8List.fromList(data);
    } on DioException catch (error) {
      // A missing asset is a normal state (nothing imported yet), not a
      // failure the UI should surface — map the 404 to `null`.
      final mapped = error.error;
      if (mapped is ApiServerException && mapped.statusCode == 404) return null;
      rethrow;
    }
  }

  /// Same multipart shape the logo/template upload uses: a single `file`
  /// part with an image content type inferred from the filename extension.
  Future<String> _uploadAsset(
    String path, {
    required String filename,
    required List<int> bytes,
  }) async {
    final formData = FormData.fromMap({
      'file': MultipartFile.fromBytes(
        bytes,
        filename: filename,
        contentType: _imageMediaType(filename),
      ),
    });
    final response = await _dio.post<Map<String, dynamic>>(path, data: formData);
    return response.data!['path'] as String;
  }

  /// Maps a filename extension to the image media type the backend accepts.
  /// Defaults to JPEG for anything that isn't clearly a PNG.
  MediaType _imageMediaType(String filename) {
    final lower = filename.toLowerCase();
    if (lower.endsWith('.png')) return MediaType('image', 'png');
    return MediaType('image', 'jpeg');
  }
}

final brandingRepositoryProvider = Provider<BrandingRepository>((ref) {
  return BrandingRepositoryImpl(ref.watch(dioProvider));
});
