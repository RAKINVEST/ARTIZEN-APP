import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/api/api_exception.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/app_components.dart';
import '../data/auth_repository.dart';

/// "Mot de passe oublié" — asks for the account email and triggers a reset
/// link. The backend never reveals whether the email is registered (204 in
/// every case), so the success message here is deliberately neutral: it must
/// not confirm or deny that an account exists.
class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ConsumerState<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  bool _loading = false;
  bool _sent = false;
  String? _error;

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    // Guard against double submission: the button is already disabled while
    // loading, this also blocks a stray programmatic call.
    if (_loading) return;
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      await ref.read(authRepositoryProvider).requestPasswordReset(_email.text.trim());
      if (mounted) setState(() => _sent = true);
    } catch (error) {
      setState(() =>
          _error = error is ApiException ? error.displayMessage : "Échec de l'envoi. Réessayez.");
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mot de passe oublié')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(ArtizenSpacing.md),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 440),
            child: _sent ? _buildSent(context) : _buildForm(),
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
            'Réinitialiser votre mot de passe',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: ArtizenColors.textPrimary,
            ),
          ),
          const SizedBox(height: ArtizenSpacing.xs),
          const Text(
            'Indiquez votre email : nous vous enverrons un lien pour choisir un nouveau mot de passe.',
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
            textInputAction: TextInputAction.done,
            onFieldSubmitted: (_) => _submit(),
            validator: _validateEmail,
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
            label: 'Envoyer le lien',
            icon: Icons.send_outlined,
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

  Widget _buildSent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const AppInfoCard(
          icon: Icons.mark_email_read_outlined,
          title: 'Demande envoyée',
          // Neutral wording: never confirms whether the email is registered.
          description: 'Si un compte existe pour cet email, vous recevrez un lien.',
        ),
        const SizedBox(height: ArtizenSpacing.md),
        AppPrimaryButton(
          label: 'Retour à la connexion',
          icon: Icons.login,
          onPressed: () => context.go('/login'),
        ),
      ],
    );
  }

  String? _validateEmail(String? value) {
    final email = value?.trim() ?? '';
    if (email.isEmpty) return "L'email est requis";
    // Light shape check — the backend is the source of truth, this only
    // catches obvious typos before a round-trip.
    if (!email.contains('@') || !email.contains('.')) return 'Email invalide';
    return null;
  }
}
