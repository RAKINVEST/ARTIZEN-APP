import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// Reusable UI building blocks for the ARTIZEN design system. Every colour,
/// radius and spacing comes from [ArtizenColors] / [ArtizenRadii] — a screen
/// composes these, never restyles them.

/// A labelled text field: a static label above, an outlined field with a
/// leading icon and an optional reveal toggle for passwords. Border, radius
/// and height come from the theme's [InputDecorationTheme].
class AppTextField extends StatefulWidget {
  const AppTextField({
    required this.label,
    required this.controller,
    this.hintText,
    this.icon,
    this.obscure = false,
    this.keyboardType,
    this.autofillHints,
    this.validator,
    this.onFieldSubmitted,
    this.textInputAction,
    super.key,
  });

  final String label;
  final TextEditingController controller;
  final String? hintText;
  final IconData? icon;
  final bool obscure;
  final TextInputType? keyboardType;
  final Iterable<String>? autofillHints;
  final String? Function(String?)? validator;
  final void Function(String)? onFieldSubmitted;
  final TextInputAction? textInputAction;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late bool _obscured = widget.obscure;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: ArtizenColors.textPrimary,
          ),
        ),
        const SizedBox(height: ArtizenSpacing.xs),
        TextFormField(
          controller: widget.controller,
          obscureText: _obscured,
          keyboardType: widget.keyboardType,
          autofillHints: widget.autofillHints,
          validator: widget.validator,
          onFieldSubmitted: widget.onFieldSubmitted,
          textInputAction: widget.textInputAction,
          decoration: InputDecoration(
            hintText: widget.hintText,
            prefixIcon: widget.icon == null ? null : Icon(widget.icon),
            suffixIcon: widget.obscure
                ? IconButton(
                    icon: Icon(_obscured ? Icons.visibility_outlined : Icons.visibility_off_outlined),
                    tooltip: _obscured ? 'Afficher' : 'Masquer',
                    onPressed: () => setState(() => _obscured = !_obscured),
                  )
                : null,
          ),
        ),
      ],
    );
  }
}

/// The screen's primary call to action — gold, night-blue label, leading
/// icon, full width, with a built-in loading state.
class AppPrimaryButton extends StatelessWidget {
  const AppPrimaryButton({
    required this.label,
    this.onPressed,
    this.icon,
    this.loading = false,
    super.key,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: loading ? null : onPressed,
      child: loading
          ? const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(strokeWidth: 2.2, color: ArtizenColors.onGold),
            )
          : Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (icon != null) ...[Icon(icon, size: 20), const SizedBox(width: ArtizenSpacing.xs)],
                Text(label.toUpperCase(), style: const TextStyle(letterSpacing: 0.5)),
              ],
            ),
    );
  }
}

/// A secondary action — filled night blue with a white label, so it reads as
/// deliberate but never competes with the gold primary.
class AppSecondaryButton extends StatelessWidget {
  const AppSecondaryButton({
    required this.label,
    this.onPressed,
    this.icon,
    super.key,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPressed,
      style: FilledButton.styleFrom(
        backgroundColor: ArtizenColors.nightBlue,
        foregroundColor: ArtizenColors.onNightBlue,
        minimumSize: const Size.fromHeight(52),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(ArtizenRadii.button)),
        textStyle: const TextStyle(fontFamily: AppTheme.fontFamily, fontSize: 15, fontWeight: FontWeight.w600),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) ...[Icon(icon, size: 20), const SizedBox(width: ArtizenSpacing.xs)],
          Text(label.toUpperCase(), style: const TextStyle(letterSpacing: 0.5)),
        ],
      ),
    );
  }
}

/// A textual navigation action — an icon + label in night blue.
class AppLink extends StatelessWidget {
  const AppLink({required this.label, this.icon, this.onPressed, super.key});

  final String label;
  final IconData? icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onPressed,
      icon: icon == null ? const SizedBox.shrink() : Icon(icon, size: 18, color: ArtizenColors.nightBlue),
      label: Text(label.toUpperCase()),
      style: TextButton.styleFrom(
        foregroundColor: ArtizenColors.nightBlue,
        textStyle: const TextStyle(
          fontFamily: AppTheme.fontFamily,
          fontSize: 13,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

/// A horizontal rule with a centred word ("ou"). Fine lines in the border
/// token, muted label.
class AppDivider extends StatelessWidget {
  const AppDivider({this.label, super.key});

  final String? label;

  @override
  Widget build(BuildContext context) {
    if (label == null) return const Divider(color: ArtizenColors.border);
    return Row(
      children: [
        const Expanded(child: Divider(color: ArtizenColors.border)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: ArtizenSpacing.sm),
          child: Text(
            label!,
            style: const TextStyle(color: ArtizenColors.textSecondary, fontSize: 14),
          ),
        ),
        const Expanded(child: Divider(color: ArtizenColors.border)),
      ],
    );
  }
}

/// A reassurance / information block — a leading icon, a title and a
/// description on the soft info surface.
class AppInfoCard extends StatelessWidget {
  const AppInfoCard({
    required this.icon,
    required this.title,
    required this.description,
    super.key,
  });

  final IconData icon;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(ArtizenSpacing.sm),
      decoration: BoxDecoration(
        color: ArtizenColors.infoSurface,
        borderRadius: BorderRadius.circular(ArtizenRadii.card),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: ArtizenColors.nightBlue, size: 24),
          const SizedBox(width: ArtizenSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: ArtizenColors.nightBlue,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  description,
                  style: const TextStyle(color: ArtizenColors.textSecondary, fontSize: 13, height: 1.35),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
