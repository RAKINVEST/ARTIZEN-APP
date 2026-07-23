import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/api/api_exception.dart';
import '../../../core/theme/app_theme.dart';
import 'auth_providers.dart';

/// The ARTIZEN premium sign-in — a dark, living page whose whole job is a brand
/// promise, not a feature list: **ARTIZEN ne fabrique pas des devis, il restitue
/// l'identité de chaque artisan.** A single full-width demonstration (mon ancien
/// devis → ARTIZEN analyse → mon nouveau modèle, à l'identique) sits beside a
/// glass sign-in card. One shared animation drives the demo *and* lights the
/// "A" of the wordmark as the identity is recovered. Auth behaviour is
/// unchanged — only the look.
class _Lux {
  static const nightBlue = Color(0xFF0A0B2E);
  static const deepBlue = Color(0xFF151845);
  static const violet = Color(0xFF6C2BFF);
  static const violetLight = Color(0xFF8E5CFF);
  static const gold = Color(0xFFF6B73C);
  static const goldLight = Color(0xFFFFD56B);
  static const success = Color(0xFF21C55D);
  static const error = Color(0xFFEF4444);
  static const textDim = Color(0xFFB6B9E0);

  static const heroTitle = [violetLight, gold];
  static const button = [violet, violetLight, gold];
}

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _pointer = ValueNotifier<Offset>(Offset.zero);
  late final List<_Star> _stars = _buildStars();

  // One micro-loop (~3.6 s, à la Apple/Stripe/Linear) drives both the demo and
  // the wordmark's glow, so they stay perfectly in sync.
  late final AnimationController _demo = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 3600),
  )..repeat();

  bool _loading = false;
  String? _error;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _pointer.dispose();
    _demo.dispose();
    super.dispose();
  }

  static List<_Star> _buildStars() {
    final rng = math.Random(42);
    return List.generate(64, (_) {
      return _Star(
        Offset(rng.nextDouble(), rng.nextDouble()),
        rng.nextDouble() * 1.1 + 0.5,
        rng.nextDouble() * 0.35 + 0.08,
        rng.nextDouble() * 26 + 6, // parallax depth
      );
    });
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      await ref.read(authNotifierProvider.notifier).login(
            email: _email.text.trim(),
            password: _password.text,
          );
      if (mounted) context.go('/dashboard');
    } catch (error) {
      setState(() => _error =
          error is ApiException ? error.displayMessage : 'Échec de la connexion.');
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final wide = size.width >= 960;

    final card = _LoginCard(
      formKey: _formKey,
      email: _email,
      password: _password,
      loading: _loading,
      error: _error,
      onSubmit: _submit,
      onForgot: () => context.go('/forgot-password'),
      onRegister: () => context.go('/register'),
    );

    return Scaffold(
      backgroundColor: _Lux.nightBlue,
      body: MouseRegion(
        onHover: (event) {
          final s = MediaQuery.sizeOf(context);
          _pointer.value = Offset(
            (event.position.dx / s.width - 0.5) * 2,
            (event.position.dy / s.height - 0.5) * 2,
          );
        },
        child: Stack(
          fit: StackFit.expand,
          children: [
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment(-0.6, -0.8),
                  radius: 1.6,
                  colors: [_Lux.deepBlue, _Lux.nightBlue],
                ),
              ),
            ),
            ValueListenableBuilder<Offset>(
              valueListenable: _pointer,
              builder: (_, pointer, _) => CustomPaint(
                painter: _LivingBackgroundPainter(stars: _stars, pointer: pointer),
              ),
            ),
            SafeArea(
              child: wide
                  ? _WideLayout(hero: _Hero(pulse: _demo), card: card)
                  : _NarrowLayout(card: card, pulse: _demo),
            ),
          ],
        ),
      ),
    );
  }
}

// --------------------------------------------------------------------- layouts
class _WideLayout extends StatelessWidget {
  const _WideLayout({required this.hero, required this.card});

  final Widget hero;
  final Widget card;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(44),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1260),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(flex: 7, child: _Appear(child: hero)),
              const SizedBox(width: 48),
              SizedBox(width: 400, child: _Appear(delayMs: 120, child: card)),
            ],
          ),
        ),
      ),
    );
  }
}

class _NarrowLayout extends StatelessWidget {
  const _NarrowLayout({required this.card, required this.pulse});

