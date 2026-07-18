import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/utils/external_link.dart';

/// The public ARTIZEN landing page — a full-screen, scrollable marketing page
/// served at `/` and reachable while signed out (see `core/navigation/app_router.dart`).
///
/// It sells the product to building-trade craftsmen ("artisans du bâtiment")
/// in plain, warm, jargon-free French: professional, compliant quotes in a
/// couple of minutes. Everything is styled from [ArtizenColors] / [ArtizenSpacing]
/// / [ArtizenRadii] — no hardcoded hex — and lays out responsively for phone,
/// tablet and desktop.
///
/// Honesty rule enforced in the copy: invoicing, built-in emailing and voice
/// AI are described as "à venir / bientôt", never as shipping features. Sending
/// a quote is always "téléchargez le PDF et envoyez-le à votre client".
class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  final ScrollController _scrollController = ScrollController();

  /// Anchor for the hero's "Découvrir ARTIZEN" secondary CTA, which smooth-
  /// scrolls down to the "Le problème" section.
  final GlobalKey _problemKey = GlobalKey();

  /// The beta mailto used by every "Demander un accès bêta" button. Built by
  /// hand (not via `Uri`) so the subject is percent-encoded with `%20`, which
  /// mail clients read more reliably than the `+` that `Uri` would emit.
  static const String _betaEmail = 'beta@artizen.app';
  String get _betaMailto =>
      'mailto:$_betaEmail?subject=${Uri.encodeComponent("Demande d'accès bêta ARTIZEN")}';

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _requestBetaAccess() => openExternalUrl(_betaMailto);

  void _scrollToProblem() {
    final context = _problemKey.currentContext;
    if (context == null) return;
    Scrollable.ensureVisible(
      context,
      duration: const Duration(milliseconds: 650),
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ArtizenColors.surfaceLight,
      body: Scrollbar(
        controller: _scrollController,
        child: SingleChildScrollView(
          controller: _scrollController,
          primary: false,
          child: Column(
            children: [
              _TopBar(
                onRequestBeta: _requestBetaAccess,
                onLogin: () => context.go('/login'),
              ),
              // 1. Hero
              _HeroSection(
                onRequestBeta: _requestBetaAccess,
                onDiscover: _scrollToProblem,
                onLogin: () => context.go('/login'),
              ),
              // 2. Le problème
              _ProblemSection(anchorKey: _problemKey, scrollController: _scrollController),
              // 3. La solution
              _SolutionSection(scrollController: _scrollController),
              // 4. Comment ça marche
              _HowItWorksSection(scrollController: _scrollController),
              // 5. Pourquoi ARTIZEN
              _WhySection(scrollController: _scrollController),
              // 6. Captures d'écran
              _ScreenshotsSection(scrollController: _scrollController),
              // 7. À qui s'adresse ARTIZEN
              _MetiersSection(scrollController: _scrollController),
              // 8. FAQ
              _FaqSection(scrollController: _scrollController),
              // 9. Bêta privée
              _BetaSection(scrollController: _scrollController, onRequestBeta: _requestBetaAccess),
              // 10. CTA final + footer
              _FinalCtaSection(onRequestBeta: _requestBetaAccess),
              _Footer(onLogin: () => context.go('/login')),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Layout primitives
// ---------------------------------------------------------------------------

/// Landing-page breakpoints. Mobile stacks everything; tablet/desktop widen the
/// grids and turn the hero into a two-column layout.
class _Bp {
  const _Bp._();
  static const double mobile = 640;
  static const double tablet = 1024;
  static const double maxContent = 1180;

  static bool isMobile(double w) => w < mobile;
  static bool isTablet(double w) => w >= mobile && w < tablet;
}

/// A full-width band with a background, vertical rhythm and a centred,
/// max-width content column. Every section is built on top of this so spacing
/// and measure stay consistent across the whole page.
class _Section extends StatelessWidget {
  const _Section({
    required this.child,
    this.background = ArtizenColors.surfaceLight,
    this.anchorKey,
  });

  final Widget child;
  final Color background;
  final Key? anchorKey;

  @override
  Widget build(BuildContext context) {
    return Container(
      key: anchorKey,
      width: double.infinity,
      color: background,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final w = constraints.maxWidth;
          final horizontal = _Bp.isMobile(w) ? ArtizenSpacing.md : ArtizenSpacing.xl;
          final vertical = _Bp.isMobile(w) ? ArtizenSpacing.xl : ArtizenSpacing.xxl;
          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: _Bp.maxContent),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
                child: child,
              ),
            ),
          );
        },
      ),
    );
  }
}

/// A small gold "eyebrow" label sitting above a section heading — two gold
/// dashes framing an uppercase word, echoing the login banner's identity.
class _Eyebrow extends StatelessWidget {
  const _Eyebrow(this.label, {this.onDark = false});

  final String label;
  final bool onDark;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const _GoldDash(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: ArtizenSpacing.xs),
          child: Text(
            label.toUpperCase(),
            style: const TextStyle(
              color: ArtizenColors.gold,
              fontSize: 12,
              fontWeight: FontWeight.w700,
              letterSpacing: 2,
            ),
          ),
        ),
        const _GoldDash(),
      ],
    );
  }
}

class _GoldDash extends StatelessWidget {
  const _GoldDash();

  @override
  Widget build(BuildContext context) =>
      Container(width: 16, height: 1.6, color: ArtizenColors.gold);
}

/// A section title. Marked as a semantic header so assistive tech and the web
/// semantics tree expose the page's heading structure (one H1 in the hero,
/// an H2-equivalent per section).
class _Heading extends StatelessWidget {
  const _Heading(
    this.text, {
    this.onDark = false,
    this.maxWidth,
  });

  final String text;
  final bool onDark;
  final double? maxWidth;

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    final size = _Bp.isMobile(w) ? 26.0 : 34.0;
    final title = Semantics(
      header: true,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: size,
          height: 1.2,
          fontWeight: FontWeight.w700,
          color: onDark ? ArtizenColors.onNightBlue : ArtizenColors.nightBlue,
        ),
      ),
    );
    if (maxWidth == null) return title;
    return ConstrainedBox(constraints: BoxConstraints(maxWidth: maxWidth!), child: title);
  }
}

