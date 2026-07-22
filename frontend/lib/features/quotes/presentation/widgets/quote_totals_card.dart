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
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _TotalRow(label: 'Total HT', amount: quote.totalHt),
            _TotalRow(label: 'TVA', amount: quote.totalVat),
            const Divider(),
            _TotalRow(
              label: 'Total TTC',
              amount: quote.totalTtc,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
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
