import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

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

  @override
  void initState() {
    super.initState();
    // A fresh session never inherits a "created quote" from a previous one —
    // guarantees re-entering the wizard always starts clean at step 1.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) ref.read(createdQuoteProvider.notifier).state = null;
    });
  }

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

  /// The draft is worth protecting the moment it has a client or a line.
  bool get _hasContent {
    final draft = ref.read(quoteDraftProvider);
    return draft.clientId != null || draft.lines.isNotEmpty;
  }

  /// Guard every way out of the wizard. An empty draft leaves freely; a draft
  /// with real work asks first, and only a confirmed abandon discards it
  /// (décision 6 : ne jamais détruire le travail en cours sans le vouloir).
  /// On confirmation the draft is reset so the next "Nouveau devis" starts
  /// clean — leaving and starting fresh are the same gesture.
  Future<void> _attemptLeave(VoidCallback proceed) async {
    // Once the quote is created the work is safe — leaving just tidies up, no
    // question asked.
    if (ref.read(createdQuoteProvider) != null) {
      resetWizardDraft(ref);
      proceed();
      return;
    }
    if (!_hasContent) {
      proceed();
      return;
    }
    final abandon = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Abandonner ce devis ?'),
        content: const Text(
          "Ce devis n'est pas encore créé. Si vous quittez maintenant, "
          'le client et les lignes saisis seront perdus.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Continuer le devis'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Abandonner'),
          ),
        ],
      ),
    );
    if (abandon == true) {
      resetWizardDraft(ref);
      proceed();
    }
  }

  /// The clean way out once the quote exists: reset the wizard (only now, after
  /// full success) and land on the devis list, where the new quote already
  /// appears (`createQuote` reloaded it).
  void _finishToList() {
    resetWizardDraft(ref);
    context.go('/quotes');
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
    final hasContent = ref.watch(
      quoteDraftProvider.select((d) => d.clientId != null || d.lines.isNotEmpty),
    );
    // Once the quote is created the work is saved — the wizard may be left
    // freely (and the abandon guard no longer applies).
    final created = ref.watch(createdQuoteProvider) != null;

    // The moment the quote is created, glide to the confirmation step — the
    // artisan sees "it exists" without pressing anything. Deferred to after the
    // frame so the page animation isn't started mid-notification.
    ref.listen(createdQuoteProvider, (previous, next) {
      if (previous == null && next != null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) _goTo(WizardStep.values.length - 1);
        });
      }
    });

    return PopScope(
      // A pristine (or already-saved) draft pops immediately; one with unsaved
      // work goes through the abandon dialog before the wizard is left.
      canPop: !hasContent || created,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) return;
        _attemptLeave(() => Navigator.of(context).maybePop());
      },
      child: Scaffold(
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            WizardLeftMenu(compact: !wide, onLeave: _attemptLeave),
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
                    onFinish: _finishToList,
                  ),
                ],
              ),
            ),
          ],
        ),
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
