import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/api/api_exception.dart';
import '../../../core/theme/app_theme.dart';
import 'auth_providers.dart';

/// The ARTIZEN premium sign-in. Its job is not to explain a feature but to make
/// the visitor *witness*, in a few seconds, the **rebirth of their own graphic
/// identity**: a real (fictional) devis is scanned and rebuilt, live, into their
/// own model. Auth behaviour is unchanged — only the experience.
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

//: The devis the demo scans and rebuilds — a name the eye can hold onto, so the
//: visitor thinks "it's rebuilding *my* devis", not an abstract shape.
const _company = 'SARL Dupont Chauffage';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _pointer = ValueNotifier<Offset>(Offset.zero);
  late final List<_Star> _stars = _buildStars();

  // The story loop (~3.6 s) drives the demo and the wordmark's "A".
  late final AnimationController _demo = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 3600),
  )..repeat();
  // A slow ambient loop (~7 s) drives the logo's breathing halo + rare shimmer.
  late final AnimationController _ambient = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 7000),
  )..repeat();

  bool _loading = false;
  String? _error;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _pointer.dispose();
    _demo.dispose();
    _ambient.dispose();
    super.dispose();
  }

  static List<_Star> _buildStars() {
    final rng = math.Random(42);
    return List.generate(64, (_) {
      return _Star(
        Offset(rng.nextDouble(), rng.nextDouble()),
        rng.nextDouble() * 1.1 + 0.5,
        rng.nextDouble() * 0.35 + 0.08,
        rng.nextDouble() * 26 + 6,
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
                  ? _WideLayout(
                      hero: _Hero(pulse: _demo, ambient: _ambient),
                      card: card,
                    )
                  : _NarrowLayout(card: card, pulse: _demo, ambient: _ambient),
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
  const _NarrowLayout({required this.card, required this.pulse, required this.ambient});

  final Widget card;
  final Animation<double> pulse;
  final Animation<double> ambient;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 28, 20, 32),
      child: Column(
        children: [
          _BrandMark(pulse: pulse, ambient: ambient),
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
  const _Hero({required this.pulse, required this.ambient});

  final Animation<double> pulse;
  final Animation<double> ambient;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        _BrandMark(pulse: pulse, ambient: ambient),
        const SizedBox(height: 30),
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
        const Text(
          'Chaque devis laisse une empreinte.',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
            height: 1.25,
          ),
        ),
        const SizedBox(height: 6),
        // THE phrase — larger, luminous. What must stay in mind.
        const Text(
          'ARTIZEN restitue la vôtre.',
          style: TextStyle(
            color: _Lux.goldLight,
            fontSize: 27,
            fontWeight: FontWeight.w800,
            height: 1.15,
            shadows: [Shadow(color: _Lux.gold, blurRadius: 22)],
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

/// The wordmark. Three living details, kept discreet: a breathing gold **halo**
/// on the mark, a rare **shimmer** sweeping the letters (~every 7 s), and the
/// **A** that lights up gold as [pulse] runs the detection — the identity being
/// recovered, letter by letter.
class _BrandMark extends StatelessWidget {
  const _BrandMark({required this.pulse, required this.ambient});

  final Animation<double> pulse;
  final Animation<double> ambient;

  static const _wordmark = TextStyle(
    fontFamily: AppTheme.displayFontFamily,
    color: Colors.white,
    fontSize: 30,
    fontWeight: FontWeight.w700,
    letterSpacing: 5,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedBuilder(
              animation: ambient,
              builder: (context, _) {
                final breath = 0.5 + 0.5 * math.sin(ambient.value * math.pi * 2);
                return Container(
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: [_Lux.gold, _Lux.goldLight]),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: _Lux.gold.withValues(alpha: 0.35 + 0.30 * breath),
                        blurRadius: 20 + 14 * breath,
                        spreadRadius: -2,
                      ),
                    ],
                  ),
                  child: const Icon(Icons.handyman, color: _Lux.nightBlue, size: 26),
                );
              },
            ),
            const SizedBox(width: 14),
            Stack(
              alignment: Alignment.centerLeft,
              children: [
                // Base wordmark + rare shimmer sheen sweeping across it.
                AnimatedBuilder(
                  animation: ambient,
                  builder: (context, _) {
                    final s = ambient.value;
                    if (s <= 0.86) return const Text('ARTIZEN', style: _wordmark);
                    final sheen = (s - 0.86) / 0.14; // 0 → 1 sweep
                    return ShaderMask(
                      blendMode: BlendMode.srcIn,
                      shaderCallback: (bounds) => LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: const [
                          Colors.white,
                          Colors.white,
                          _Lux.goldLight,
                          Colors.white,
                          Colors.white,
                        ],
                        stops: [
                          (sheen - 0.20).clamp(0.0, 1.0),
                          (sheen - 0.06).clamp(0.0, 1.0),
                          sheen.clamp(0.0, 1.0),
                          (sheen + 0.06).clamp(0.0, 1.0),
                          (sheen + 0.20).clamp(0.0, 1.0),
                        ],
                      ).createShader(bounds),
                      child: const Text('ARTIZEN', style: _wordmark),
                    );
                  },
                ),
                // The gold 'A' fading in over the first glyph.
                AnimatedBuilder(
                  animation: pulse,
                  builder: (context, _) {
                    final g = ((pulse.value - 0.05) / 0.5).clamp(0.0, 1.0);
                    if (g <= 0) return const SizedBox.shrink();
                    return Text(
                      'A',
                      style: _wordmark.copyWith(
                        color: Color.lerp(Colors.white, _Lux.goldLight, g),
                        shadows: [
                          Shadow(color: _Lux.gold.withValues(alpha: 0.9 * g), blurRadius: 6 + 22 * g),
                          Shadow(color: _Lux.goldLight.withValues(alpha: 0.5 * g), blurRadius: 2),
                        ],
                      ),
                    );
                  },
                ),
              ],
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
/// The heart of the page: a real devis (left, grey — the plain import) is
/// **scanned** (a gold beam sweeps the three panels), understood (center), and
/// **rebuilt element by element** into the artisan's own model (right). The same
/// « SARL Dupont Chauffage » appears left and right, so the visitor sees his own
/// devis reborn — not an abstract animation. ~3.6 s, then it starts again.
class _TransformDemo extends StatelessWidget {
  const _TransformDemo({required this.progress});

  final Animation<double> progress;

  static const _checks = ['Logo', 'Tableau', 'TVA', 'Police', 'Couleurs'];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 620) {
          return SizedBox(
            height: 238,
            child: AnimatedBuilder(
              animation: progress,
              builder: (context, _) {
                final v = progress.value;
                return Stack(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(child: _oldDevis()),
                        _arrow(horizontal: true),
                        Expanded(child: _analyse(v)),
                        _arrow(horizontal: true),
                        Expanded(child: _newModel(v)),
                      ],
                    ),
                    _scanBeam(constraints.maxWidth, v),
                  ],
                );
              },
            ),
          );
        }
        return AnimatedBuilder(
          animation: progress,
          builder: (context, _) {
            final v = progress.value;
            return Column(
              children: [
                _oldDevis(),
                _arrow(horizontal: false),
                _analyse(v),
                _arrow(horizontal: false),
                _newModel(v),
              ],
            );
          },
        );
      },
    );
  }

  // The gold beam sweeping left → right across all three panels.
  Widget _scanBeam(double width, double v) {
    if (v < 0.04 || v > 0.66) return const SizedBox.shrink();
    final sweep = ((v - 0.06) / 0.54).clamp(0.0, 1.0);
    final fade = v < 0.10 ? (v - 0.04) / 0.06 : (v > 0.60 ? (0.66 - v) / 0.06 : 1.0);
    return Positioned(
      left: width * sweep - 16,
      top: 0,
      bottom: 0,
      child: IgnorePointer(
        child: Opacity(
          opacity: fade.clamp(0.0, 1.0),
          child: Container(
            width: 32,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  _Lux.gold.withValues(alpha: 0.0),
                  _Lux.gold.withValues(alpha: 0.25),
                  _Lux.goldLight,
                  _Lux.gold.withValues(alpha: 0.0),
                ],
                stops: const [0.0, 0.55, 0.62, 1.0],
              ),
              boxShadow: [
                BoxShadow(color: _Lux.gold.withValues(alpha: 0.6), blurRadius: 18, spreadRadius: 1),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _arrow({required bool horizontal}) => Padding(
        padding: EdgeInsets.symmetric(horizontal: horizontal ? 8 : 0, vertical: horizontal ? 0 : 6),
        child: Center(
          child: Icon(
            horizontal ? Icons.arrow_forward_rounded : Icons.arrow_downward_rounded,
            color: _Lux.violetLight,
            size: 22,
          ),
        ),
      );

  Widget _panel({required Widget child, Color? fill, Color? border, List<BoxShadow>? shadow}) =>
      Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: fill ?? Colors.white.withValues(alpha: 0.04),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: border ?? Colors.white.withValues(alpha: 0.10)),
          boxShadow: shadow,
        ),
        child: child,
      );

  Widget _label(String text, Color color) => Text(
        text,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(color: color, fontSize: 10.5, fontWeight: FontWeight.w800, letterSpacing: 1.1),
      );

  Widget _bar(double w, {Color? color, double h = 6}) => FractionallySizedBox(
        alignment: Alignment.centerLeft,
        widthFactor: w,
        child: Container(
          height: h,
          decoration: BoxDecoration(
            color: color ?? Colors.white.withValues(alpha: 0.14),
            borderRadius: BorderRadius.circular(3),
          ),
        ),
      );

  // A schematic devis header: a small logo square + the company name.
  Widget _devisHeader({required bool premium}) => Row(
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: premium ? null : Colors.white.withValues(alpha: 0.18),
              gradient: premium ? const LinearGradient(colors: [_Lux.gold, _Lux.goldLight]) : null,
              borderRadius: BorderRadius.circular(5),
            ),
            child: premium ? const Icon(Icons.handyman, color: _Lux.nightBlue, size: 12) : null,
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              _company,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: premium ? _Lux.goldLight : Colors.white70,
                fontWeight: FontWeight.w700,
                fontSize: 11.5,
              ),
            ),
          ),
        ],
      );

  // One table line: a wide "designation" bar + a short right-aligned "price".
  Widget _tableRow(double designation, {Color? color}) => Padding(
        padding: const EdgeInsets.only(top: 7),
        child: Row(
          children: [
            Expanded(child: _bar(designation, color: color)),
            const SizedBox(width: 10),
            SizedBox(width: 34, child: _bar(1, color: color)),
          ],
        ),
      );

  Widget _oldDevis() => _panel(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _label('MON ANCIEN DEVIS', _Lux.textDim),
            const SizedBox(height: 12),
            _devisHeader(premium: false),
            const SizedBox(height: 12),
            _tableRow(0.9),
            _tableRow(0.75),
            _tableRow(0.85),
            const SizedBox(height: 10),
            Text('TVA 20 %', style: TextStyle(color: Colors.white.withValues(alpha: 0.4), fontSize: 11)),
          ],
        ),
      );

  Widget _analyse(double v) {
    final revealed = ((v - 0.10) / 0.5).clamp(0.0, 1.0) * _checks.length;
    final done = revealed >= _checks.length;
    return _panel(
      border: _Lux.violet.withValues(alpha: 0.5),
      shadow: [BoxShadow(color: _Lux.violet.withValues(alpha: 0.22), blurRadius: 30, spreadRadius: -12)],
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
              Flexible(child: _label('ARTIZEN ANALYSE', _Lux.violetLight)),
            ],
          ),
          const SizedBox(height: 8),
          for (var i = 0; i < _checks.length; i++)
            _reveal(
              (revealed - i).clamp(0.0, 1.0),
              _row(const Icon(Icons.check_circle, color: _Lux.success, size: 15), _checks[i], Colors.white),
            ),
        ],
      ),
    );
  }

  // The right panel builds element by element as [v] runs the later phase.
  Widget _newModel(double v) {
    final bp = ((v - 0.58) / 0.36).clamp(0.0, 1.0); // build progress
    const n = 6.0;
    double step(int i) => (bp * n - i).clamp(0.0, 1.0);
    final appeared = bp > 0.02;
    return _panel(
      fill: _Lux.violet.withValues(alpha: 0.10),
      border: _Lux.gold.withValues(alpha: appeared ? 0.6 : 0.2),
      shadow: appeared
          ? [BoxShadow(color: _Lux.gold.withValues(alpha: 0.28 * bp), blurRadius: 30, spreadRadius: -8)]
          : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _label('VOTRE NOUVEAU MODÈLE', _Lux.goldLight),
          const SizedBox(height: 12),
          _reveal(step(0), _devisHeader(premium: true)),
          _reveal(
            step(1),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Container(
                height: 11,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [_Lux.gold, _Lux.goldLight]),
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
          ),
          _reveal(step(2), _tableRow(0.9, color: _Lux.violetLight.withValues(alpha: 0.5))),
          _reveal(step(3), _tableRow(0.8, color: Colors.white.withValues(alpha: 0.3))),
          _reveal(
            step(4),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: _row(
                const Icon(Icons.auto_awesome, color: _Lux.gold, size: 14),
                'Votre signature, retrouvée',
                _Lux.goldLight,
                bold: true,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _row(Widget leading, String label, Color color, {bool bold = false}) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 3),
        child: Row(
          children: [
            leading,
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: color,
                  fontSize: 12.5,
                  fontWeight: bold ? FontWeight.w700 : FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      );

  // Fade + slide up as [t] goes 0 → 1; keeps its slot while hidden (stable layout).
  Widget _reveal(double t, Widget child) {
    if (t <= 0) return Opacity(opacity: 0, child: child);
    return Opacity(
      opacity: t,
      child: Transform.translate(offset: Offset(0, (1 - t) * 6), child: child),
    );
  }
}

class _StatChips extends StatelessWidget {
  const _StatChips();

  @override
  Widget build(BuildContext context) {
    const chips = [
      _StatChip(icon: Icons.fingerprint, title: 'Votre identité', sub: 'préservée', accent: _Lux.gold),
      _StatChip(icon: Icons.auto_fix_high, title: 'Votre style', sub: 'retrouvé', accent: _Lux.violetLight),
      _StatChip(icon: Icons.file_upload_outlined, title: 'Import unique', sub: 'une seule fois', accent: _Lux.goldLight),
      _StatChip(icon: Icons.shield_outlined, title: 'Vos données', sub: 'protégées', accent: _Lux.success),
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
  const _StatChip({required this.icon, required this.title, required this.sub, required this.accent});

  final IconData icon;
  final String title;
  final String sub;
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
          Text(title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w800)),
          Text(sub, style: const TextStyle(color: _Lux.textDim, fontSize: 12)),
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

  final Offset pos;
  final double radius;
  final double alpha;
  final double depth;
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
