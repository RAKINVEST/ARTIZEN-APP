import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/api_exception.dart';
import '../../../shared/providers/current_company_provider.dart';
import '../../branding/presentation/branding_providers.dart';
import '../data/template_import_models.dart';
import '../data/template_import_repository_impl.dart';

/// The "importer un ancien devis PDF" pipeline, one state per step:
/// idle -> uploading -> analyzing -> preview -> validating -> done, with
/// `error` reachable from any step. Kept as a single state machine
/// (rather than several independent providers) because the steps are
/// strictly sequential and only one is ever meaningful at a time.
sealed class TemplateImportState {
  const TemplateImportState();
}

class TemplateImportIdle extends TemplateImportState {
  const TemplateImportIdle();
}

class TemplateImportUploading extends TemplateImportState {
  const TemplateImportUploading();
}

class TemplateImportAnalyzing extends TemplateImportState {
  const TemplateImportAnalyzing();
}

class TemplateImportPreviewReady extends TemplateImportState {
  const TemplateImportPreviewReady(this.preview);
  final TemplateImportPreview preview;
}

class TemplateImportValidating extends TemplateImportState {
  const TemplateImportValidating(this.preview);
  final TemplateImportPreview preview;
}

class TemplateImportDone extends TemplateImportState {
  const TemplateImportDone();
}

class TemplateImportFailed extends TemplateImportState {
  const TemplateImportFailed(this.message, {this.preview});
  final String message;
  final TemplateImportPreview? preview;
}

class TemplateImportNotifier extends Notifier<TemplateImportState> {
  @override
  TemplateImportState build() => const TemplateImportIdle();

  Future<void> importFile({required String filename, required List<int> bytes}) async {
    state = const TemplateImportUploading();
    try {
      final companyId = await ref.read(currentCompanyIdProvider.future);
      final repository = ref.read(templateImportRepositoryProvider);

      final uploaded = await repository.uploadQuotePdf(
        companyId: companyId,
        filename: filename,
        bytes: bytes,
      );

      state = const TemplateImportAnalyzing();
      await repository.processAnalysis(uploaded.id);
      final preview = await repository.getPreview(uploaded.id);

      state = TemplateImportPreviewReady(preview);
    } catch (error) {
      state = TemplateImportFailed(_describe(error));
    }
  }

  Future<void> validate(TemplateImportValidateInput input) async {
    final current = state;
    final preview = switch (current) {
      TemplateImportPreviewReady(:final preview) => preview,
      TemplateImportFailed(:final preview?) => preview,
      _ => null,
    };
    if (preview == null) return;

    state = TemplateImportValidating(preview);
    try {
      final repository = ref.read(templateImportRepositoryProvider);
      await repository.validate(preview.analysis.id, input);
      ref.read(brandingProfileNotifierProvider.notifier).refresh();
      state = const TemplateImportDone();
    } catch (error) {
      state = TemplateImportFailed(_describe(error), preview: preview);
    }
  }

  void reset() => state = const TemplateImportIdle();

  String _describe(Object error) =>
      asApiException(error).displayMessage;
}

final templateImportNotifierProvider =
    NotifierProvider<TemplateImportNotifier, TemplateImportState>(TemplateImportNotifier.new);
