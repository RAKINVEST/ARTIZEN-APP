import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// Surface-level building blocks of the "web" identity: the page background,
/// the white rounded cards, the pastel icon chips and the gradient FAB. A
/// screen composes these; it never re-implements the gradient or the shadow.

/// The white→lavender page background with a faint dot pattern in the top-right
/// corner. Paints behind [child] (which stays transparent so the wash shows
/// through). Used by the shell behind the tabs and by pushed routes.
class AppBackground extends StatelessWidget {
  const AppBackground({required this.child, this.showDots = true, super.key});

  final Widget child;
  final bool showDots;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: ArtizenGradients.background,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        children: [
          if (showDots)
            Positioned(
              top: 0,
              right: 0,
              child: IgnorePointer(
                child: CustomPaint(
                  size: const Size(240, 200),
                  painter: _DotPatternPainter(),
                ),
              ),
            ),
          Positioned.fill(child: child),
        ],
      ),
    );
  }
}

class _DotPatternPainter extends CustomPainter {
  static const double _gap = 22;
  static const double _radius = 2.2;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = kArtizenViolet.withValues(alpha: 0.10);
    for (double y = _gap; y < size.height; y += _gap) {
      for (double x = size.width - _gap; x > 0; x -= _gap) {
        // Fade toward the interior so the pattern hugs the corner.
        final t = (x / size.width) * (1 - y / size.height);
        if (t < 0.08) continue;
        canvas.drawCircle(Offset(x, y), _radius, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DotPatternPainter oldDelegate) => false;
}

/// A white rounded card with the design-system's soft shadow. The single
/// container look behind stat cards, list rows and form sections. Optionally
/// tappable (adds an ink ripple clipped to the radius).
class AppCard extends StatelessWidget {
  const AppCard({
    required this.child,
    this.onTap,
    this.padding = const EdgeInsets.all(ArtizenSpacing.sm),
    this.radius = 18,
    super.key,
  });

  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;
  final double radius;

  @override
  Widget build(BuildContext context) {
    final content = Padding(padding: padding, child: child);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radius),
        boxShadow: [
          BoxShadow(
            color: ArtizenColors.nightBlue.withValues(alpha: 0.06),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: onTap == null
          ? content
          : Material(
              type: MaterialType.transparency,
              child: InkWell(
                onTap: onTap,
                borderRadius: BorderRadius.circular(radius),
                child: content,
              ),
            ),
    );
  }
}

/// A pastel rounded-square holding an [icon] tinted with the accent's [fg].
/// The recurring "chip" in front of every label — dashboard tiles, quick
/// access, list leadings.
class AccentIconChip extends StatelessWidget {
  const AccentIconChip({
    required this.icon,
    required this.accent,
    this.size = 46,
    this.iconSize,
    super.key,
  });

  final IconData icon;
  final ArtizenAccent accent;
  final double size;
  final double? iconSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: accent.bg,
        borderRadius: BorderRadius.circular(size * 0.30),
      ),
      child: Icon(icon, color: accent.fg, size: iconSize ?? size * 0.48),
    );
  }
}

/// A dashboard metric: a pastel icon chip, a big [value], a [label] and a thin
/// gradient bar along the bottom, over a faint watermark of the same icon.
/// Tapping it drills into whatever the metric counts.
class StatCard extends StatelessWidget {
  const StatCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.accent,
    this.onTap,
    this.large = false,
    super.key,
  });

  final IconData icon;
  final String label;
  final String value;
  final ArtizenAccent accent;
  final VoidCallback? onTap;

  /// The two headline cards (Clients, Articles) are taller with a bigger value.
  final bool large;

  @override
  Widget build(BuildContext context) {
    const radius = 18.0;
    final body = Stack(
      children: [
        Positioned(
          right: -10,
          bottom: -6,
          child: Icon(
            icon,
            size: large ? 120 : 84,
            color: accent.fg.withValues(alpha: 0.07),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(large ? ArtizenSpacing.md : ArtizenSpacing.sm),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              AccentIconChip(icon: icon, accent: accent, size: large ? 54 : 44),
              SizedBox(height: large ? 16 : 10),
              Text(
                value,
                style: TextStyle(
                  fontFamily: AppTheme.fontFamily,
                  fontSize: large ? 34 : 26,
                  fontWeight: FontWeight.w700,
                  color: ArtizenColors.textPrimary,
                  height: 1.0,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: const TextStyle(
                  fontFamily: AppTheme.fontFamily,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: ArtizenColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            height: 4,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: accent.gradient),
            ),
          ),
        ),
      ],
    );

    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radius),
        boxShadow: [
          BoxShadow(
            color: ArtizenColors.nightBlue.withValues(alpha: 0.06),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: onTap == null
            ? body
            : Material(
                type: MaterialType.transparency,
                child: InkWell(onTap: onTap, child: body),
              ),
      ),
    );
  }
}

/// The floating action button in the violet→magenta gradient. A plain
/// [FloatingActionButton] can't carry a gradient, so this is a circular
/// gradient surface with an ink ripple.
class GradientFab extends StatelessWidget {
  const GradientFab({
    required this.onPressed,
    this.icon = Icons.add,
    this.tooltip,
    super.key,
  });

  final VoidCallback onPressed;
  final IconData icon;
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    final fab = Container(
      width: 58,
      height: 58,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: ArtizenGradients.button,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: ArtizenGradients.button.last.withValues(alpha: 0.42),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: onPressed,
          customBorder: const CircleBorder(),
          child: Icon(icon, color: Colors.white, size: 28),
        ),
      ),
    );
    return tooltip == null ? fab : Tooltip(message: tooltip!, child: fab);
  }
}
