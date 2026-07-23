import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/api/api_exception.dart';
import '../../../core/theme/app_theme.dart';
import 'auth_providers.dart';

/// The ARTIZEN premium sign-in — a dark, living two-pane page (Apple × Stripe ×
/// Linear register): an animated hero that *demonstrates* the product (a PDF is
/// analysed and rebuilt into the artisan's own model, live) beside a glass
/// sign-in card. Auth behaviour is unchanged — only the look.
///
/// Everything here is native Flutter: glass via [BackdropFilter], a living
/// background + parallax via a [CustomPainter] driven by pointer position, and
/// the detection showcase via an [AnimationController]. No web/React stack.
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

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _pointer = ValueNotifier<Offset>(Offset.zero);
  late final List<_Star> _stars = _buildStars();
  bool _loading = false;
  String? _error;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _pointer.dispose();
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
            // Living background: gradient + halos + starfield, parallax-shifted.
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
                  ? _WideLayout(hero: const _Hero(), card: card)
                  : _NarrowLayout(card: card),
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
              const Expanded(flex: 7, child: _Appear(child: _Hero())),
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
  const _NarrowLayout({required this.card});

  final Widget card;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 28, 20, 32),
      child: Column(
        children: [
          const _BrandMark(),
          const SizedBox(height: 24),
          _Appear(child: card),
          const SizedBox(height: 30),
          const _Appear(delayMs: 120, child: _DetectionShowcase()),
          const SizedBox(height: 22),
          const _StatChips(),
        ],
      ),
    );
  }
}

// ------------------------------------------------------------------------ hero
class _Hero extends StatelessWidget {
  const _Hero();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const _BrandMark(),
        const SizedBox(height: 34),
        const Text(
          'Transformez vos devis.',
          style: TextStyle(
            color: Colors.white,
            fontSize: 46,
            fontWeight: FontWeight.w800,
            height: 1.05,
            letterSpacing: -0.5,
          ),
        ),
        _GradientText(
          'Gagnez du temps.',
          colors: _Lux.heroTitle,
          fontSize: 46,
          fontWeight: FontWeight.w800,
        ),
        const SizedBox(height: 18),
        const SizedBox(
          width: 520,
          child: Text(
            'Importez votre ancien devis PDF.\n'
            'ARTIZEN le reproduit automatiquement à votre image.',
            style: TextStyle(color: _Lux.textDim, fontSize: 16, height: 1.5),
          ),
        ),
        const SizedBox(height: 22),
        const _TechPill(),
        const SizedBox(height: 26),
        const _DetectionShowcase(),
        const SizedBox(height: 22),
        const _ShowcaseCards(),
        const SizedBox(height: 22),
        const _StatChips(),
      ],
    );
  }
}

class _BrandMark extends StatelessWidget {
  const _BrandMark();

