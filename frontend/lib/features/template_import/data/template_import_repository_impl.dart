import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http_parser/http_parser.dart';

import '../../../core/api/dio_client.dart';
import '../../branding/data/branding_models.dart';
import '../domain/template_import_repository.dart';
import 'template_import_models.dart';

/// Talks to `/document-analysis` (upload/process, reused as-is from
/// Étape 3) and `/template-import` (`app/template_import/router.py`,
/// Étape 8). No business logic here — matching, extraction and
/// persistence all live server-side.
class TemplateImportRepositoryImpl implements TemplateImportRepository {
  TemplateImportRepositoryImpl(this._dio);

  final Dio _dio;

  @override
  Future<DocumentAnalysisSummary> uploadQuotePdf({
    required String companyId,
    required String filename,
    required List<int> bytes,
  }) async {
    final formData = FormData.fromMap({
      'company_id': companyId,
      'document_type': 'quote',
      'file': MultipartFile.fromBytes(
        bytes,
        filename: filename,
        contentType: MediaType('application', 'pdf'),
      ),
    });
    final response = await _dio.post<Map<String, dynamic>>(
      '/document-analysis/upload',
      data: formData,
    );
    return DocumentAnalysisSummary.fromJson(response.data!);
  }

  @override
  Future<DocumentAnalysisSummary> processAnalysis(String analysisId) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/document-analysis/$analysisId/process',
    );
    return DocumentAnalysisSummary.fromJson(response.data!);
  }

  @override
  Future<TemplateImportPreview> getPreview(String analysisId) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/template-import/$analysisId/preview',
    );
    return TemplateImportPreview.fromJson(response.data!);
  }

  @override
  Future<BrandingProfile> validate(
    String analysisId,
    TemplateImportValidateInput input,
  ) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/template-import/$analysisId/validate',
      data: input.toJson(),
    );
    return BrandingProfile.fromJson(response.data!);
  }
}

final templateImportRepositoryProvider = Provider<TemplateImportRepository>((ref) {
  return TemplateImportRepositoryImpl(ref.watch(dioProvider));
});
