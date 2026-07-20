import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_theme.dart';
import 'quote_draft_provider.dart';
import 'widgets/wizard_left_menu.dart';
import 'widgets/wizard_nav_bar.dart';
import 'widgets/wizard_progress_bar.dart';
import 'wizard_step.dart';
import 'wizard_step_views.dart';

/// The guided quote assistant shell: a permanent left menu, a horizontal
/// progress bar, the current step in the centre, and Précédent/Suivant below.
///
/// Navigation is driven by the **draft**, not the widgets: you may only move
/// forward through steps the draft reports complete ([stepCompleteProvider]).
/// Both the Suivant button and swiping obey the same gate, so they never
/// disagree.
class QuoteWizardScreen extends ConsumerStatefulWidget {
  const QuoteWizardScreen({super.key});

  @override
  ConsumerState<QuoteWizardScreen> createState() => _QuoteWizardScreenState();
}

class _QuoteWizardScreenState extends ConsumerState<QuoteWizardScreen> {
  final PageController _controller = PageController();
  int _index = 0;

  WizardStep get _step => WizardStep.values[_index];

  /// Backward is always free; forward only through steps the draft says are
  /// complete. This is the one rule the buttons, the progress bar and swiping
  /// all go through.
  bool _canReach(int target) {
    if (target <= _index) return true;
    for (var j = _index; j < target; j++) {
      if (!ref.read(stepCompleteProvider(WizardStep.values[j]))) return false;
    }
    return true;
  }

  void _goTo(int target) {
    if (target < 0 || target >= WizardStep.values.length) return;
    if (!_canReach(target)) {
      _hintIncomplete();
      return;
    }
    _controller.animateToPage(
      target,
      duration: const Duration(milliseconds: 260),
      curve: Curves.easeInOut,
    );
  }

  void _hintIncomplete() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Complétez cette étape pour avancer.')),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final wide = MediaQuery.sizeOf(context).width >= 760;
    final canAdvance = ref.watch(stepCompleteProvider(_step));

    return Scaffold(
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            WizardLeftMenu(compact: !wide),
            Expanded(
              child: Column(
                children: [
                  const _WizardHeader(),
                  WizardProgressBar(currentIndex: _index, onTap: _goTo),
                  Expanded(
                    child: PageView(
                      controller: _controller,
                      onPageChanged: (target) {
                        // Bounce back a forward swipe onto an incomplete step.
                        if (target > _index && !_canReach(target)) {
                          _controller.jumpToPage(_index);
                          _hintIncomplete();
                          return;
                        }
                        setState(() => _index = target);
                      },
                      children: [
                        for (final step in WizardStep.values) WizardStepView(step: step),
                      ],
                    ),
                  ),
                  WizardNavBar(
                    step: _step,
                    canAdvance: canAdvance,
                    onPrevious: () => _goTo(_index - 1),
                    onNext: () => _goTo(_index + 1),
                    onFinish: () => Navigator.of(context).maybePop(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _WizardHeader extends StatelessWidget {
  const _WizardHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: ArtizenSpacing.md,
        vertical: ArtizenSpacing.sm,
      ),
      alignment: Alignment.centerLeft,
      child: Text(
        'Nouveau devis',
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: ArtizenColors.nightBlue,
              fontWeight: FontWeight.w700,
            ),
      ),
    );
  }
}
