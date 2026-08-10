import 'package:flutter/material.dart';

import '../../../../core/utils/currency.dart';
import '../../data/quote_models.dart';

/// Displays the three totals exactly as the backend computed them — this
/// widget only formats strings for display, it never adds or multiplies
/// anything.
class QuoteTotalsCard extends StatelessWidget {
  const QuoteTotalsCard({required this.quote, super.key});

  final Quote quote;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final strong = theme.textTheme.titleMedium?.copyWith(
      fontWeight: FontWeight.bold,
    );
    final hasDiscount = quote.discountAmount != '0.00';
    final hasDeposit = quote.depositAmount != '0.00';
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // With a discount, show the subtotal, the remise and the net HT;
            // otherwise a single "Total HT". Every figure is the backend's.
            if (hasDiscount) ...[
              _TotalRow(label: 'Sous-total HT', amount: quote.totalHt),
              _TotalRow(label: 'Remise', amount: quote.discountAmount),
              _TotalRow(label: 'Total HT net', amount: quote.netTotalHt),
            ] else
              _TotalRow(label: 'Total HT', amount: quote.netTotalHt),
            _TotalRow(label: 'TVA', amount: quote.netTotalVat),
            const Divider(),
            _TotalRow(label: 'Total TTC', amount: quote.netTotalTtc, style: strong),
            if (hasDeposit) ...[
              _TotalRow(label: 'Acompte à verser', amount: quote.depositAmount),
              _TotalRow(
                label: 'Solde à la livraison',
                amount: quote.balanceDue,
                style: strong,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _TotalRow extends StatelessWidget {
  const _TotalRow({required this.label, required this.amount, this.style});

  final String label;
  final String amount;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: style),
          Text(CurrencyFormatter.format(amount), style: style),
        ],
      ),
    );
  }
}