  final Widget card;
  final Animation<double> pulse;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 28, 20, 32),
      child: Column(
        children: [
          _BrandMark(pulse: pulse),
          const SizedBox(height: 24),
          _Appear(child: card),
          const SizedBox(height: 30),
          _Appear(delayMs: 120, child: _TransformDemo(progress: pulse)),
        ],
      ),
    );
  }
}

// ------------------------------------------------------------------------ hero
class _Hero extends StatelessWidget {
  const _Hero({required this.pulse});

  final Animation<double> pulse;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        _BrandMark(pulse: pulse),
        const SizedBox(height: 30),
        // Three impacts, no explanation.
        const Text(
          'Vos devis.',
          style: TextStyle(
            color: Colors.white,
            fontSize: 44,
            fontWeight: FontWeight.w800,
            height: 1.05,
            letterSpacing: -0.5,
          ),
        ),
        _GradientText(
          'Votre identité.',
          colors: _Lux.heroTitle,
          fontSize: 44,
          fontWeight: FontWeight.w800,
        ),
        const SizedBox(height: 20),
        // The emotional core — an artisan doesn't sell a PDF, he leaves an
        // impression. The devis is often the first contact with his company.
        const Text(
          'Chaque devis laisse une empreinte.',
          style: TextStyle(
            color: Colors.white,
            fontSize: 21,
            fontWeight: FontWeight.w700,
            height: 1.25,
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'ARTIZEN restitue la vôtre.',
          style: TextStyle(
            color: _Lux.goldLight,
            fontSize: 21,
            fontWeight: FontWeight.w800,
            height: 1.25,
          ),
        ),
        const SizedBox(height: 28),
        _TransformDemo(progress: pulse),
        const SizedBox(height: 22),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 560),
          child: const Text(
            "Importez votre ancien devis PDF. En quelques secondes, ARTIZEN "
            "retrouve votre logo, vos couleurs, votre mise en page et votre "
            "façon de présenter votre savoir-faire.",
            style: TextStyle(color: _Lux.textDim, fontSize: 15, height: 1.55),
          ),
        ),
        const SizedBox(height: 24),
        const _StatChips(),
      ],
    );
  }
}

/// The wordmark, with the brand signature and a living detail: the **A** lights
/// up (gold, glowing) as [pulse] runs through the detection window — as if the
/// software were rebuilding the artisan's identity, letter by letter.
class _BrandMark extends StatelessWidget {
  const _BrandMark({this.pulse});

  final Animation<double>? pulse;

  static const _wordmark = TextStyle(
    fontFamily: AppTheme.displayFontFamily,
    color: Colors.white,
    fontSize: 30,
    fontWeight: FontWeight.w700,
    letterSpacing: 5,
  );

  @override
  Widget build(BuildContext context) {
    final p = pulse;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [_Lux.gold, _Lux.goldLight]),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: _Lux.gold.withValues(alpha: 0.4),
                    blurRadius: 22,
                    spreadRadius: -4,
                  ),
                ],
              ),
              child: const Icon(Icons.handyman, color: _Lux.nightBlue, size: 26),
            ),
            const SizedBox(width: 14),
            // Base wordmark stays a single 'ARTIZEN' Text; a gold 'A' fades in on
            // top of its first glyph (same font/size, left-aligned → aligned).
            Stack(
              alignment: Alignment.centerLeft,
              children: [
                const Text('ARTIZEN', style: _wordmark),
                if (p != null)
                  AnimatedBuilder(
                    animation: p,
                    builder: (context, _) {
                      final g = ((p.value - 0.08) / 0.55).clamp(0.0, 1.0);
                      return Opacity(
                        opacity: g,
                        child: Text(
                          'A',
                          style: _wordmark.copyWith(
                            color: _Lux.goldLight,
                            shadows: [
                              Shadow(
                                color: _Lux.gold.withValues(alpha: 0.85),
                                blurRadius: 4 + 16 * g,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 8),
        // The brand signature — a line meant to stick.
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(width: 22, height: 1.4, color: _Lux.gold),
            const Flexible(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  "MARQUEZ L'ESPRIT.",
                  maxLines: 1,
                  softWrap: false,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: _Lux.gold,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 3,
                  ),
                ),
              ),
            ),
            Container(width: 22, height: 1.4, color: _Lux.gold),
          ],
        ),
      ],
    );
  }
}

