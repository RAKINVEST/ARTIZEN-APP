import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/api/api_exception.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/app_components.dart';
import 'auth_providers.dart';

/// Registration creates both the [User] and its [Company] in one call
/// (backend's `AuthService.register`) — `companyName` is optional; leaving
/// it blank still creates a company, just with a placeholder name the user
/// can rename later from Paramètres.
class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirmPassword = TextEditingController();
  final _fullName = TextEditingController();
  final _companyName = TextEditingController();
  bool _loading = false;
  String? _error;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _confirmPassword.dispose();
    _fullName.dispose();
    _companyName.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      await ref.read(authNotifierProvider.notifier).register(
            email: _email.text.trim(),
            password: _password.text,
            fullName: _fullName.text,
            companyName: _companyName.text,
          );
      if (mounted) context.go('/dashboard');
    } catch (error) {
      setState(() => _error = error is ApiException ? error.displayMessage : 'Échec de l\'inscription.');
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Créer un compte')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(ArtizenSpacing.md),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 440),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AppTextField(
                    label: 'Email *',
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
                    label: 'Mot de passe *',
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
                    label: 'Confirmer le mot de passe *',
                    controller: _confirmPassword,
                    hintText: 'Retapez le mot de passe',
                    icon: Icons.lock_outline,
                    obscure: true,
                    autofillHints: const [AutofillHints.newPassword],
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'Confirmez le mot de passe';
                      if (value != _password.text) return 'Les mots de passe ne correspondent pas';
                      return null;
                    },
                  ),
                  const SizedBox(height: ArtizenSpacing.sm),
                  AppTextField(
                    label: 'Nom complet',
                    controller: _fullName,
                    hintText: 'Votre nom',
                    icon: Icons.person_outline,
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: ArtizenSpacing.sm),
                  AppTextField(
                    label: 'Nom de l\'entreprise',
                    controller: _companyName,
                    hintText: 'Votre entreprise',
                    icon: Icons.business_outlined,
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (_) => _submit(),
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
                    label: 'Créer mon compte',
                    icon: Icons.check_circle_outline,
                    loading: _loading,
                    onPressed: _submit,
                  ),
                  const SizedBox(height: ArtizenSpacing.xs),
                  AppLink(
                    label: 'J\'ai déjà un compte',
                    icon: Icons.login,
                    onPressed: _loading ? null : () => context.go('/login'),
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
