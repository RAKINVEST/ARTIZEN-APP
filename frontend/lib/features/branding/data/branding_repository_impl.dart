import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
}

final brandingRepositoryProvider = Provider<BrandingRepository>((ref) {
  return BrandingRepositoryImpl(ref.watch(dioProvider));
});