// ----------------------------------------------- the transformation demo (WOW)
/// One full-width demonstration — the whole promise in ~3.6 s:
/// *mon ancien devis → ARTIZEN analyse → mon nouveau modèle, à l'identique.*
/// Left-to-right on purpose: the Western eye reads *avant → après* instantly.
/// Driven by the shared [progress] so it owns no controller of its own.
class _TransformDemo extends StatelessWidget {
  const _TransformDemo({required this.progress});

  final Animation<double> progress;

  static const _checks = ['Logo', 'Tableau', 'TVA', 'Police', 'Couleurs'];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 620) {
          // A bounded height lets `stretch` give equal-height panels cheaply.
          return SizedBox(
            height: 210,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(child: _oldDevis()),
                _arrow(horizontal: true),
                Expanded(child: _analyse()),
                _arrow(horizontal: true),
                Expanded(child: _newModel()),
              ],
            ),
          );
        }
        return Column(
          children: [
            _oldDevis(),
            _arrow(horizontal: false),
            _analyse(),
            _arrow(horizontal: false),
            _newModel(),
          ],
        );
      },
    );
  }

  Widget _arrow({required bool horizontal}) => Padding(
        padding: EdgeInsets.symmetric(
          horizontal: horizontal ? 8 : 0,
          vertical: horizontal ? 0 : 6,
        ),
        child: Center(
          child: Icon(
            horizontal ? Icons.arrow_forward_rounded : Icons.arrow_downward_rounded,
            color: _Lux.violetLight,
            size: 22,
          ),
        ),
      );

  Widget _panel({
    required Widget child,
    Color? fill,
    Color? border,
    List<BoxShadow>? shadow,
  }) =>
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: fill ?? Colors.white.withValues(alpha: 0.04),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: border ?? Colors.white.withValues(alpha: 0.10)),
          boxShadow: shadow,
        ),
        child: child,
      );

  Widget _stageLabel(String text, Color color) => Text(
        text,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.w800,
          letterSpacing: 1.2,
        ),
      );

  Widget _bar(double widthFactor, {Color? color}) => Padding(
        padding: const EdgeInsets.only(top: 8),
        child: FractionallySizedBox(
          alignment: Alignment.centerLeft,
          widthFactor: widthFactor,
          child: Container(
            height: 7,
            decoration: BoxDecoration(
              color: color ?? Colors.white.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
      );

  Widget _oldDevis() => _panel(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _stageLabel('MON ANCIEN DEVIS', _Lux.textDim),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(Icons.picture_as_pdf_outlined,
                    color: Colors.white.withValues(alpha: 0.55), size: 20),
                const SizedBox(width: 8),
                const Flexible(
                  child: Text(
                    'devis.pdf',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.white70, fontWeight: FontWeight.w700, fontSize: 14),
                  ),
                ),
              ],
            ),
            _bar(0.95),
            _bar(0.8),
            _bar(0.88),
            _bar(0.6),
          ],
        ),
      );

  Widget _analyse() => AnimatedBuilder(
        animation: progress,
        builder: (context, _) {
          final revealed =
              ((progress.value - 0.10) / 0.5).clamp(0.0, 1.0) * _checks.length;
          final done = revealed >= _checks.length;
          return _panel(
            border: _Lux.violet.withValues(alpha: 0.5),
            shadow: [
              BoxShadow(
                color: _Lux.violet.withValues(alpha: 0.22),
                blurRadius: 30,
                spreadRadius: -12,
              ),
            ],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    if (done)
                      const Icon(Icons.check_circle, color: _Lux.success, size: 16)
                    else
                      SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: const AlwaysStoppedAnimation(_Lux.violetLight),
                          backgroundColor: Colors.white.withValues(alpha: 0.12),
                        ),
                      ),
                    const SizedBox(width: 8),
                    Flexible(child: _stageLabel('ARTIZEN ANALYSE', _Lux.violetLight)),
                  ],
                ),
                const SizedBox(height: 6),
                for (var i = 0; i < _checks.length; i++)
                  _check(_checks[i], (revealed - i).clamp(0.0, 1.0)),
              ],
            ),
          );
        },
      );

  Widget _check(String label, double t) {
    if (t <= 0) return const SizedBox(height: 24);
    return Opacity(
      opacity: t,
      child: Transform.translate(
        offset: Offset(0, (1 - t) * 6),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 3),
          child: Row(
            children: [
              const Icon(Icons.check_circle, color: _Lux.success, size: 15),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.white, fontSize: 13),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _newModel() => AnimatedBuilder(
        animation: progress,
        builder: (context, _) {
          final t = ((progress.value - 0.62) / 0.18).clamp(0.0, 1.0);
          return Opacity(
            opacity: t,
            child: Transform.scale(
              scale: 0.92 + 0.08 * t,
              child: _panel(
                fill: _Lux.violet.withValues(alpha: 0.10),
                border: _Lux.gold.withValues(alpha: 0.55),
                shadow: [
                  BoxShadow(
                    color: _Lux.gold.withValues(alpha: 0.25),
                    blurRadius: 30,
                    spreadRadius: -8,
                  ),
                ],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _stageLabel('VOTRE NOUVEAU MODÈLE', _Lux.goldLight),
                    const SizedBox(height: 12),
                    Container(
                      height: 14,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(colors: [_Lux.gold, _Lux.goldLight]),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    _bar(0.9, color: _Lux.violetLight.withValues(alpha: 0.5)),
                    _bar(0.72, color: Colors.white.withValues(alpha: 0.25)),
                    const SizedBox(height: 12),
                    const Row(
                      children: [
                        Icon(Icons.auto_awesome, color: _Lux.gold, size: 15),
                        SizedBox(width: 8),
                        Flexible(
                          child: Text(
                            "Votre signature, retrouvée",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: _Lux.goldLight,
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
}

class _StatChips extends StatelessWidget {
  const _StatChips();

  @override
  Widget build(BuildContext context) {
    const chips = [
      _StatChip(icon: Icons.fingerprint, value: 'Votre', label: 'identité', hint: 'dans chaque devis', accent: _Lux.gold),
      _StatChip(icon: Icons.task_alt, value: '100%', label: 'à votre image', hint: 'logo, couleurs, mise en page', accent: _Lux.violetLight),
      _StatChip(icon: Icons.bolt, value: 'Quelques', label: 'secondes', hint: "à l'import, une seule fois", accent: _Lux.goldLight),
      _StatChip(icon: Icons.shield_outlined, value: 'Sécurisé', label: 'vos données', hint: 'protégées', accent: _Lux.success),
    ];
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        for (final c in chips)
          ConstrainedBox(constraints: const BoxConstraints(minWidth: 150), child: c),
      ],
    );
  }
}

class _StatChip extends StatelessWidget {
  const _StatChip({
    required this.icon,
    required this.value,
    required this.label,
    required this.hint,
    required this.accent,
  });

  final IconData icon;
  final String value;
  final String label;
  final String hint;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.035),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: accent, size: 20),
          const SizedBox(height: 8),
          Text(value, style: const TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w800)),
          Text(label, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600)),
          Text(hint, style: const TextStyle(color: _Lux.textDim, fontSize: 11)),
        ],
      ),
    );
  }
}

// ------------------------------------------------------------- glass login card
class _LoginCard extends StatefulWidget {
  const _LoginCard({
    required this.formKey,
    required this.email,
    required this.password,
    required this.loading,
    required this.error,
    required this.onSubmit,
    required this.onForgot,
    required this.onRegister,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController email;
  final TextEditingController password;
  final bool loading;
  final String? error;
  final Future<void> Function() onSubmit;
  final VoidCallback onForgot;
  final VoidCallback onRegister;

  @override
  State<_LoginCard> createState() => _LoginCardState();
}

class _LoginCardState extends State<_LoginCard> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(28),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
        child: Container(
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white.withValues(alpha: 0.10),
                Colors.white.withValues(alpha: 0.04),
              ],
            ),
            border: Border.all(color: Colors.white.withValues(alpha: 0.16)),
            boxShadow: [
              BoxShadow(
                color: _Lux.violet.withValues(alpha: 0.28),
                blurRadius: 44,
                spreadRadius: -10,
              ),
            ],
          ),
          child: Form(
            key: widget.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Container(
                    width: 62,
                    height: 62,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: _Lux.violetLight.withValues(alpha: 0.6), width: 2),
                      color: _Lux.violet.withValues(alpha: 0.14),
                    ),
                    child: const Icon(Icons.groups_outlined, color: _Lux.violetLight, size: 30),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Bon retour dans votre atelier.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Prêt à créer un devis qui vous ressemble ?',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: _Lux.textDim, fontSize: 14),
                ),
                const SizedBox(height: 24),
                _fieldLabel('Email'),
                _DarkField(
                  controller: widget.email,
                  hint: 'votre@email.fr',
                  icon: Icons.mail_outline,
                  keyboardType: TextInputType.emailAddress,
                  autofillHints: const [AutofillHints.email],
                  textInputAction: TextInputAction.next,
                  validator: (v) =>
                      (v == null || v.trim().isEmpty) ? "L'email est requis" : null,
                ),
                const SizedBox(height: 16),
                _fieldLabel('Mot de passe'),
                _DarkField(
                  controller: widget.password,
                  hint: 'Votre mot de passe',
                  icon: Icons.lock_outline,
                  obscure: _obscure,
                  autofillHints: const [AutofillHints.password],
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (_) => widget.onSubmit(),
                  suffix: IconButton(
                    icon: Icon(
                      _obscure ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                      color: _Lux.textDim,
                      size: 20,
                    ),
                    onPressed: () => setState(() => _obscure = !_obscure),
                  ),
                  validator: (v) =>
                      (v == null || v.isEmpty) ? 'Le mot de passe est requis' : null,
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: widget.loading ? null : widget.onForgot,
                    child: const Text('Mot de passe oublié ?',
                        style: TextStyle(color: _Lux.violetLight, fontWeight: FontWeight.w600)),
                  ),
                ),
                if (widget.error != null) ...[
                  const SizedBox(height: 6),
                  Text(
                    widget.error!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: _Lux.error, fontSize: 13),
                  ),
                ],
                const SizedBox(height: 12),
                _GradientButton(
                  label: 'Entrer dans mon atelier',
                  icon: Icons.login,
                  loading: widget.loading,
                  onPressed: widget.onSubmit,
                ),
                const SizedBox(height: 18),
                Row(
                  children: [
                    Expanded(child: Divider(color: Colors.white.withValues(alpha: 0.14))),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Text('ou', style: TextStyle(color: _Lux.textDim)),
                    ),
                    Expanded(child: Divider(color: Colors.white.withValues(alpha: 0.14))),
                  ],
                ),
                const SizedBox(height: 14),
                OutlinedButton.icon(
                  onPressed: widget.loading ? null : widget.onRegister,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    side: BorderSide(color: Colors.white.withValues(alpha: 0.22)),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  icon: const Icon(Icons.person_add_alt, size: 20),
                  label: const Text('Créer un compte', style: TextStyle(fontWeight: FontWeight.w700)),
                ),
                const SizedBox(height: 20),
                const _TrustRow(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _fieldLabel(String text) => Padding(
        padding: const EdgeInsets.only(bottom: 8, left: 2),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            text,
            style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w700),
          ),
        ),
      );
}

