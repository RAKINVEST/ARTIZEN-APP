import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:printing/printing.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/utils/debouncer.dart';
import '../../quotes/data/quote_models.dart';
import '../../quotes/data/quotes_repository_impl.dart';
import '../data/quote_draft.dart';
import 'quote_draft_provider.dart';

/// The wizard's "prêt à remplir" panel: an always-visible preview that re-renders
/// the **real** premium PDF (`POST /quotes/preview-pdf`) a short moment after the
/// artisan changes a line, so they watch the devis fill in as they build it.
///
/// **Fills its parent** — its PDF area is an [Expanded], so it MUST be placed in
/// a bounded-height parent (an [Expanded] pane, a [SizedBox]). Handing it an
/// unbounded height is exactly the "infinite size" trap that blanked the web
/// build before, so the Personnaliser step only mounts it in its wide two-pane
/// layout (never in a scroll).
class LiveDevisPreview extends ConsumerStatefulWidget {
  const LiveDevisPreview({super.key});

  @override
  ConsumerState<LiveDevisPreview> createState() => _LiveDevisPreviewState();
}

class _LiveDevisPreviewState extends ConsumerState<LiveDevisPreview> {
  // A slightly longer debounce than the price recalc: rendering a PDF is
  // heavier than pricing, so wait until the artisan pauses.
  final Debouncer _debouncer = Debouncer(const Duration(milliseconds: 700));
  AsyncValue<Uint8List>? _pdf;
  String _signature = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _refresh();
    });
  }

  @override
  void dispose() {
    _debouncer.cancel();
    super.dispose();
  }

  /// Only the client and the (item, quantity) pairs change the document — a new
  /// calculation landing in the draft must not trigger a re-render.
  String _signatureOf(QuoteDraft draft) =>
      '${draft.clientId}|'
      '${draft.lines.map((l) => '${l.catalogItemId}:${l.quantity}').join(',')}';

  Future<void> _refresh() async {
    final draft = ref.read(quoteDraftProvider);
    _signature = _signatureOf(draft);
    final clientId = draft.clientId;
    if (clientId == null || draft.lines.isEmpty) {
      if (mounted) setState(() => _pdf = null);
      return;
    }
    final lines = [
      for (final line in draft.lines)
        QuoteLineInput(
          catalogItemId: line.catalogItemId,
          quantity: line.quantity.toString(),
        ),
    ];
    if (mounted) setState(() => _pdf = const AsyncValue.loading());
    final next = await AsyncValue.guard(
      () => ref
          .read(quotesRepositoryProvider)
          .previewDraftPdf(clientId: clientId, lines: lines),
    );
    if (mounted) setState(() => _pdf = next);
  }

  @override
  Widget build(BuildContext context) {
    // Re-render (debounced) whenever the client or the lines change.
    ref.listen(quoteDraftProvider, (_, next) {
      if (_signatureOf(next) != _signature) {
        _signature = _signatureOf(next);
        _debouncer.run(() {
          if (mounted) _refresh();
        });
      }
    });

    final pdf = _pdf;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: ArtizenColors.border),
        boxShadow: [
          BoxShadow(
            color: ArtizenColors.nightBlue.withValues(alpha: 0.05),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            child: Row(
              children: [
                const Icon(
                  Icons.visibility_outlined,
                  color: kArtizenViolet,
                  size: 20,
                ),
                const SizedBox(width: 8),
                const Text(
                  'Aperçu en direct',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: ArtizenColors.textPrimary,
                  ),
                ),
                const Spacer(),
                if (pdf?.isLoading ?? false)
                  const SizedBox(
                    height: 16,
                    width: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
              ],
            ),
          ),
          const Divider(height: 1),
          Expanded(child: _content(pdf)),
        ],
      ),
    );
  }

  Widget _content(AsyncValue<Uint8List>? pdf) {
    if (pdf == null) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Text(
            "Ajoutez des articles pour voir l'aperçu de votre devis.",
            textAlign: TextAlign.center,
            style: TextStyle(color: ArtizenColors.textSecondary),
          ),
        ),
      );
    }
    return pdf.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (_, _) => Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Aperçu indisponible.',
                style: TextStyle(color: ArtizenColors.textSecondary),
              ),
              const SizedBox(height: 8),
              TextButton(onPressed: _refresh, child: const Text('Réessayer')),
            ],
          ),
        ),
      ),
      // A copy of the bytes on each build — the printing plugin detaches the
      // ArrayBuffer on web (see PdfPreviewScaffold).
      data: (bytes) => PdfPreview(
        build: (_) => Uint8List.fromList(bytes),
        canChangePageFormat: false,
        canChangeOrientation: false,
        canDebug: false,
        allowPrinting: false,
        allowSharing: false,
        useActions: false,
        loadingWidget: const Center(child: CircularProgressIndicator()),
        pdfFileName: 'apercu-devis.pdf',
      ),
    );
  }
}
