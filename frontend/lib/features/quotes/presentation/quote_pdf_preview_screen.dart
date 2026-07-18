import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/widgets/pdf_preview_scaffold.dart';
import 'quotes_providers.dart';

/// In-app preview of a quote's PDF — the "aperçu" an artisan looks at before
/// deciding to send, from any status including a draft. It shows the exact
/// bytes the backend renders (same endpoint as the download), so what is
/// previewed is byte-for-byte what the customer receives. The [PdfPreview]
/// toolbar also offers print and share, so the artisan can act on the
/// document without leaving the preview.
class QuotePdfPreviewScreen extends ConsumerWidget {
  const QuotePdfPreviewScreen({required this.quoteId, super.key});

  final String quoteId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PdfPreviewScaffold(
      title: 'Aperçu du devis',
      pdf: ref.watch(quotePdfProvider(quoteId)),
      onRetry: () => ref.invalidate(quotePdfProvider(quoteId)),
      fileName: 'devis.pdf',
    );
  }
}