class _TrustRow extends StatelessWidget {
  const _TrustRow();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(child: _TrustItem(icon: Icons.shield_outlined, title: 'Sécurisé', hint: 'Données protégées')),
        Expanded(child: _TrustItem(icon: Icons.bolt, title: 'Rapide', hint: 'Au quotidien')),
        Expanded(child: _TrustItem(icon: Icons.thumb_up_outlined, title: 'Simple', hint: 'Prise en main')),
      ],
    );
  }
}

class _TrustItem extends StatelessWidget {
  const _TrustItem({required this.icon, required this.title, required this.hint});

  final IconData icon;
  final String title;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: _Lux.violetLight, size: 20),
        const SizedBox(height: 6),
        Text(title, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w700)),
        Text(hint, textAlign: TextAlign.center, style: const TextStyle(color: _Lux.textDim, fontSize: 10.5)),
      ],
    );
  }
}

class _DarkField extends StatelessWidget {
  const _DarkField({
    required this.controller,
    required this.hint,
    required this.icon,
    required this.validator,
    this.obscure = false,
    this.keyboardType,
    this.autofillHints,
    this.textInputAction,
    this.onFieldSubmitted,
    this.suffix,
  });

  final TextEditingController controller;
  final String hint;
  final IconData icon;
  final String? Function(String?) validator;
  final bool obscure;
  final TextInputType? keyboardType;
  final Iterable<String>? autofillHints;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onFieldSubmitted;
  final Widget? suffix;

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder border(Color color, [double width = 1]) => OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: color, width: width),
        );
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      keyboardType: keyboardType,
      autofillHints: autofillHints,
      textInputAction: textInputAction,
      onFieldSubmitted: onFieldSubmitted,
      validator: validator,
      style: const TextStyle(color: Colors.white, fontSize: 15),
      cursorColor: _Lux.violetLight,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: _Lux.textDim.withValues(alpha: 0.7)),
        prefixIcon: Icon(icon, color: _Lux.violetLight, size: 20),
        suffixIcon: suffix,
        filled: true,
        fillColor: Colors.white.withValues(alpha: 0.05),
        enabledBorder: border(Colors.white.withValues(alpha: 0.12)),
        focusedBorder: border(_Lux.violetLight, 1.6),
        errorBorder: border(_Lux.error),
        focusedErrorBorder: border(_Lux.error, 1.6),
        errorStyle: const TextStyle(color: _Lux.error),
        contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      ),
    );
  }
}

