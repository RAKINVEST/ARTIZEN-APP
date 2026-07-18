import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/widgets/pdf_preview_scaffold.dart';
import '../../quotes/presentation/quotes_providers.dart';

/// "Aperçu du rendu": a demo quote rendered with the company's current
/// identity, logo and colours, so an artisan can confirm — right after
/// importing a template, or from Paramètres — that their branding is applied,
/// without having to create a real quote. Uses the same renderer as a real
/// quote, so what is shown here is what a real quote will look like.
class BrandingSamplePreviewScreen extends ConsumerWidget {
  const BrandingSamplePreviewScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PdfPreviewScaffold(
      title: 'Aperçu du rendu',
      pdf: ref.watch(quoteSamplePdfProvider),
      onRetry: () => ref.invalidate(quoteSamplePdfProvider),
      fileName: 'apercu-modele.pdf',
    );
  }
}