/// Muted supporting paragraph under a heading.
class _Lead extends StatelessWidget {
  const _Lead(this.text, {this.onDark = false});

  final String text;
  final bool onDark;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 640),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 17,
          height: 1.55,
          color: onDark
              ? ArtizenColors.onNightBlue.withValues(alpha: 0.82)
              : ArtizenColors.textSecondary,
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Reveal-on-scroll animation
// ---------------------------------------------------------------------------

/// Fades and lifts its child into view the first time it approaches the
/// viewport. Driven by the page's single [ScrollController] (no extra package),
/// it reveals above-the-fold content on first frame and the rest as the user
/// scrolls. Honors the platform "reduce motion" setting by showing instantly.
class _Reveal extends StatefulWidget {
  const _Reveal({required this.controller, required this.child});

  final ScrollController controller;
  final Widget child;

  @override
  State<_Reveal> createState() => _RevealState();
}

class _RevealState extends State<_Reveal> {
  bool _shown = false;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_maybeReveal);
    WidgetsBinding.instance.addPostFrameCallback((_) => _maybeReveal());
  }

  @override
  void dispose() {
    widget.controller.removeListener(_maybeReveal);
    super.dispose();
  }

  void _maybeReveal() {
    if (_shown || !mounted) return;
    final box = context.findRenderObject() as RenderBox?;
    if (box == null || !box.hasSize) return;
    final dy = box.localToGlobal(Offset.zero).dy;
    final screenHeight = MediaQuery.sizeOf(context).height;
    // Reveal once the top of the block reaches the lower ~90% of the viewport.
    if (dy < screenHeight * 0.9) {
      widget.controller.removeListener(_maybeReveal);
      setState(() => _shown = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Respect the OS "reduce motion" accessibility preference.
    if (MediaQuery.of(context).disableAnimations) return widget.child;
    return AnimatedSlide(
      offset: _shown ? Offset.zero : const Offset(0, 0.06),
      duration: const Duration(milliseconds: 520),
      curve: Curves.easeOutCubic,
      child: AnimatedOpacity(
        opacity: _shown ? 1 : 0,
        duration: const Duration(milliseconds: 520),
        curve: Curves.easeOut,
        child: widget.child,
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Buttons
// ---------------------------------------------------------------------------

/// The gold primary CTA used across the page. Mirrors the app's [FilledButton]
/// theme (gold ground, night-blue label, ≥48 dp target) but is sized for a
/// marketing page and never stretches full width by default.
class _PrimaryCta extends StatelessWidget {
  const _PrimaryCta({required this.label, required this.onPressed});

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
      onPressed: onPressed,
      icon: const Icon(Icons.mark_email_read_outlined, size: 20),
      label: Text(label.toUpperCase(), style: const TextStyle(letterSpacing: 0.5)),
      style: FilledButton.styleFrom(
        minimumSize: const Size(0, 54),
        padding: const EdgeInsets.symmetric(horizontal: ArtizenSpacing.md),
      ),
    );
  }
}

/// The secondary CTA — an outlined night-blue (or white, on dark) button that
/// reads as deliberate without competing with the gold primary.
class _SecondaryCta extends StatelessWidget {
  const _SecondaryCta({
    required this.label,
    required this.onPressed,
    this.onDark = false,
  });

  final String label;
  final VoidCallback onPressed;
  final bool onDark;

  @override
  Widget build(BuildContext context) {
    final color = onDark ? ArtizenColors.onNightBlue : ArtizenColors.nightBlue;
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: Icon(Icons.arrow_downward, size: 18, color: color),
      label: Text(label.toUpperCase(), style: TextStyle(letterSpacing: 0.5, color: color)),
      style: OutlinedButton.styleFrom(
        foregroundColor: color,
        minimumSize: const Size(0, 54),
        side: BorderSide(color: color.withValues(alpha: onDark ? 0.8 : 1)),
        padding: const EdgeInsets.symmetric(horizontal: ArtizenSpacing.md),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Top bar
// ---------------------------------------------------------------------------

/// A slim, non-sticky header: the ARTIZEN wordmark on the left, a "Connexion"
/// link and the beta CTA on the right. On mobile the CTA collapses to keep the
/// bar uncluttered.
class _TopBar extends StatelessWidget {
  const _TopBar({required this.onRequestBeta, required this.onLogin});

  final VoidCallback onRequestBeta;
  final VoidCallback onLogin;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: ArtizenColors.nightBlue,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: _Bp.maxContent),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: ArtizenSpacing.md,
              vertical: ArtizenSpacing.sm,
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final compact = _Bp.isMobile(constraints.maxWidth);
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const _Wordmark(),
                    Row(
                      children: [
                        TextButton(
                          onPressed: onLogin,
                          style: TextButton.styleFrom(
                            foregroundColor: ArtizenColors.onNightBlue,
                            minimumSize: const Size(0, 48),
                          ),
                          child: const Text('CONNEXION', style: TextStyle(letterSpacing: 0.5)),
                        ),
                        if (!compact) ...[
                          const SizedBox(width: ArtizenSpacing.xs),
                          _PrimaryCta(label: 'Accès bêta', onPressed: onRequestBeta),
                        ],
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

/// The "ARTIZEN" brand wordmark: Orbitron, uppercase, widely spaced — used
/// only for the mark itself, per the design system.
class _Wordmark extends StatelessWidget {
  const _Wordmark({this.color = ArtizenColors.onNightBlue, this.size = 22});

  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      header: true,
      label: 'ARTIZEN',
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.handyman, color: ArtizenColors.gold, size: 24),
          const SizedBox(width: ArtizenSpacing.xs),
          Text(
            'ARTIZEN',
            style: TextStyle(
              fontFamily: AppTheme.displayFontFamily,
              color: color,
              fontSize: size,
              fontWeight: FontWeight.w700,
              letterSpacing: 4,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// 1. Hero
// ---------------------------------------------------------------------------

class _HeroSection extends StatelessWidget {
  const _HeroSection({
    required this.onRequestBeta,
    required this.onDiscover,
    required this.onLogin,
  });

  final VoidCallback onRequestBeta;
  final VoidCallback onDiscover;
  final VoidCallback onLogin;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [ArtizenColors.nightBlue, ArtizenColors.blueSecondary],
        ),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: _Bp.maxContent),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final w = constraints.maxWidth;
              final isMobile = _Bp.isMobile(w);
              final horizontal = isMobile ? ArtizenSpacing.md : ArtizenSpacing.xl;
              final padding = EdgeInsets.symmetric(
                horizontal: horizontal,
                vertical: isMobile ? ArtizenSpacing.xl : ArtizenSpacing.xxl,
              );
              final copy = _HeroCopy(
                onRequestBeta: onRequestBeta,
                onDiscover: onDiscover,
                onLogin: onLogin,
                isMobile: isMobile,
              );
              const visual = _HeroMockup();

              return Padding(
                padding: padding,
                child: isMobile
                    ? Column(
                        children: [
                          copy,
                          const SizedBox(height: ArtizenSpacing.xl),
                          visual,
                        ],
                      )
                    : Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(flex: 6, child: copy),
                          const SizedBox(width: ArtizenSpacing.xl),
                          const Expanded(flex: 5, child: visual),
                        ],
                      ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _HeroCopy extends StatelessWidget {
  const _HeroCopy({
    required this.onRequestBeta,
    required this.onDiscover,
    required this.onLogin,
    required this.isMobile,
  });

  final VoidCallback onRequestBeta;
  final VoidCallback onDiscover;
  final VoidCallback onLogin;
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    final align = isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start;
    final textAlign = isMobile ? TextAlign.center : TextAlign.start;
    return Column(
      crossAxisAlignment: align,
      mainAxisSize: MainAxisSize.min,
      children: [
        const _Eyebrow('Le copilote des artisans', onDark: true),
        const SizedBox(height: ArtizenSpacing.md),
        // The single H1 of the page.
        Semantics(
          header: true,
          child: Text(
            'Vos devis, aux normes,\nen 2 minutes.',
            textAlign: textAlign,
            style: TextStyle(
              fontSize: isMobile ? 34 : 52,
              height: 1.1,
              fontWeight: FontWeight.w800,
              color: ArtizenColors.onNightBlue,
            ),
          ),
        ),
        const SizedBox(height: ArtizenSpacing.md),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 560),
          child: Text(
            'ARTIZEN, l’assistant administratif des artisans du bâtiment : '
            'créez des devis professionnels et 100 % conformes depuis votre '
            'téléphone. Moins de paperasse, plus de temps sur les chantiers.',
            textAlign: textAlign,
            style: TextStyle(
              fontSize: 18,
              height: 1.55,
              color: ArtizenColors.onNightBlue.withValues(alpha: 0.85),
            ),
          ),
        ),
        const SizedBox(height: ArtizenSpacing.lg),
        Wrap(
          spacing: ArtizenSpacing.sm,
          runSpacing: ArtizenSpacing.sm,
          alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
          children: [
            _PrimaryCta(label: 'Demander un accès bêta', onPressed: onRequestBeta),
            _SecondaryCta(
              label: 'Découvrir ARTIZEN',
              onPressed: onDiscover,
              onDark: true,
            ),
          ],
        ),
        const SizedBox(height: ArtizenSpacing.md),
        // Discreet "already have an account?" link.
        TextButton(
          onPressed: onLogin,
          style: TextButton.styleFrom(
            foregroundColor: ArtizenColors.gold,
            minimumSize: const Size(0, 48),
            padding: const EdgeInsets.symmetric(horizontal: ArtizenSpacing.xs),
          ),
          child: const Text('Déjà un compte ? Connexion'),
        ),
      ],
    );
  }
}

/// A decorative product mock — a stylised phone showing a mini quote. It stands
/// in for a real screenshot on the right of the hero; swap it for an
/// `Image.asset('assets/landing/hero.png')` once artwork exists (see the
/// screenshots section for the wiring steps).
class _HeroMockup extends StatelessWidget {
  const _HeroMockup();

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Aperçu de l’application ARTIZEN : un devis professionnel',
      image: true,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 320),
          child: AspectRatio(
            aspectRatio: 9 / 16,
            child: Container(
              padding: const EdgeInsets.all(ArtizenSpacing.sm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(ArtizenRadii.card + 12),
                boxShadow: [
                  BoxShadow(
                    color: ArtizenColors.nightBlue.withValues(alpha: 0.45),
                    blurRadius: 40,
                    offset: const Offset(0, 20),
                  ),
                ],
                border: Border.all(color: ArtizenColors.gold.withValues(alpha: 0.5), width: 1.5),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const _Wordmark(color: ArtizenColors.nightBlue, size: 15),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: ArtizenColors.statusSentBg,
                          borderRadius: BorderRadius.circular(ArtizenRadii.pill),
                        ),
                        child: const Text(
                          'DEV-2026-0001',
                          style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.w700,
                            color: ArtizenColors.statusSentFg,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: ArtizenSpacing.sm),
                  const _MockLine(width: 0.5, label: 'Client : M. Bernard'),
                  const SizedBox(height: 6),
                  const _MockLine(width: 0.35, label: 'Chantier : rénovation SDB'),
                  const SizedBox(height: ArtizenSpacing.sm),
                  const Divider(color: ArtizenColors.border, height: 1),
                  const SizedBox(height: ArtizenSpacing.sm),
                  const _MockRow(label: 'Fourniture robinetterie', amount: '180,00 €'),
                  const SizedBox(height: 8),
                  const _MockRow(label: 'Pose + raccordements', amount: '240,00 €'),
                  const SizedBox(height: 8),
                  const _MockRow(label: 'Carrelage mural', amount: '320,00 €'),
                  const Spacer(),
                  const Divider(color: ArtizenColors.border, height: 1),
                  const SizedBox(height: ArtizenSpacing.xs),
                  const _MockRow(label: 'Total HT', amount: '740,00 €', muted: true),
                  const SizedBox(height: 4),
                  const _MockRow(label: 'TVA 10 %', amount: '74,00 €', muted: true),
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.all(ArtizenSpacing.xs),
                    decoration: BoxDecoration(
                      color: ArtizenColors.nightBlue,
                      borderRadius: BorderRadius.circular(ArtizenRadii.field),
                    ),
                    child: const _MockRow(
                      label: 'Total TTC',
                      amount: '814,00 €',
                      onDark: true,
                      bold: true,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _MockLine extends StatelessWidget {
  const _MockLine({required this.width, required this.label});

  final double width;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: const TextStyle(fontSize: 11, color: ArtizenColors.textSecondary),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}

class _MockRow extends StatelessWidget {
  const _MockRow({
    required this.label,
    required this.amount,
    this.muted = false,
    this.bold = false,
    this.onDark = false,
  });

  final String label;
  final String amount;
  final bool muted;
  final bool bold;
  final bool onDark;

  @override
  Widget build(BuildContext context) {
    final color = onDark
        ? ArtizenColors.onNightBlue
        : (muted ? ArtizenColors.textSecondary : ArtizenColors.textPrimary);
    final style = TextStyle(
      fontSize: 12,
      color: color,
      fontWeight: bold ? FontWeight.w700 : FontWeight.w500,
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(child: Text(label, style: style, maxLines: 1, overflow: TextOverflow.ellipsis)),
        Text(amount, style: style),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// 2. Le problème
// ---------------------------------------------------------------------------

class _ProblemSection extends StatelessWidget {
  const _ProblemSection({required this.anchorKey, required this.scrollController});

  final GlobalKey anchorKey;
  final ScrollController scrollController;

  static const List<_Point> _points = [
    _Point(Icons.description_outlined, 'Des devis bricolés',
        'Word, Excel, feuilles volantes… on recommence à chaque fois.'),
    _Point(Icons.gavel_outlined, 'Des mentions légales oubliées',
        'SIRET, TVA, conditions : un oubli et le devis n’est plus conforme.'),
    _Point(Icons.warning_amber_rounded, 'La peur du devis pas aux normes',
        'Un doute permanent : « Est-ce que j’ai le droit d’écrire ça ? »'),
    _Point(Icons.nightlight_outlined, 'Du temps perdu le soir',
        'La paperasse déborde sur les week-ends et les fins de journée.'),
    _Point(Icons.sentiment_dissatisfied_outlined, 'Une image amateur',
        'Un document brouillon donne une mauvaise première impression au client.'),
  ];

  @override
  Widget build(BuildContext context) {
    return _Section(
      anchorKey: anchorKey,
      background: ArtizenColors.surfaceLight,
      child: Column(
        children: [
          _Reveal(
            controller: scrollController,
            child: const Column(
              children: [
                _Eyebrow('Le problème'),
                SizedBox(height: ArtizenSpacing.sm),
                _Heading('La paperasse vous prend un temps fou.'),
                SizedBox(height: ArtizenSpacing.sm),
                _Lead(
                  'Vous êtes doué de vos mains, pas pour l’administratif — et c’est '
                  'normal. Pourtant, chaque devis vous coûte des heures.',
                ),
              ],
            ),
          ),
          const SizedBox(height: ArtizenSpacing.xl),
          _Reveal(
            controller: scrollController,
            child: _ResponsiveGrid(
              children: [for (final p in _points) _PainCard(point: p)],
            ),
          ),
        ],
      ),
    );
  }
}

class _Point {
  const _Point(this.icon, this.title, this.body);
  final IconData icon;
  final String title;
  final String body;
}

class _PainCard extends StatelessWidget {
  const _PainCard({required this.point});

  final _Point point;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(ArtizenSpacing.md),
      decoration: BoxDecoration(
        color: ArtizenColors.cardSurface,
        borderRadius: BorderRadius.circular(ArtizenRadii.card),
        border: Border.all(color: ArtizenColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: ArtizenColors.error.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(ArtizenRadii.field),
            ),
            child: Icon(point.icon, color: ArtizenColors.error, size: 24),
          ),
          const SizedBox(height: ArtizenSpacing.sm),
          Text(
            point.title,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: ArtizenColors.nightBlue,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            point.body,
            style: const TextStyle(fontSize: 14, height: 1.5, color: ArtizenColors.textSecondary),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// 3. La solution
// ---------------------------------------------------------------------------

class _SolutionSection extends StatelessWidget {
  const _SolutionSection({required this.scrollController});

  final ScrollController scrollController;

  static const List<_Point> _pillars = [
    _Point(Icons.verified_outlined, 'Conforme',
        'Les mentions obligatoires sont toujours là. Un devis carré, à chaque fois.'),
    _Point(Icons.bolt_outlined, 'Rapide',
        'Choisissez vos prestations, ARTIZEN calcule HT, TVA et TTC pour vous.'),
    _Point(Icons.touch_app_outlined, 'Simple',
        'Pensé pour le terrain : quelques touches, même avec des gants au chantier.'),
  ];

  @override
  Widget build(BuildContext context) {
    return _Section(
      background: ArtizenColors.nightBlue,
      child: Column(
        children: [
          _Reveal(
            controller: scrollController,
            child: const Column(
              children: [
                _Eyebrow('La solution', onDark: true),
                SizedBox(height: ArtizenSpacing.sm),
                _Heading(
                  'ARTIZEN s’occupe de la paperasse,\nvous vous occupez du chantier.',
                  onDark: true,
                ),
                SizedBox(height: ArtizenSpacing.md),
                _Lead(
                  'Vous entrez ce que vous facturez, ARTIZEN met en forme un devis '
                  'professionnel et conforme, prêt à envoyer. Pas de logiciel compliqué, '
                  'pas de formation : votre téléphone suffit.',
                  onDark: true,
                ),
              ],
            ),
          ),
          const SizedBox(height: ArtizenSpacing.xl),
          _Reveal(
            controller: scrollController,
            child: _ResponsiveGrid(
              desktopColumns: 3,
              children: [for (final p in _pillars) _PillarCard(point: p)],
            ),
          ),
        ],
      ),
    );
  }
}

class _PillarCard extends StatelessWidget {
  const _PillarCard({required this.point});

  final _Point point;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(ArtizenSpacing.md),
      decoration: BoxDecoration(
        color: ArtizenColors.onNightBlue.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(ArtizenRadii.card),
        border: Border.all(color: ArtizenColors.gold.withValues(alpha: 0.35)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(point.icon, color: ArtizenColors.gold, size: 34),
          const SizedBox(height: ArtizenSpacing.sm),
          Text(
            point.title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: ArtizenColors.onNightBlue,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            point.body,
            style: TextStyle(
              fontSize: 14,
              height: 1.5,
              color: ArtizenColors.onNightBlue.withValues(alpha: 0.8),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// 4. Comment ça marche
// ---------------------------------------------------------------------------

class _HowItWorksSection extends StatelessWidget {
  const _HowItWorksSection({required this.scrollController});

  final ScrollController scrollController;

  static const List<_Step> _steps = [
    _Step(1, Icons.store_mall_directory_outlined, 'Créez votre entreprise',
        'Une seule fois : nom, SIRET, TVA, logo. ARTIZEN s’en souvient pour tous vos devis.'),
    _Step(2, Icons.inventory_2_outlined, 'Ajoutez votre catalogue',
        'Vos prestations et vos tarifs habituels, prêts à réutiliser en un geste.'),
    _Step(3, Icons.person_add_alt_1_outlined, 'Créez un client',
        'Ses coordonnées une fois, réutilisables pour tous ses chantiers.'),
    _Step(4, Icons.receipt_long_outlined, 'Créez votre devis',
        'Choisissez les prestations, la quantité : les totaux HT, TVA et TTC se calculent seuls.'),
    _Step(5, Icons.picture_as_pdf_outlined, 'Téléchargez le PDF et envoyez-le',
        'Un PDF net et professionnel, prêt à transmettre à votre client.'),
  ];

  @override
  Widget build(BuildContext context) {
    return _Section(
      background: ArtizenColors.surfaceLight,
      child: Column(
        children: [
          _Reveal(
            controller: scrollController,
            child: const Column(
              children: [
                _Eyebrow('Comment ça marche'),
                SizedBox(height: ArtizenSpacing.sm),
                _Heading('Cinq étapes, et votre devis est prêt.'),
                SizedBox(height: ArtizenSpacing.sm),
                _Lead('Les trois premières, c’est une fois pour toutes. Ensuite, un devis se '
                    'fait en quelques minutes.'),
              ],
            ),
          ),
          const SizedBox(height: ArtizenSpacing.xl),
          for (int i = 0; i < _steps.length; i++) ...[
            _Reveal(
              controller: scrollController,
              child: _StepRow(step: _steps[i], isLast: i == _steps.length - 1),
            ),
          ],
        ],
      ),
    );
  }
}

class _Step {
  const _Step(this.number, this.icon, this.title, this.body);
  final int number;
  final IconData icon;
  final String title;
  final String body;
}

class _StepRow extends StatelessWidget {
  const _StepRow({required this.step, required this.isLast});

  final _Step step;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 720),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: ArtizenColors.nightBlue,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '${step.number}',
                    style: const TextStyle(
                      color: ArtizenColors.gold,
                      fontWeight: FontWeight.w800,
                      fontSize: 18,
                    ),
                  ),
                ),
                if (!isLast)
                  Expanded(
                    child: Container(width: 2, color: ArtizenColors.border),
                  ),
              ],
            ),
            const SizedBox(width: ArtizenSpacing.md),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(bottom: isLast ? 0 : ArtizenSpacing.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(step.icon, color: ArtizenColors.nightBlue, size: 22),
                        const SizedBox(width: ArtizenSpacing.xs),
                        Expanded(
                          child: Text(
                            step.title,
                            style: const TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.w700,
                              color: ArtizenColors.nightBlue,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      step.body,
                      style: const TextStyle(
                        fontSize: 15,
                        height: 1.5,
                        color: ArtizenColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// 5. Pourquoi ARTIZEN
// ---------------------------------------------------------------------------

class _WhySection extends StatelessWidget {
  const _WhySection({required this.scrollController});

  final ScrollController scrollController;

  static const List<_Point> _assets = [
    _Point(Icons.thumb_up_alt_outlined, 'Simplicité',
        'Pensé pour les artisans, pas pour les informaticiens.'),
    _Point(Icons.speed_outlined, 'Rapidité',
        'Un devis en quelques minutes, pas en une soirée.'),
    _Point(Icons.verified_user_outlined, 'Conformité garantie',
        'Les mentions obligatoires sont toujours présentes.'),
    _Point(Icons.picture_as_pdf_outlined, 'PDF professionnel',
        'Un document propre qui donne confiance à vos clients.'),
    _Point(Icons.support_agent_outlined, 'Prise en main guidée',
        'On vous accompagne pas à pas, dès le premier devis.'),
    _Point(Icons.cloud_done_outlined, 'Aucune installation complexe',
        'Rien à installer : votre navigateur ou votre téléphone suffit.'),
  ];

  @override
  Widget build(BuildContext context) {
    return _Section(
      background: Colors.white,
      child: Column(
        children: [
          _Reveal(
            controller: scrollController,
            child: const Column(
              children: [
                _Eyebrow('Pourquoi ARTIZEN'),
                SizedBox(height: ArtizenSpacing.sm),
                _Heading('Tout ce qu’il faut, rien de superflu.'),
              ],
            ),
          ),
          const SizedBox(height: ArtizenSpacing.xl),
          _Reveal(
            controller: scrollController,
            child: _ResponsiveGrid(
              desktopColumns: 3,
              children: [for (final a in _assets) _FeatureCard(point: a)],
            ),
          ),
        ],
      ),
    );
  }
}

class _FeatureCard extends StatelessWidget {
  const _FeatureCard({required this.point});

  final _Point point;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(ArtizenSpacing.md),
      decoration: BoxDecoration(
        color: ArtizenColors.surfaceLight,
        borderRadius: BorderRadius.circular(ArtizenRadii.card),
        border: Border.all(color: ArtizenColors.border),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: ArtizenColors.gold.withValues(alpha: 0.16),
              borderRadius: BorderRadius.circular(ArtizenRadii.field),
            ),
            child: Icon(point.icon, color: ArtizenColors.nightBlue, size: 24),
          ),
          const SizedBox(width: ArtizenSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    const Icon(Icons.check_circle, color: ArtizenColors.success, size: 18),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        point.title,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: ArtizenColors.nightBlue,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  point.body,
                  style: const TextStyle(
                    fontSize: 14,
                    height: 1.5,
                    color: ArtizenColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// 6. Captures d'écran
// ---------------------------------------------------------------------------

class _ScreenshotsSection extends StatelessWidget {
  const _ScreenshotsSection({required this.scrollController});

  final ScrollController scrollController;

  // ---------------------------------------------------------------------------
  // HOW TO PLUG IN REAL SCREENSHOTS
  // ---------------------------------------------------------------------------
  // 1. Drop the images under `frontend/assets/landing/`, e.g.
  //      assets/landing/screen_catalog.png
  //      assets/landing/screen_quote.png
  //      assets/landing/screen_pdf.png
  //    (PNG/WEBP; a phone-sized ~9:16 export reads best in these frames.)
  // 2. Declare the folder in `pubspec.yaml` under `flutter: assets:` — an
  //    example line is already there, commented out:
  //      # - assets/landing/
  //    Uncomment it and run `flutter pub get`.
  // 3. Replace the `_ScreenshotPlaceholder(...)` below with:
  //      ClipRRect(
  //        borderRadius: BorderRadius.circular(ArtizenRadii.card),
  //        child: Image.asset('assets/landing/screen_quote.png', fit: BoxFit.cover),
  //      )
  //    Keep each image inside an AspectRatio(9/16) (mobile) or (16/10)
  //    (desktop) so the responsive layout stays intact, and keep the
  //    Semantics label describing the shot for accessibility.
  // ---------------------------------------------------------------------------

  static const List<_Shot> _shots = [
    _Shot(Icons.inventory_2_outlined, 'Votre catalogue',
        'Vos prestations et tarifs, prêts à réutiliser.'),
    _Shot(Icons.receipt_long_outlined, 'La création de devis',
        'Sélectionnez, ajustez la quantité, les totaux se calculent.'),
    _Shot(Icons.picture_as_pdf_outlined, 'Le PDF final',
        'Un devis conforme, prêt à envoyer à votre client.'),
  ];

  @override
  Widget build(BuildContext context) {
    return _Section(
      background: ArtizenColors.surfaceLight,
      child: Column(
        children: [
          _Reveal(
            controller: scrollController,
            child: const Column(
              children: [
                _Eyebrow('Aperçu'),
                SizedBox(height: ArtizenSpacing.sm),
                _Heading('Voyez ARTIZEN en action.'),
                SizedBox(height: ArtizenSpacing.sm),
                _Lead('Les vraies captures arrivent — voici les trois écrans que vous '
                    'utiliserez le plus.'),
              ],
            ),
          ),
          const SizedBox(height: ArtizenSpacing.xl),
          _Reveal(
            controller: scrollController,
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isMobile = _Bp.isMobile(constraints.maxWidth);
                final children = [
                  for (final s in _shots)
                    _ScreenshotPlaceholder(shot: s, portrait: isMobile),
                ];
                if (isMobile) {
                  return Column(
                    children: [
                      for (int i = 0; i < children.length; i++) ...[
                        if (i > 0) const SizedBox(height: ArtizenSpacing.md),
                        children[i],
                      ],
                    ],
                  );
                }
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (int i = 0; i < children.length; i++) ...[
                      if (i > 0) const SizedBox(width: ArtizenSpacing.md),
                      Expanded(child: children[i]),
                    ],
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _Shot {
  const _Shot(this.icon, this.title, this.caption);
  final IconData icon;
  final String title;
  final String caption;
}

/// An elegant placeholder frame standing in for a real screenshot. It carries
/// a Semantics label so screen readers announce it, and a legible "Aperçu à
/// venir" caption so nothing looks broken before artwork lands.
class _ScreenshotPlaceholder extends StatelessWidget {
  const _ScreenshotPlaceholder({required this.shot, required this.portrait});

  final _Shot shot;
  final bool portrait;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Aperçu à venir : ${shot.title}',
      image: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: portrait ? 9 / 16 : 16 / 10,
            child: Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [ArtizenColors.nightBlue, ArtizenColors.blueSecondary],
                ),
                borderRadius: BorderRadius.circular(ArtizenRadii.card),
                border: Border.all(color: ArtizenColors.gold.withValues(alpha: 0.4)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(shot.icon, color: ArtizenColors.gold, size: 40),
                  const SizedBox(height: ArtizenSpacing.sm),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: ArtizenSpacing.sm),
                    child: Text(
                      shot.title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: ArtizenColors.onNightBlue,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Aperçu à venir',
                    style: TextStyle(
                      color: ArtizenColors.gold,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: ArtizenSpacing.xs),
          Text(
            shot.caption,
            style: const TextStyle(fontSize: 13, color: ArtizenColors.textSecondary, height: 1.4),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// 7. À qui s'adresse ARTIZEN
// ---------------------------------------------------------------------------

class _MetiersSection extends StatelessWidget {
  const _MetiersSection({required this.scrollController});

  final ScrollController scrollController;

  static const List<_Metier> _metiers = [
    _Metier(Icons.plumbing_outlined, 'Plomberie'),
    _Metier(Icons.local_fire_department_outlined, 'Chauffage'),
    _Metier(Icons.ac_unit_outlined, 'Climatisation'),
    _Metier(Icons.electrical_services_outlined, 'Électricité'),
    _Metier(Icons.home_repair_service_outlined, 'Rénovation'),
    _Metier(Icons.carpenter_outlined, 'Menuiserie'),
    _Metier(Icons.format_paint_outlined, 'Peinture'),
    _Metier(Icons.foundation_outlined, 'Maçonnerie'),
    _Metier(Icons.roofing_outlined, 'Couverture'),
    _Metier(Icons.handyman_outlined, 'Multiservice'),
  ];

  @override
  Widget build(BuildContext context) {
    return _Section(
      background: Colors.white,
      child: Column(
        children: [
          _Reveal(
            controller: scrollController,
            child: const Column(
              children: [
                _Eyebrow('Pour qui'),
                SizedBox(height: ArtizenSpacing.sm),
                _Heading('Fait pour tous les métiers du bâtiment.'),
                SizedBox(height: ArtizenSpacing.sm),
                _Lead('Que vous travailliez seul ou en équipe, ARTIZEN s’adapte à votre '
                    'métier et à vos prestations.'),
              ],
            ),
          ),
          const SizedBox(height: ArtizenSpacing.xl),
          _Reveal(
            controller: scrollController,
            child: Wrap(
              spacing: ArtizenSpacing.sm,
              runSpacing: ArtizenSpacing.sm,
              alignment: WrapAlignment.center,
              children: [for (final m in _metiers) _MetierChip(metier: m)],
            ),
          ),
        ],
      ),
    );
  }
}

class _Metier {
  const _Metier(this.icon, this.label);
  final IconData icon;
  final String label;
}

class _MetierChip extends StatelessWidget {
  const _MetierChip({required this.metier});

  final _Metier metier;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: ArtizenSpacing.sm,
        vertical: ArtizenSpacing.xs + 2,
      ),
      constraints: const BoxConstraints(minHeight: 48),
      decoration: BoxDecoration(
        color: ArtizenColors.surfaceLight,
        borderRadius: BorderRadius.circular(ArtizenRadii.pill),
        border: Border.all(color: ArtizenColors.border),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(metier.icon, color: ArtizenColors.gold, size: 20),
          const SizedBox(width: ArtizenSpacing.xs),
          Text(
            metier.label,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: ArtizenColors.nightBlue,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// 8. FAQ
// ---------------------------------------------------------------------------

class _FaqSection extends StatelessWidget {
  const _FaqSection({required this.scrollController});

  final ScrollController scrollController;

  static const List<_Faq> _faqs = [
    _Faq('ARTIZEN, c’est gratuit ?',
        'Pendant la bêta privée, l’accès est gratuit pour les artisans invités. '
        'Vous testez tout, sans engagement.'),
    _Faq('Mes devis sont-ils vraiment aux normes ?',
        'Oui. ARTIZEN place automatiquement les mentions obligatoires (entreprise, '
        'SIRET, TVA, totaux HT/TVA/TTC) sur chaque devis, pour un document conforme.'),
    _Faq('Je suis auto-entrepreneur, ça marche pour moi ?',
        'Bien sûr. ARTIZEN s’adapte à votre situation, y compris la mention « TVA non '
        'applicable, art. 293 B du CGI » si vous n’êtes pas assujetti à la TVA.'),
    _Faq('Je ne suis pas doué en informatique…',
        'C’est justement pour vous qu’ARTIZEN est fait. L’application est guidée, en '
        'français simple, sans jargon. Si vous savez envoyer un SMS, vous saurez faire un devis.'),
    _Faq('Ça marche sur mon téléphone ?',
        'Oui. ARTIZEN fonctionne sur téléphone, tablette et ordinateur, directement '
        'dans le navigateur — rien à installer.'),
    _Faq('Comment j’envoie le devis à mon client ?',
        'Vous téléchargez le PDF de votre devis, puis vous l’envoyez à votre client '
        'comme vous préférez (email, messagerie, impression). L’envoi intégré depuis '
        'ARTIZEN est prévu pour plus tard.'),
    _Faq('Comment je corrige un devis ?',
        'Un devis en brouillon peut être supprimé, puis recréé avec les bonnes '
        'informations. Une fois envoyé ou accepté, il reste figé — c’est ce qui garantit '
        'qu’un devis transmis ne change jamais dans votre dos.'),
    _Faq('Mes données sont-elles en sécurité ?',
        'Vos informations et celles de vos clients sont protégées et hébergées en France. '
        'Chaque entreprise ne voit que ses propres données.'),
    _Faq('Est-ce que je peux faire des factures ?',
        'Pas encore : ARTIZEN se concentre aujourd’hui sur les devis, pour bien faire une '
        'chose à la fois. La facture fait partie des prochaines étapes.'),
    _Faq('J’ai oublié mon mot de passe, que faire ?',
        'Sur l’écran de connexion, utilisez « Mot de passe oublié ? » : vous recevrez un '
        'lien par email pour en choisir un nouveau.'),
    _Faq('Comment rejoindre la bêta ?',
        'Cliquez sur « Demander un accès bêta » : cela ouvre un email pré-rempli vers notre '
        'équipe. On revient vers vous rapidement.'),
  ];

  @override
  Widget build(BuildContext context) {
    return _Section(
      background: ArtizenColors.surfaceLight,
      child: Column(
        children: [
          _Reveal(
            controller: scrollController,
            child: const Column(
              children: [
                _Eyebrow('Questions fréquentes'),
                SizedBox(height: ArtizenSpacing.sm),
                _Heading('Vos questions, nos réponses.'),
              ],
            ),
          ),
          const SizedBox(height: ArtizenSpacing.lg),
          _Reveal(
            controller: scrollController,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 820),
              child: Column(
                children: [for (final f in _faqs) _FaqItem(faq: f)],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Faq {
  const _Faq(this.question, this.answer);
  final String question;
  final String answer;
}

/// A single accessible FAQ accordion. Built on [ExpansionTile], so it exposes
/// the expand/collapse state to assistive tech out of the box.
class _FaqItem extends StatelessWidget {
  const _FaqItem({required this.faq});

  final _Faq faq;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: ArtizenSpacing.xs),
      decoration: BoxDecoration(
        color: ArtizenColors.cardSurface,
        borderRadius: BorderRadius.circular(ArtizenRadii.card),
        border: Border.all(color: ArtizenColors.border),
      ),
      child: Theme(
        // Remove the default ExpansionTile dividers; keep our own card border.
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          shape: const Border(),
          collapsedShape: const Border(),
          iconColor: ArtizenColors.gold,
          collapsedIconColor: ArtizenColors.nightBlue,
          childrenPadding: const EdgeInsets.fromLTRB(
            ArtizenSpacing.md, 0, ArtizenSpacing.md, ArtizenSpacing.md),
          expandedCrossAxisAlignment: CrossAxisAlignment.start,
          tilePadding: const EdgeInsets.symmetric(
            horizontal: ArtizenSpacing.md,
            vertical: ArtizenSpacing.xs,
          ),
          title: Text(
            faq.question,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: ArtizenColors.nightBlue,
            ),
          ),
          children: [
            Text(
              faq.answer,
              style: const TextStyle(
                fontSize: 15,
                height: 1.55,
                color: ArtizenColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// 9. Bêta privée
// ---------------------------------------------------------------------------

class _BetaSection extends StatelessWidget {
  const _BetaSection({required this.scrollController, required this.onRequestBeta});

  final ScrollController scrollController;
  final VoidCallback onRequestBeta;

  static const List<_Point> _points = [
    _Point(Icons.groups_2_outlined, 'Pourquoi seulement quelques artisans ?',
        'On veut des retours de qualité. En avançant avec un petit groupe, on améliore '
        'ARTIZEN avec vous, sur du concret.'),
    _Point(Icons.mail_outline, 'Comment participer ?',
        'Demandez un accès : un simple email suffit. On vous recontacte et on vous '
        'ouvre les portes.'),
    _Point(Icons.card_giftcard_outlined, 'Que gagne le bêta-testeur ?',
        'Un accès gratuit et en avant-première, une influence directe sur le produit, '
        'et un accompagnement personnalisé.'),
  ];

  @override
  Widget build(BuildContext context) {
    return _Section(
      background: ArtizenColors.nightBlue,
      child: Column(
        children: [
          _Reveal(
            controller: scrollController,
            child: const Column(
              children: [
                _Eyebrow('Bêta privée', onDark: true),
                SizedBox(height: ArtizenSpacing.sm),
                _Heading('Rejoignez les premiers artisans.', onDark: true),
                SizedBox(height: ArtizenSpacing.md),
                _Lead(
                  'ARTIZEN est en bêta privée : quelques artisans, beaucoup d’attention. '
                  'C’est le meilleur moment pour peser sur le produit que vous utiliserez demain.',
                  onDark: true,
                ),
              ],
            ),
          ),
          const SizedBox(height: ArtizenSpacing.xl),
          _Reveal(
            controller: scrollController,
            child: _ResponsiveGrid(
              desktopColumns: 3,
              children: [for (final p in _points) _PillarCard(point: p)],
            ),
          ),
          const SizedBox(height: ArtizenSpacing.xl),
          _Reveal(
            controller: scrollController,
            child: _PrimaryCta(label: 'Demander un accès bêta', onPressed: onRequestBeta),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// 10. CTA final + footer
// ---------------------------------------------------------------------------

class _FinalCtaSection extends StatelessWidget {
  const _FinalCtaSection({required this.onRequestBeta});

  final VoidCallback onRequestBeta;

  @override
  Widget build(BuildContext context) {
    return _Section(
      background: Colors.white,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          horizontal: ArtizenSpacing.lg,
          vertical: ArtizenSpacing.xl,
        ),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [ArtizenColors.nightBlue, ArtizenColors.blueSecondary],
          ),
          borderRadius: BorderRadius.circular(ArtizenRadii.card + 8),
          border: Border.all(color: ArtizenColors.gold.withValues(alpha: 0.4)),
        ),
        child: Column(
          children: [
            const _Heading(
              'Votre prochain devis peut être prêt en 5 minutes.',
              onDark: true,
              maxWidth: 720,
            ),
            const SizedBox(height: ArtizenSpacing.md),
            const _Lead(
              'Rejoignez la bêta et reprenez du temps sur la paperasse, dès aujourd’hui.',
              onDark: true,
            ),
            const SizedBox(height: ArtizenSpacing.lg),
            _PrimaryCta(label: 'Demander un accès bêta', onPressed: onRequestBeta),
          ],
        ),
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  const _Footer({required this.onLogin});

  final VoidCallback onLogin;

  void _comingSoon(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Bientôt disponible.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: ArtizenColors.nightBlue,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: _Bp.maxContent),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: ArtizenSpacing.md,
              vertical: ArtizenSpacing.lg,
            ),
            child: Column(
              children: [
                const _Wordmark(),
                const SizedBox(height: ArtizenSpacing.sm),
                Wrap(
                  alignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: ArtizenSpacing.xs,
                  children: [
                    _FooterLink('Connexion', onLogin),
                    const _FooterDot(),
                    _FooterLink('Mentions légales', () => _comingSoon(context)),
                    const _FooterDot(),
                    _FooterLink('CGU', () => _comingSoon(context)),
                    const _FooterDot(),
                    _FooterLink('Confidentialité', () => _comingSoon(context)),
                  ],
                ),
                const SizedBox(height: ArtizenSpacing.sm),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.shield_outlined,
                      size: 16,
                      color: ArtizenColors.onNightBlue.withValues(alpha: 0.7),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'Hébergé en France',
                      style: TextStyle(
                        fontSize: 13,
                        color: ArtizenColors.onNightBlue.withValues(alpha: 0.7),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: ArtizenSpacing.xs),
                Text(
                  '© 2026 ARTIZEN — L’assistant administratif des artisans du bâtiment.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: ArtizenColors.onNightBlue.withValues(alpha: 0.55),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _FooterLink extends StatelessWidget {
  const _FooterLink(this.label, this.onPressed);

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: ArtizenColors.onNightBlue,
        minimumSize: const Size(0, 48),
        padding: const EdgeInsets.symmetric(horizontal: ArtizenSpacing.xs),
      ),
      child: Text(label, style: const TextStyle(fontSize: 13)),
    );
  }
}

class _FooterDot extends StatelessWidget {
  const _FooterDot();

  @override
  Widget build(BuildContext context) {
    return Text(
      '•',
      style: TextStyle(color: ArtizenColors.onNightBlue.withValues(alpha: 0.4)),
    );
  }
}

// ---------------------------------------------------------------------------
// Shared responsive grid
// ---------------------------------------------------------------------------

/// A simple responsive card grid: 1 column on mobile, 2 on tablet, and
/// [desktopColumns] (default 2, or 3 for triads) on desktop. Rows keep equal
/// height via [IntrinsicHeight] so cards line up cleanly.
class _ResponsiveGrid extends StatelessWidget {
  const _ResponsiveGrid({required this.children, this.desktopColumns = 2});

  final List<Widget> children;
  final int desktopColumns;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final w = constraints.maxWidth;
        final columns = _Bp.isMobile(w)
            ? 1
            : _Bp.isTablet(w)
                ? 2
                : desktopColumns;
        const gap = ArtizenSpacing.md;

        final rows = <Widget>[];
        for (var i = 0; i < children.length; i += columns) {
          final rowItems = <Widget>[];
          for (var c = 0; c < columns; c++) {
            final index = i + c;
            if (c > 0) rowItems.add(const SizedBox(width: gap));
            rowItems.add(
              Expanded(
                child: index < children.length ? children[index] : const SizedBox.shrink(),
              ),
            );
          }
          if (rows.isNotEmpty) rows.add(const SizedBox(height: gap));
          rows.add(
            IntrinsicHeight(
              child: Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: rowItems),
            ),
          );
        }
        return Column(children: rows);
      },
    );
  }
}