class _GradientButton extends StatelessWidget {
  const _GradientButton({
    required this.label,
    required this.icon,
    required this.loading,
    required this.onPressed,
  });

  final String label;
  final IconData icon;
  final bool loading;
  final Future<void> Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: _Lux.button),
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: _Lux.violet.withValues(alpha: 0.45),
            blurRadius: 24,
            spreadRadius: -6,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: loading ? null : () => onPressed(),
          child: SizedBox(
            height: 54,
            child: Center(
              child: loading
                  ? const SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.4,
                        valueColor: AlwaysStoppedAnimation(Colors.white),
                      ),
                    )
                  : Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(icon, color: Colors.white, size: 20),
                        const SizedBox(width: 10),
                        Flexible(
                          child: Text(
                            label,
                            maxLines: 1,
                            softWrap: false,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                            ),
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

// --------------------------------------------------------------------- helpers
class _GradientText extends StatelessWidget {
  const _GradientText(
    this.text, {
    required this.colors,
    required this.fontSize,
    required this.fontWeight,
  });

  final String text;
  final List<Color> colors;
  final double fontSize;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => LinearGradient(colors: colors).createShader(bounds),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: fontSize,
          fontWeight: fontWeight,
          height: 1.05,
          letterSpacing: -0.5,
        ),
      ),
    );
  }
}

