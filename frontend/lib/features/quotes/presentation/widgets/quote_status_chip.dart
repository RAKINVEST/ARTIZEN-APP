import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../../data/quote_models.dart';

/// The status, readable at a glance.
///
/// Colour carries the same meaning everywhere it appears (list and detail),
/// and never alone: the label is always there. An artisan checking a quote
/// on a phone in daylight should not have to distinguish two greys, and a
/// colour-blind artisan should not have to distinguish anything at all.
class QuoteStatusChip extends StatelessWidget {
  const QuoteStatusChip({
    required this.status,
    this.compact = false,
    super.key,
  });

  final QuoteStatus status;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    // Status colours are semantic tokens on the ARTIZEN design system, not
    // hardcoded here: draft neutral, sent blue, accepted gold (a
    // confirmation), refused the danger token.
    final (background, foreground, icon) = switch (status) {
      QuoteStatus.draft => (
        ArtizenColors.statusDraftBg,
        ArtizenColors.statusDraftFg,
        Icons.edit_outlined,
      ),
      QuoteStatus.sent => (
        ArtizenColors.statusSentBg,
        ArtizenColors.statusSentFg,
        Icons.send_outlined,
      ),
      QuoteStatus.accepted => (
        ArtizenColors.statusAcceptedBg,
        ArtizenColors.statusAcceptedFg,
        Icons.check_circle_outline,
      ),
      QuoteStatus.refused => (
        ArtizenColors.statusRefusedBg,
        ArtizenColors.statusRefusedFg,
        Icons.cancel_outlined,
      ),
    };

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: compact ? 8 : 10,
        vertical: compact ? 3 : 5,
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: compact ? 13 : 15, color: foreground),
          const SizedBox(width: 5),
          Text(
            status.label,
            style: TextStyle(
              color: foreground,
              fontSize: compact ? 11 : 12.5,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
