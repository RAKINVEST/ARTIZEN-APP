import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/api/api_exception.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/app_components.dart';
import '../data/auth_repository.dart';

/// "Nouveau mot de passe" — the screen the reset-email link lands on
/// (`<APP_BASE_URL>/reset-password?token=XXXX`). It reads the [token] from the
/// query string, collects a new password (twice), and calls the backend. A
/// missing/blank token or a 400 both mean the same thing to the user: the link
/// is no longer usable and they must request a new one.
class ResetPasswordScreen extends ConsumerStatefulWidget {
  const ResetPasswordScreen({required this.token, super.key});

  /// The reset token carried by `?token=` in the email link; `null` when the
  /// screen is opened without it.
  final String? token;

  @override
  ConsumerState<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends ConsumerState<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _password = TextEditingController();
  final _confirm = TextEditingController();
  bool _loading = false;
  String? _error;

  bool get _hasToken => (widget.token ?? '').trim().isNotEmpty;

  @override
  void dispose() {
    _password.dispose();
    _confirm.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    // Guard against double submission (the button is disabled while loading).
    if (_loading) return;
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      await ref.read(authRepositoryProvider).resetPassword(
            token: widget.token!.trim(),
            password: _password.text,
          );
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Mot de passe réinitialisé. Vous pouvez vous connecter.')),
      );
      context.go('/login');
    } on ApiException catch (error) {
      // 400 → invalid/expired token. Any other server code falls back to its
      // own message so we never mislabel, say, a network failure as expired.
      final expired = error is ApiServerException && error.statusCode == 400;
      setState(() => _error = expired
          ? 'Ce lien est invalide ou expiré, refaites une demande.'
          : error.displayMessage);
    } catch (_) {
      setState(() => _error = 'Échec de la réinitialisation. Réessayez.');
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nouveau mot de passe')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(ArtizenSpacing.md),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 440),
            child: _hasToken ? _buildForm() : _buildMissingToken(context),
          ),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Choisissez un nouveau mot de passe',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: ArtizenColors.textPrimary,
            ),
          ),
          const SizedBox(height: ArtizenSpacing.lg),
          AppTextField(
            label: 'Nouveau mot de passe',
            controller: _password,
            hintText: 'Au moins 8 caractères',
            icon: Icons.lock_outline,
            obscure: true,
            autofillHints: const [AutofillHints.newPassword],
            textInputAction: TextInputAction.next,
            validator: (value) {
              if (value == null || value.isEmpty) return 'Le mot de passe est requis';
              if (value.length < 8) return '8 caractères minimum';
              return null;
            },
          ),
          const SizedBox(height: ArtizenSpacing.sm),
          AppTextField(
            label: 'Confirmer le mot de passe',
            controller: _confirm,
            hintText: 'Retapez le mot de passe',
            icon: Icons.lock_outline,
            obscure: true,
            autofillHints: const [AutofillHints.newPassword],
            textInputAction: TextInputAction.done,
            onFieldSubmitted: (_) => _submit(),
            validator: (value) {
              if (value == null || value.isEmpty) return 'Confirmez le mot de passe';
              if (value != _password.text) return 'Les mots de passe ne correspondent pas';
              return null;
            },
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
            label: 'Réinitialiser',
            icon: Icons.check_circle_outline,
            loading: _loading,
            onPressed: _submit,
          ),
          const SizedBox(height: ArtizenSpacing.xs),
          AppLink(
            label: 'Retour à la connexion',
            icon: Icons.arrow_back,
            onPressed: _loading ? null : () => context.go('/login'),
          ),
        ],
      ),
    );
  }

  Widget _buildMissingToken(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const AppInfoCard(
          icon: Icons.link_off,
          title: 'Lien invalide',
          description: 'Ce lien est invalide ou expiré, refaites une demande.',
        ),
        const SizedBox(height: ArtizenSpacing.md),
        AppPrimaryButton(
          label: 'Nouvelle demande',
          icon: Icons.refresh,
          onPressed: () => context.go('/forgot-password'),
        ),
      ],
    );
  }
}
