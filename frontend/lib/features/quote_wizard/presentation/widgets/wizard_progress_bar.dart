import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../wizard_step.dart';

/// The horizontal progress the artisan reads to know "where am I, and how much
/// is left". Past steps are ticked, the current one is highlighted, future ones
/// are muted. Tapping a step jumps to it. Scrolls horizontally so seven steps
/// fit any width.
class WizardProgressBar extends StatelessWidget {
  const WizardProgressBar({
    required this.currentIndex,
    required this.onTap,
    super.key,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ArtizenColors.surfaceLight,
      padding: const EdgeInsets.symmetric(vertical: ArtizenSpacing.sm),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: ArtizenSpacing.sm),
        child: Row(
          children: [
            for (final step in WizardStep.values) ...[
              _StepDot(
                step: step,
                state: _stateFor(step.index),
                onTap: () => onTap(step.index),
              ),
              if (!step.isLast)
                Container(
                  width: 28,
                  height: 2,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  color: step.index < currentIndex
                      ? ArtizenColors.success
                      : ArtizenColors.border,
                ),
            ],
          ],
        ),
      ),
    );
  }

  _DotState _stateFor(int index) {
    if (index < currentIndex) return _DotState.done;
    if (index == currentIndex) return _DotState.current;
    return _DotState.upcoming;
  }
}

enum _DotState { done, current, upcoming }

class _StepDot extends StatelessWidget {
  const _StepDot({
    required this.step,
    required this.state,
    required this.onTap,
  });

  final WizardStep step;
  final _DotState state;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final (Color circle, Color fg, Color text) = switch (state) {
      _DotState.done => (
        ArtizenColors.success,
        Colors.white,
        ArtizenColors.textSecondary,
      ),
      _DotState.current => (
        kArtizenViolet,
        Colors.white,
        kArtizenViolet,
      ),
      _DotState.upcoming => (
        ArtizenColors.border,
        ArtizenColors.textSecondary,
        ArtizenColors.textSecondary,
      ),
    };

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(ArtizenRadii.card),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(color: circle, shape: BoxShape.circle),
              alignment: Alignment.center,
              child: state == _DotState.done
                  ? Icon(Icons.check, size: 18, color: fg)
                  : Text(
                      '${step.number}',
                      style: TextStyle(color: fg, fontWeight: FontWeight.bold),
                    ),
            ),
            const SizedBox(height: 4),
            Text(
              step.label,
              style: TextStyle(
                color: text,
                fontSize: 11,
                fontWeight: state == _DotState.current
                    ? FontWeight.w700
                    : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
