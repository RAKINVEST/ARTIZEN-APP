import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/api/api_exception.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/app_components.dart';
import 'auth_providers.dart';

/// The login screen, built to the ARTIZEN premium reference: a night-blue
/// banner with a gold-filet curve and the brand mark, then the sign-in form
/// on the light surface. Behaviour is unchanged — only the look.
class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _loading = false;
  String? _error;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
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
      setState(() => _error = error is ApiException ? error.displayMessage : 'Échec de la connexion.');
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ArtizenColors.surfaceLight,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const _BrandBanner(),
            const SizedBox(height: ArtizenSpacing.lg),
            Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 440),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                    ArtizenSpacing.md, 0, ArtizenSpacing.md, ArtizenSpacing.lg),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text(
                          'Bienvenue !',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            color: ArtizenColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: ArtizenSpacing.xs),
                        const Text(
                          'Connectez-vous à votre compte',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 14, color: ArtizenColors.textSecondary),
                        ),
                        const SizedBox(height: ArtizenSpacing.lg),
                        AppTextField(
                          label: 'Email',
                          controller: _email,
                          hintText: 'Votre email',
                          icon: Icons.mail_outline,
                          keyboardType: TextInputType.emailAddress,
                          autofillHints: const [AutofillHints.email],
                          textInputAction: TextInputAction.next,
                          validator: (value) =>
                              (value == null || value.trim().isEmpty) ? 'L\'email est requis' : null,
                        ),
                        const SizedBox(height: ArtizenSpacing.sm),
                        AppTextField(
                          label: 'Mot de passe',
                          controller: _password,
                          hintText: 'Votre mot de passe',
                          icon: Icons.lock_outline,
                          obscure: true,
                          autofillHints: const [AutofillHints.password],
                          textInputAction: TextInputAction.done,
                          onFieldSubmitted: (_) => _submit(),
                          validator: (value) =>
                              (value == null || value.isEmpty) ? 'Le mot de passe est requis' : null,
                        ),
                        if (_error != null) ...[
                          const SizedBox(height: ArtizenSpacing.sm),
                          Text(
                            _error!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: ArtizenColors.error, fontSize: 13),
                          ),
                        ],
                        const SizedBox(height: ArtizenSpacing.md),
                        AppPrimaryButton(
                          label: 'Se connecter',
                          icon: Icons.login,
                          loading: _loading,
                          onPressed: _submit,
                        ),
                        const SizedBox(height: ArtizenSpacing.md),
                        const AppDivider(label: 'ou'),
                        const SizedBox(height: ArtizenSpacing.xs),
                        AppLink(
                          label: 'Créer un compte',
                          icon: Icons.person_add_alt,
                          onPressed: _loading ? null : () => context.go('/register'),
                        ),
                        const SizedBox(height: ArtizenSpacing.md),
                        const AppInfoCard(
                          icon: Icons.shield_outlined,
                          title: 'Vos données sont sécurisées',
                          description:
                              'Artizen protège vos informations et votre activité au quotidien.',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// The night-blue brand banner with a gold-filet curved bottom, the tools
/// mark and the tagline. Its curve and the avatar that overlaps it are the
/// signature of the ARTIZEN identity.
class _BrandBanner extends StatelessWidget {
  const _BrandBanner();

  @override
  Widget build(BuildContext context) {
    final topInset = MediaQuery.paddingOf(context).top;
    final bannerHeight = (MediaQuery.sizeOf(context).height * 0.32).clamp(260.0, 380.0);

    return SizedBox(
      // Room for the avatar that hangs below the curve.
      height: bannerHeight + 32,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          ClipPath(
            clipper: _BannerCurveClipper(),
            child: Container(
              height: bannerHeight,
              width: double.infinity,
              color: ArtizenColors.nightBlue,
              padding: EdgeInsets.only(top: topInset + 8, bottom: 48),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.handyman, color: ArtizenColors.gold, size: 44),
                    const SizedBox(height: ArtizenSpacing.sm),
                    // The brand wordmark: Orbitron, uppercase, widely spaced —
                    // the ENR-inspired technical mark.
                    const Text(
                      'ARTIZEN',
                      style: TextStyle(
                        fontFamily: AppTheme.displayFontFamily,
                        color: ArtizenColors.onNightBlue,
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 6,
                      ),
                    ),
                    const SizedBox(height: ArtizenSpacing.xs),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _goldDash(),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: ArtizenSpacing.xs),
                          child: Text(
                            'LE COPILOTE DES ARTISANS',
                            style: TextStyle(
                              color: ArtizenColors.gold,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 2,
                            ),
                          ),
                        ),
                        _goldDash(),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          // The gold filet tracing the curve.
          Positioned.fill(
            child: CustomPaint(painter: _BannerFiletPainter(bannerHeight)),
          ),
          // The people avatar overlapping the curve.
          Positioned(
            top: bannerHeight - 32,
            child: Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: ArtizenColors.cardSurface,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: ArtizenColors.nightBlue.withValues(alpha: 0.12),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Icon(Icons.groups_outlined, color: ArtizenColors.nightBlue, size: 30),
            ),
          ),
        ],
      ),
    );
  }

  static Widget _goldDash() =>
      Container(width: 16, height: 1.4, color: ArtizenColors.gold);
}

/// The banner's elegant concave bottom edge.
Path _bannerCurvePath(Size size) {
  const dip = 36.0;
  return Path()
    ..lineTo(0, size.height - dip)
    ..quadraticBezierTo(size.width / 2, size.height + dip * 0.6, size.width, size.height - dip)
    ..lineTo(size.width, 0)
    ..close();
}

class _BannerCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) => _bannerCurvePath(size);

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

/// Strokes the gold filet just inside the banner's curved edge.
class _BannerFiletPainter extends CustomPainter {
  const _BannerFiletPainter(this.bannerHeight);

  final double bannerHeight;

  @override
  void paint(Canvas canvas, Size size) {
    const dip = 36.0;
    final paint = Paint()
      ..color = ArtizenColors.gold
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round;
    final path = Path()
      ..moveTo(0, bannerHeight - dip)
      ..quadraticBezierTo(size.width / 2, bannerHeight + dip * 0.6, size.width, bannerHeight - dip);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _BannerFiletPainter oldDelegate) =>
      oldDelegate.bannerHeight != bannerHeight;
}
