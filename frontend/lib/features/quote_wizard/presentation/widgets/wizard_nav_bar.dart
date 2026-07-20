import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../wizard_step.dart';

/// The two ways forward that always work: Précédent and Suivant. Swiping the
/// centre does the same thing — these buttons are for those who don't swipe.
/// The last step closes the assistant (the step's own action, e.g. "Envoyer",
/// lives inside the step body).
class WizardNavBar extends StatelessWidget {
  const WizardNavBar({
    required this.step,
    required this.canAdvance,
    required this.onPrevious,
    required this.onNext,
    required this.onFinish,
    super.key,
  });

  final WizardStep step;

  /// Whether the current step is complete — asked of the draft, not the
  /// widgets. Gates Suivant so the artisan can't leave an unfinished step.
  final bool canAdvance;

  final VoidCallback onPrevious;
  final VoidCallback onNext;
  final VoidCallback onFinish;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: ArtizenColors.cardSurface,
        border: Border(top: BorderSide(color: ArtizenColors.border)),
      ),
      padding: const EdgeInsets.all(ArtizenSpacing.sm),
      child: Row(
        children: [
          OutlinedButton.icon(
            onPressed: step.isFirst ? null : onPrevious,
            icon: const Icon(Icons.arrow_back),
            label: const Text('Précédent'),
          ),
          const Spacer(),
          Text(
            'Étape ${step.number} / ${WizardStep.values.length}',
            style: const TextStyle(color: ArtizenColors.textSecondary),
          ),
          const Spacer(),
          if (step.isLast)
            FilledButton.icon(
              onPressed: onFinish,
              icon: const Icon(Icons.check),
              label: const Text('Terminer'),
            )
          else
            FilledButton.icon(
              onPressed: canAdvance ? onNext : null,
              icon: const Icon(Icons.arrow_forward),
              label: const Text('Suivant'),
            ),
        ],
      ),
    );
  }
}
