import 'dart:async';

import 'package:flutter/material.dart';

import '../../../core/widgets/app_components.dart';
import '../data/template_import_models.dart';

/// The first import, told as a story — the moment an artisan understands that
/// ARTIZEN *recognises* their company rather than *imports a PDF* (Décision 8).
///
/// Never a control, never a check: a recognition. The words are the artisan's
/// (BRAND.md, deux langues) — no "fraude", "contrôle", "blocage", "vérification".
///
/// Honesty contract: the "éléments retrouvés" list shows ONLY what the import
/// truly captures and re-applies to future devis — logo, colours, coordinates.
/// It never claims typography, page layout or a signature: the detection
/// pipeline captures none of them, so promising them would be theatre and would
/// break the golden rule ("je ne vois pas la différence avec le mien") at the
/// very moment the artisan trusts us. Keep the list data-driven (see initState).
///
/// The screen plays a short sequence — analyse → on retrouve votre identité →
/// les éléments retrouvés — then lands on the verdict:
/// * recognised / unverifiable → *« Nous avons reconnu votre entreprise »* and
///   into the preview;
/// * a different company → a **reassuring** message and a single confirmation
///   (rachat, franchise, changement de société…), never an accusation.
class RecognitionSequence extends StatefulWidget {
  const RecognitionSequence({
    required this.preview,
    required this.onContinue,
    super.key,
  });

  final TemplateImportPreview preview;
  final VoidCallback onContinue;

  @override
  State<RecognitionSequence> createState() => _RecognitionSequenceState();
}

class _Found {
  const _Found(this.icon, this.label);
  final IconData icon;
  final String label;
}

class _RecognitionSequenceState extends State<RecognitionSequence>
    with SingleTickerProviderStateMixin {
  late final List<_Found> _found;
  late final AnimationController _pulse;
  int _step = 0;
  bool _declared = false;
  bool _started = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _pulse = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    // Honesty contract (Décision 8 / promesse de marque): each row claims an
    // identity element ARTIZEN has ACTUALLY retrouvé and will restituer on the
    // generated devis. The import captures the logo, the colours and the
    // company's coordinates — it does NOT capture typography, page layout or a
    // signature (the detection model carries no such fields). Three hard-coded
    // labels used to promise exactly those, backed by no data: a promise/reality
    // gap at the most emotional moment. We only show what is true.
    final detection = widget.preview.detection;
    bool present(String? value) => value != null && value.trim().isNotEmpty;
    final hasCoordinates = present(detection.companyName) ||
        present(detection.siret) ||
        present(detection.address);
    _found = [
      if (detection.logoDetected)
        const _Found(Icons.image_outlined, 'Votre logo retrouvé'),
      if (detection.dominantColors.isNotEmpty)
        const _Found(Icons.palette_outlined, 'Vos couleurs retrouvées'),
      if (hasCoordinates)
        const _Found(Icons.badge_outlined, 'Vos coordonnées retrouvées'),
    ];
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_started) return;
    _started = true;

    // Respect the OS "reduce motion" setting (vestibular accessibility, and
    // WCAG 2.2.1 on timed content): no breathing orb, no staggered reveal — the
    // whole recognition is shown at once, already settled on its verdict.
    final reduceMotion = MediaQuery.maybeOf(context)?.disableAnimations ?? false;
    if (reduceMotion) {
      _step = 2 + _found.length;
      return;
    }

    _pulse.repeat(reverse: true);
    // Timeline: step 1 = "Analyse…", 2 = "Nous retrouvons…", 3.. = each found
    // element, last = the verdict (the pulse settles, the action appears).
    _timer = Timer.periodic(const Duration(milliseconds: 640), (timer) {
      if (_step >= 2 + _found.length) {
        timer.cancel();
        _pulse.stop();
        return;
      }
      setState(() => _step++);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pulse.dispose();
    super.dispose();
  }

  bool get _finished => _step >= 2 + _found.length;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mismatch =
        widget.preview.coherence.verdict == IdentityVerdict.mismatch;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(28, 40, 28, 28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _IdentityOrb(
                pulse: _pulse,
                settled: _finished,
                mismatch: mismatch,
              ),
              const SizedBox(height: 28),
              _Line(
                'Analyse de votre document…',
                visible: _step >= 1,
                theme: theme,
              ),
              _Line(
                'Nous retrouvons votre identité…',
                visible: _step >= 2,
                theme: theme,
              ),
              const SizedBox(height: 8),
              for (var i = 0; i < _found.length; i++)
                _FoundRow(
                  item: _found[i],
                  visible: _step >= 3 + i,
                  theme: theme,
                ),
              if (_finished) ...[
                const SizedBox(height: 20),
                _Verdict(preview: widget.preview, theme: theme),
              ],
            ],
          ),
        ),
      ),
      bottomNavigationBar: _finished
          ? _ActionBar(
              mismatch: mismatch,
              declared: _declared,
              onDeclaredChanged: (value) => setState(() => _declared = value),
              onContinue: widget.onContinue,
            )
          : null,
    );
  }
}

/// The identity mark: a soft violet orb with a fingerprint, breathing while it
/// searches, settling into a check once the identity is found.
class _IdentityOrb extends StatelessWidget {
  const _IdentityOrb({
    required this.pulse,
    required this.settled,
    required this.mismatch,
  });