  @override
  Widget build(BuildContext context) {
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
            const Text(
              'ARTIZEN',
              style: TextStyle(
                fontFamily: AppTheme.displayFontFamily,
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.w700,
                letterSpacing: 5,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(width: 22, height: 1.4, color: _Lux.gold),
            const Flexible(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  'LE COPILOTE DES ARTISANS',
                  maxLines: 1,
                  softWrap: false,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: _Lux.gold,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 2.5,
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

class _TechPill extends StatelessWidget {
  const _TechPill();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.auto_awesome, color: _Lux.gold, size: 18),
          SizedBox(width: 10),
          Flexible(
            child: Text(
              'Vos devis. Votre style. Notre technologie.',
              maxLines: 1,
              softWrap: false,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ------------------------------------------------------ detection showcase (WOW)
class _DetectionShowcase extends StatefulWidget {
  const _DetectionShowcase();

  @override
  State<_DetectionShowcase> createState() => _DetectionShowcaseState();
}

class _DetectionShowcaseState extends State<_DetectionShowcase>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c;

  static const _steps = <(String, IconData)>[
    ('Analyse du document…', Icons.autorenew),
    ('Logo détecté', Icons.check_circle),
    ('Tableau détecté', Icons.check_circle),
    ('TVA détectée', Icons.check_circle),
    ('Police détectée', Icons.check_circle),
    ('Couleurs détectées', Icons.check_circle),
    ('Modèle ARTIZEN créé', Icons.auto_awesome),
  ];

  @override
  void initState() {
    super.initState();
    _c = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 6200),
    )..repeat();
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final n = _steps.length;
    return Container(
      width: 460,
      constraints: const BoxConstraints(maxWidth: double.infinity),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: 0.10)),
        boxShadow: [
          BoxShadow(
            color: _Lux.violet.withValues(alpha: 0.18),
            blurRadius: 34,
            spreadRadius: -12,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.picture_as_pdf_outlined, color: _Lux.gold, size: 20),
              const SizedBox(width: 10),
              const Text(
                'devis.pdf',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: _Lux.violet.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'IA ARTIZEN',
                  style: TextStyle(
                    color: _Lux.violetLight,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          const Divider(color: Colors.white24, height: 22),
          AnimatedBuilder(
            animation: _c,
            builder: (context, _) {
              // Reveal steps in cascade; the +1.4 tail holds all shown before loop.
              final progress = _c.value * (n + 1.4);
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (var i = 0; i < n; i++)
                    _stepRow(i, (progress - i).clamp(0.0, 1.0)),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _stepRow(int i, double t) {
    if (t <= 0) {
      return const SizedBox(height: 30);
    }
    final (label, icon) = _steps[i];
    final isFinal = i == _steps.length - 1;
    final isAnalyse = i == 0;
    final color = isFinal
        ? _Lux.gold
        : (isAnalyse ? _Lux.violetLight : _Lux.success);
    return Opacity(
      opacity: t,
      child: Transform.translate(
        offset: Offset(0, (1 - t) * 8),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Row(
            children: [
              if (isAnalyse)
                SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: const AlwaysStoppedAnimation(_Lux.violetLight),
                    backgroundColor: Colors.white.withValues(alpha: 0.12),
                  ),
                )
              else
                Icon(icon, color: color, size: 18),
              const SizedBox(width: 12),
              Flexible(
                child: Text(
                  label,
                  maxLines: 1,
                  softWrap: false,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: isFinal ? _Lux.gold : Colors.white,
                    fontSize: 14,
                    fontWeight: isFinal ? FontWeight.w800 : FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ----------------------------------------------------------- showcase cards (3)
class _ShowcaseCards extends StatelessWidget {
  const _ShowcaseCards();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final cards = const [
          _ShowcaseCard(
            icon: Icons.description_outlined,
            title: 'Reproduire mon devis',
            subtitle: 'Importez un PDF existant et retrouvez votre modèle en quelques secondes.',
            highlighted: true,
          ),
          _ShowcaseCard(
            icon: Icons.add,
            title: 'Nouveau devis',
            subtitle: "Créez un devis à partir d'un modèle vierge ou professionnel.",
          ),
          _ShowcaseCard(
            icon: Icons.groups_outlined,
            title: 'Mes clients',
            subtitle: 'Gérez vos clients, contacts et historiques de devis.',
          ),
        ];
        final narrow = constraints.maxWidth < 560;
        if (narrow) {
          return Column(
            children: [
              for (final c in cards) ...[c, const SizedBox(height: 12)],
            ],
          );
        }
        // IntrinsicHeight bounds the row's height (tallest card) so `stretch`
        // gives equal-height cards — without it, an unbounded vertical scroll
        // context turns `stretch` into an infinite-height constraint.
        return IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (var i = 0; i < cards.length; i++) ...[
                if (i > 0) const SizedBox(width: 14),
                Expanded(child: cards[i]),
              ],
            ],
          ),
        );
      },
    );
  }
}

class _ShowcaseCard extends StatelessWidget {
  const _ShowcaseCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.highlighted = false,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final bool highlighted;

  @override
  Widget build(BuildContext context) {
    final accent = highlighted ? _Lux.gold : _Lux.violetLight;
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: highlighted ? 0.06 : 0.035),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: highlighted
              ? _Lux.gold.withValues(alpha: 0.6)
              : Colors.white.withValues(alpha: 0.10),
          width: highlighted ? 1.5 : 1,
        ),
        boxShadow: highlighted
            ? [
                BoxShadow(
                  color: _Lux.gold.withValues(alpha: 0.28),
                  blurRadius: 30,
                  spreadRadius: -6,
                ),
              ]
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: highlighted
                    ? const [_Lux.gold, _Lux.goldLight]
                    : const [_Lux.violet, _Lux.violetLight],
              ),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: highlighted ? _Lux.nightBlue : Colors.white, size: 24),
          ),
          const SizedBox(height: 14),
          Text(
            title,
            style: TextStyle(
              color: highlighted ? _Lux.goldLight : Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            style: const TextStyle(color: _Lux.textDim, fontSize: 13, height: 1.35),
          ),
          const SizedBox(height: 14),
          Icon(Icons.arrow_forward, color: accent, size: 20),
        ],
      ),
    );
  }
}

class _StatChips extends StatelessWidget {
  const _StatChips();

  @override
  Widget build(BuildContext context) {
    const chips = [
      _StatChip(icon: Icons.bolt, value: '10x', label: 'Plus rapide', hint: 'Gagnez du temps chaque jour', accent: _Lux.gold),
      _StatChip(icon: Icons.task_alt, value: '100%', label: 'À votre image', hint: 'Reproduction fidèle', accent: _Lux.violetLight),
      _StatChip(icon: Icons.shield_outlined, value: 'Sécurisé', label: 'Vos données', hint: 'sont protégées', accent: _Lux.success),
      _StatChip(icon: Icons.mood, value: 'Simple', label: 'Prise en main', hint: 'immédiate', accent: _Lux.goldLight),
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
                  'Bienvenue !',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Connectez-vous à votre compte artisanal',
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
    // Soft halos — violet (upper-left) and gold (mid-left), parallax-shifted.
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