/// A one-shot fade + slide-up entrance, optionally delayed — the cascade effect.
class _Appear extends StatefulWidget {
  const _Appear({required this.child, this.delayMs = 0});

  final Widget child;
  final int delayMs;

  @override
  State<_Appear> createState() => _AppearState();
}

class _AppearState extends State<_Appear> with SingleTickerProviderStateMixin {
  late final AnimationController _c =
      AnimationController(vsync: this, duration: const Duration(milliseconds: 480));

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: widget.delayMs), () {
      if (mounted) _c.forward();
    });
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final curved = CurvedAnimation(parent: _c, curve: Curves.easeOutCubic);
    return AnimatedBuilder(
      animation: curved,
      builder: (context, child) => Opacity(
        opacity: curved.value,
        child: Transform.translate(offset: Offset(0, (1 - curved.value) * 18), child: child),
      ),
      child: widget.child,
    );
  }
}

class _Star {
  const _Star(this.pos, this.radius, this.alpha, this.depth);

  final Offset pos; // fractional 0..1
  final double radius;
  final double alpha;
  final double depth; // parallax amplitude in px
}

class _LivingBackgroundPainter extends CustomPainter {
  const _LivingBackgroundPainter({required this.stars, required this.pointer});

  final List<_Star> stars;
  final Offset pointer;

  @override
  void paint(Canvas canvas, Size size) {
    void halo(Offset center, Color color, double radius) {
      final paint = Paint()
        ..color = color
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 120);
      canvas.drawCircle(center, radius, paint);
    }

    halo(
      Offset(size.width * 0.18 + pointer.dx * 30, size.height * 0.22 + pointer.dy * 30),
      _Lux.violet.withValues(alpha: 0.22),
      size.shortestSide * 0.34,
    );
    halo(
      Offset(size.width * 0.30 - pointer.dx * 22, size.height * 0.72 - pointer.dy * 22),
      _Lux.gold.withValues(alpha: 0.10),
      size.shortestSide * 0.26,
    );

    final dot = Paint()..color = Colors.white;
    for (final star in stars) {
      dot.color = Colors.white.withValues(alpha: star.alpha);
      canvas.drawCircle(
        Offset(
          star.pos.dx * size.width + pointer.dx * star.depth,
          star.pos.dy * size.height + pointer.dy * star.depth,
        ),
        star.radius,
        dot,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _LivingBackgroundPainter old) => old.pointer != pointer;
}