  final Animation<double> pulse;
  final bool settled;
  final bool mismatch;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final accent = mismatch && settled
        ? const Color(0xFFB98900)
        : theme.colorScheme.primary;
    // The orb is a decorative status indicator; give a screen reader one clear
    // label for its state and hide the shifting icon underneath.
    final label = !settled
        ? 'Recherche de votre identité en cours'
        : (mismatch
              ? 'Cette identité est à confirmer'
              : 'Votre identité est reconnue');
    return Semantics(
      label: label,
      container: true,
      child: ExcludeSemantics(
        child: AnimatedBuilder(
          animation: pulse,
          builder: (context, child) {
        final glow = settled ? 0.35 : 0.18 + 0.22 * pulse.value;
        final scale = settled ? 1.0 : 0.96 + 0.06 * pulse.value;
        return Transform.scale(
          scale: scale,
          child: Container(
            width: 108,
            height: 108,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [accent, accent.withValues(alpha: 0.65)],
              ),
              boxShadow: [
                BoxShadow(
                  color: accent.withValues(alpha: glow),
                  blurRadius: 34,
                  spreadRadius: 4,
                ),
              ],
            ),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 400),
              child: Icon(
                settled
                    ? (mismatch
                          ? Icons.info_outline_rounded
                          : Icons.verified_rounded)
                    : Icons.fingerprint,
                key: ValueKey(settled ? 'done_$mismatch' : 'search'),
                size: 52,
                color: Colors.white,
              ),
            ),
          ),
        );
          },
        ),
      ),
    );
  }
}

class _Line extends StatelessWidget {
  const _Line(this.text, {required this.visible, required this.theme});

  final String text;
  final bool visible;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    // A line still in the tree at opacity 0 would be read out before it appears;
    // keep it out of the semantics tree until it is actually shown.
    return ExcludeSemantics(
      excluding: !visible,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 350),
        opacity: visible ? 1 : 0,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 3),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      ),
    );
  }
}

class _FoundRow extends StatelessWidget {
  const _FoundRow({
    required this.item,
    required this.visible,
    required this.theme,
  });

  final _Found item;
  final bool visible;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    // Read as one line ("Votre logo retrouvé") — the two icons are decorative —
    // and only once it has actually appeared.
    return ExcludeSemantics(
      excluding: !visible,
      child: MergeSemantics(
        child: AnimatedSlide(
          duration: const Duration(milliseconds: 380),
          offset: visible ? Offset.zero : const Offset(0, 0.35),
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 380),
            opacity: visible ? 1 : 0,
            child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0, end: visible ? 1 : 0),
                duration: const Duration(milliseconds: 420),
                curve: Curves.easeOutBack,
                builder: (context, value, child) =>
                    Transform.scale(scale: value, child: child),
                child: Icon(
                  Icons.check_circle_rounded,
                  color: theme.colorScheme.primary,
                  size: 22,
                ),
              ),
              const SizedBox(width: 10),
              Icon(
                item.icon,
                size: 18,
                color: theme.colorScheme.onSurfaceVariant,
              ),
              const SizedBox(width: 8),
              Text(item.label, style: theme.textTheme.bodyLarge),
            ],
          ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Verdict extends StatelessWidget {
  const _Verdict({required this.preview, required this.theme});

  final TemplateImportPreview preview;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    final verdict = preview.coherence.verdict;
    // The verdict is the payload of the whole screen. It appears after the
    // reveal, so announce it as a live region and mark it a header for
    // screen-reader landmark navigation.
    if (verdict == IdentityVerdict.mismatch) {
      return Semantics(
        liveRegion: true,
        header: true,
        child: Column(
          children: [
            Text(
              'Ce document semble appartenir à une autre entreprise.',
              textAlign: TextAlign.center,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Si vous êtes autorisé à l'utiliser — rachat, franchise, changement de "
              'société… — vous pouvez continuer après confirmation.',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      );
    }

    final title = verdict == IdentityVerdict.recognized
        ? 'Nous avons reconnu votre entreprise.'
        : 'Nous avons reconnu votre identité.';
    return Semantics(
      liveRegion: true,
      header: true,
      child: Column(
        children: [
        ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            colors: [theme.colorScheme.primary, theme.colorScheme.tertiary],
          ).createShader(bounds),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          'Tous vos futurs devis conserveront cette identité.',
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyLarge?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        ],
      ),
    );
  }
}

class _ActionBar extends StatelessWidget {
  const _ActionBar({
    required this.mismatch,
    required this.declared,
    required this.onDeclaredChanged,
    required this.onContinue,
  });

  final bool mismatch;
  final bool declared;
  final ValueChanged<bool> onDeclaredChanged;
  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      elevation: 8,
      color: theme.colorScheme.surface,
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (mismatch)
                // Checkbox + label as a single control, so a screen reader reads
                // "Je certifie… case à cocher, non cochée" — not two nodes.
                MergeSemantics(
                  child: InkWell(
                    onTap: () => onDeclaredChanged(!declared),
                    borderRadius: BorderRadius.circular(8),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        children: [
                          Checkbox(
                            value: declared,
                            onChanged: (value) =>
                                onDeclaredChanged(value ?? false),
                          ),
                          const Expanded(
                            child: Text(
                              'Je certifie être autorisé à utiliser ce document.',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              SizedBox(
                width: double.infinity,
                child: AppPrimaryButton(
                  label: mismatch ? 'Continuer' : 'Voir mon devis',
                  icon: Icons.arrow_forward_rounded,
                  onPressed: (mismatch && !declared) ? null : onContinue,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
