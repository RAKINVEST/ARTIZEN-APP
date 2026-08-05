import 'dart:typed_data';

import '../data/extracted_quote.dart';

/// The V2 import contract the presentation layer depends on:
/// upload -> process (analysis) -> extract (full editable quote) ->
/// [reproduction PDF]. No client-side extraction or fabrication — the server
/// reads the PDF and returns only what it found.
abstract class QuoteExtractionRepository {
  /// Uploads the PDF and returns the created analysis id.
  Future<String> uploadQuotePdf({
    required String companyId,
    required String filename,
    required List<int> bytes,
  });

  Future<void> processAnalysis(String analysisId);

  /// The full quote read from the PDF — the model the editable screen binds to.
  Future<ExtractedQuote> extract(String analysisId);

  /// A faithful reproduction PDF (imported content + the artisan's identity).
  Future<Uint8List> renderReproduction(String analysisId);
}
