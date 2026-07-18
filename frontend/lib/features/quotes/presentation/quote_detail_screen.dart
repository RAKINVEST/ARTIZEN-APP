import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:printing/printing.dart';

import '../../../core/utils/currency.dart';
import '../../../core/widgets/app_components.dart';
import '../../../core/widgets/async_value_view.dart';
import '../../../shared/widgets/confirm_dialog.dart';
import '../../clients/presentation/clients_providers.dart';
import '../data/quote_models.dart';
import '../data/quotes_repository_impl.dart';
import 'quotes_providers.dart';
import 'widgets/quote_status_chip.dart';
import 'widgets/quote_totals_card.dart';

/// Where the artisan does something with a quote: look at it, send it,
/// record what the customer answered, and get the PDF out.
class QuoteDetailScreen extends ConsumerStatefulWidget {
  const QuoteDetailScreen({required this.quoteId, super.key});

  final String quoteId;

  @override
  ConsumerState<QuoteDetailScreen> createState() => _QuoteDetailScreenState();
}

class _QuoteDetailScreenState extends ConsumerState<QuoteDetailScreen> {
  /// Guards every action, so a double-tap cannot fire two status changes.
  /// The backend now refuses the second one (409 — a lost update found by
  /// trying to break it), but an artisan should never meet that error for a
  /// slip of the finger.
  bool _busy = false;

  Future<void> _run(Future<void> Function() action, {required String failureLabel}) async {
    if (_busy) return;
    setState(() => _busy = true);
    try {
      await action();
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$failureLabel : $error')),
        );
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _downloadPdf(Quote quote) => _run(
        () async {
          final bytes = await ref.read(quotesRepositoryProvider).downloadPdf(quote.id);
          // The OS share sheet is how a file gets saved or sent on mobile —
          // available at any status, a draft included: the artisan can hold
          // the finished document before ever marking it sent.
          await Printing.sharePdf(bytes: bytes, filename: '${quote.quoteNumber}.pdf');
        },
        failureLabel: 'Téléchargement impossible',
      );

  Future<void> _changeStatus(Quote quote, QuoteStatus next) async {
    // Sending is the irreversible step — nothing ever returns to draft — so
    // it is the one that earns a confirmation. Recording the customer's
    // answer afterwards does not: the artisan is reporting a fact.
    if (next == QuoteStatus.sent) {
      final confirmed = await showConfirmDialog(
        context,
        title: 'Marquer ce devis comme envoyé ?',
        message: 'Le devis ${quote.quoteNumber} ne sera plus modifiable ni supprimable. '
            'Vous pourrez ensuite indiquer si le client l\'accepte ou le refuse.',
        confirmLabel: 'Marquer comme envoyé',
      );
      if (!confirmed) return;
    }
    await _run(
      () => ref.read(quotesNotifierProvider.notifier).changeStatus(quote.id, next),
      failureLabel: 'Changement de statut impossible',
    );
  }

  Future<void> _duplicate(Quote quote) async {
    // No confirmation: duplicating creates a new draft and changes nothing
    // about the original — it is a safe, reversible act (the copy can be
    // deleted). A prompt would only stand between the artisan and the thing
    // they asked for.
    await _run(
      () async {
        final copy = await ref.read(quotesNotifierProvider.notifier).duplicateQuote(quote.id);
        if (mounted) {
          // Replace, not push: the artisan wanted the copy, not a stack of
          // two quote screens to back out of.
          context.pushReplacement('/quotes/${copy.id}');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Brouillon ${copy.quoteNumber} créé à partir de ${quote.quoteNumber}')),
          );
        }
      },
      failureLabel: 'Duplication impossible',
    );
  }

  Future<void> _delete(Quote quote) async {
    final confirmed = await showConfirmDialog(
      context,
      title: 'Supprimer ce brouillon ?',
      message: 'Le devis ${quote.quoteNumber} sera définitivement supprimé. '
          'Un devis ne se modifie pas : pour le corriger, supprimez-le et créez-en un nouveau.',
      confirmLabel: 'Supprimer',
    );
    if (!confirmed) return;
    await _run(
      () async {
        await ref.read(quotesNotifierProvider.notifier).deleteQuote(quote.id);
        if (mounted) context.pop();
      },
      failureLabel: 'Suppression impossible',
    );
  }

