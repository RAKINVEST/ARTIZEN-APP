import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';
import 'widgets/wizard_left_menu.dart';
import 'widgets/wizard_nav_bar.dart';
import 'widgets/wizard_progress_bar.dart';
import 'wizard_step.dart';
import 'wizard_step_views.dart';

/// The guided quote assistant shell: a permanent left menu, a horizontal
/// progress bar, the current step in the centre, and Précédent/Suivant below.
///
/// Steps live in a [PageView] so the artisan can swipe or use the buttons —
/// both drive the same controller, so they never disagree. Mock data only for
/// now: this validates the experience before each step is wired to its API.
class QuoteWizardScreen extends StatefulWidget {
  const QuoteWizardScreen({super.key});

  @override
  State<QuoteWizardScreen> createState() => _QuoteWizardScreenState();
}

class _QuoteWizardScreenState extends State<QuoteWizardScreen> {
  final PageController _controller = PageController();
  int _index = 0;

  WizardStep get _step => WizardStep.values[_index];

  void _goTo(int index) {
    if (index < 0 || index >= WizardStep.values.length) return;
    _controller.animateToPage(
      index,
      duration: const Duration(milliseconds: 260),
      curve: Curves.easeInOut,
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
                      onPageChanged: (index) => setState(() => _index = index),
                      children: [
                        for (final step in WizardStep.values) WizardStepView(step: step),
                      ],
                    ),
                  ),
                  WizardNavBar(
                    step: _step,
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
