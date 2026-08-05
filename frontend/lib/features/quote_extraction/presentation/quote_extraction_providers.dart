import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/api_exception.dart';
import '../../../shared/providers/current_company_provider.dart';
import '../data/extracted_quote.dart';
import '../data/quote_extraction_repository_impl.dart';

/// The V2 "importer un ancien devis" pipeline, one state per step:
/// idle -> uploading -> analyzing -> extracting -> ready(quote) -> [failed].
/// A single sequential state machine, like the V1 template-import one, but the
/// terminal state carries the full [ExtractedQuote] read from the PDF — never a
/// sample. The editable screen binds to `ready.quote`.
sealed class QuoteImportState {
  const QuoteImportState();
}

class QuoteImportIdle extends QuoteImportState {
  const QuoteImportIdle();
}

class QuoteImportUploading extends QuoteImportState {
  const QuoteImportUploading();
}

class QuoteImportAnalyzing extends QuoteImportState {
  const QuoteImportAnalyzing();
}

class QuoteImportExtracting extends QuoteImportState {
  const QuoteImportExtracting();
}

class QuoteImportReady extends QuoteImportState {
  const QuoteImportReady({required this.analysisId, required this.quote});
  final String analysisId;
  final ExtractedQuote quote;
}

class QuoteImportFailed extends QuoteImportState {
  const QuoteImportFailed(this.message);
  final String message;
}

class QuoteImportNotifier extends Notifier<QuoteImportState> {
  @override
  QuoteImportState build() => const QuoteImportIdle();

  Future<void> importFile({
    required String filename,
    required List<int> bytes,
  }) async {
    state = const QuoteImportUploading();
    try {
      final companyId = await ref.read(currentCompanyIdProvider.future);
      final repository = ref.read(quoteExtractionRepositoryProvider);

      final analysisId = await repository.uploadQuotePdf(
        companyId: companyId,
        filename: filename,
        bytes: bytes,
      );

      state = const QuoteImportAnalyzing();
      await repository.processAnalysis(analysisId);

      state = const QuoteImportExtracting();
      final quote = await repository.extract(analysisId);

      state = QuoteImportReady(analysisId: analysisId, quote: quote);
    } catch (error) {
      state = QuoteImportFailed(_describe(error));
    }
  }

  void reset() => state = const QuoteImportIdle();

  String _describe(Object error) => error is ApiException
      ? error.displayMessage
      : 'Une erreur inattendue est survenue.';
}

final quoteImportNotifierProvider =
    NotifierProvider<QuoteImportNotifier, QuoteImportState>(
      QuoteImportNotifier.new,
    );

/// The reproduction PDF for a given analysis, rendered server-side from the
/// extraction with the artisan's identity. `autoDispose` + `family` so leaving
/// the screen drops the bytes and a new import re-fetches.
final reproductionPdfProvider = FutureProvider.autoDispose
    .family<Uint8List, String>((ref, analysisId) {
      return ref
          .watch(quoteExtractionRepositoryProvider)
          .renderReproduction(analysisId);
    });