  @override
  Widget build(BuildContext context) {
    final quoteAsync = ref.watch(quoteByIdProvider(widget.quoteId));

    return Scaffold(
      appBar: AppBar(
        // The number, not "Devis": it is what the artisan says on the phone
        // and what the customer has in front of them.
        title: Text(quoteAsync.valueOrNull?.quoteNumber ?? 'Devis'),
        actions: [
          if (quoteAsync.valueOrNull != null) ...[
            IconButton(
              icon: const Icon(Icons.copy_outlined),
              // Available in every status: revise a sent/refused quote, or
              // start a new one from an existing draft.
              tooltip: 'Dupliquer en brouillon',
              onPressed: _busy ? null : () => _duplicate(quoteAsync.value!),
            ),
            IconButton(
              icon: const Icon(Icons.visibility_outlined),
              // Preview works on a draft: the artisan sees the finished
              // document without having to send it first.
              tooltip: 'Aperçu du PDF',
              onPressed: _busy
                  ? null
                  : () => context.push('/quotes/${quoteAsync.value!.id}/pdf'),
            ),
            IconButton(
              icon: const Icon(Icons.download_outlined),
              tooltip: 'Télécharger le PDF',
              onPressed: _busy ? null : () => _downloadPdf(quoteAsync.value!),
            ),
          ],
        ],
      ),
      body: AsyncValueView(
        value: quoteAsync,
        onRetry: () => ref.invalidate(quoteByIdProvider(widget.quoteId)),
        builder: (context, quote) {
          final clientAsync = ref.watch(clientByIdProvider(quote.clientId));
          return ListView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
            children: [
              Row(
                children: [
                  QuoteStatusChip(status: quote.status),
                  const Spacer(),
                  if (quote.status.isEditable)
                    TextButton.icon(
                      icon: const Icon(Icons.delete_outline, size: 18),
                      label: const Text('Supprimer'),
                      onPressed: _busy ? null : () => _delete(quote),
                    ),
                ],
              ),
              const SizedBox(height: 12),
              Card(
                child: ListTile(
                  leading: const CircleAvatar(child: Icon(Icons.person_outline)),
                  title: clientAsync.when(
                    data: (client) => Text(client.displayName),
                    loading: () => const Text('Chargement du client...'),
                    error: (_, _) => const Text('Client indisponible'),
                  ),
                  subtitle: const Text('Client'),
                ),
              ),
              const SizedBox(height: 8),
              Card(
                child: Column(
                  children: [
                    for (final line in quote.lines)
                      ListTile(
                        title: Text(line.designation),
                        subtitle: Text(
                          'Qté : ${CurrencyFormatter.formatQuantity(line.quantity)} ${line.unit} '
                          '× ${CurrencyFormatter.format(line.unitPriceHt)} HT',
                        ),
                        trailing: Text(CurrencyFormatter.format(line.totalTtc)),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              QuoteTotalsCard(quote: quote),
              const SizedBox(height: 20),
              _StatusActions(
                quote: quote,
                busy: _busy,
                onChange: (next) => _changeStatus(quote, next),
                onDuplicate: () => _duplicate(quote),
              ),
            ],
          );
        },
      ),
    );
  }
}

/// The buttons that move a quote forward — and nothing else.
///
/// Driven by [QuoteStatus.nextStates], which mirrors the backend's
/// transition table. A terminal quote shows no buttons rather than disabled
/// ones: a greyed-out "Accepter" on a refused quote only invites the
/// artisan to wonder what they did wrong.
class _StatusActions extends StatelessWidget {
  const _StatusActions({
    required this.quote,
    required this.busy,
    required this.onChange,
    required this.onDuplicate,
  });

  final Quote quote;
  final bool busy;
  final ValueChanged<QuoteStatus> onChange;
  final VoidCallback onDuplicate;

  @override
  Widget build(BuildContext context) {
    final next = quote.status.nextStates;
    if (next.isEmpty) {
      // A terminal quote can't advance, but the artisan is rarely done with
      // it — they came here to revise it. Offering "duplicate" turns a
      // dead-end screen into the start of the next quote, which is exactly
      // why the header icon alone is not enough here.
      return Column(
        children: [
          Text(
            'Ce devis est ${quote.status.label.toLowerCase()} : il reste archivé tel quel.',
            style: Theme.of(context).textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          OutlinedButton.icon(
            icon: const Icon(Icons.copy_outlined),
            label: const Text('Dupliquer en nouveau brouillon'),
            onPressed: busy ? null : onDuplicate,
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (final status in next) ...[
          if (status == QuoteStatus.sent)
            AppPrimaryButton(
              label: 'Marquer comme envoyé',
              icon: Icons.send_outlined,
              onPressed: busy ? null : () => onChange(status),
            )
          else
            OutlinedButton.icon(
              icon: Icon(
                status == QuoteStatus.accepted
                    ? Icons.check_circle_outline
                    : Icons.cancel_outlined,
              ),
              label: Text(
                status == QuoteStatus.accepted ? 'Le client a accepté' : 'Le client a refusé',
              ),
              onPressed: busy ? null : () => onChange(status),
            ),
          const SizedBox(height: 8),
        ],
      ],
    );
  }
}
