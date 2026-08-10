import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/widgets/pdf_preview_scaffold.dart';
import '../../quotes/data/quote_models.dart';
import '../../quotes/data/quotes_repository_impl.dart';

/// A full-screen premium preview of the quote being built — the wizard's
/// "prêt à remplir" view. Renders the current client + draft lines through the
/// **same** PDF engine a real quote uses (`POST /quotes/preview-pdf`), so the
/// artisan sees exactly what their devis will look like, without creating it or
/// burning a number.
class DraftQuotePreviewScreen extends ConsumerStatefulWidget {
  const DraftQuotePreviewScreen({
    required this.clientId,
    required this.lines,
    this.discountType,
    this.discountValue,
    this.depositType,
    this.depositValue,
    super.key,
  });

  final String clientId;
  final List<QuoteLineInput> lines;
  final String? discountType;
  final String? discountValue;
  final String? depositType;
  final String? depositValue;

  @override
  ConsumerState<DraftQuotePreviewScreen> createState() =>
      _DraftQuotePreviewScreenState();
}

class _DraftQuotePreviewScreenState
    extends ConsumerState<DraftQuotePreviewScreen> {
  AsyncValue<Uint8List> _pdf = const AsyncValue.loading();

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() => _pdf = const AsyncValue.loading());
    final next = await AsyncValue.guard(
      () => ref.read(quotesRepositoryProvider).previewDraftPdf(
        clientId: widget.clientId,
        lines: widget.lines,
        discountType: widget.discountType,
        discountValue: widget.discountValue,
        depositType: widget.depositType,
        depositValue: widget.depositValue,
      ),
    );
    if (mounted) setState(() => _pdf = next);
  }

  @override
  Widget build(BuildContext context) {
    return PdfPreviewScaffold(
      title: 'Aperçu du devis',
      pdf: _pdf,
      onRetry: _load,
      fileName: 'apercu-devis.pdf',
    );
  }
}
