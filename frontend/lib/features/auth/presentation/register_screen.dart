import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/api/api_exception.dart';
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
  final _fullName = TextEditingController();
  final _companyName = TextEditingController();
  bool _loading = false;
  bool _obscurePassword = true;
  String? _error;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
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
      // asApiException unwraps the DioException the interceptor rejects with,
      // so the real cause is shown ("email déjà utilisé", "mot de passe trop
      // court"…) instead of a catch-all "Échec de l'inscription".
      setState(() => _error = asApiException(error).displayMessage);
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
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: _email,
                    decoration: const InputDecoration(labelText: 'Email *'),
                    keyboardType: TextInputType.emailAddress,
                    autofillHints: const [AutofillHints.email],
                    validator: (value) =>
                        (value == null || value.trim().isEmpty) ? 'L\'email est requis' : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _password,
                    decoration: InputDecoration(
                      labelText: 'Mot de passe *',
                      // Stated upfront rather than only after a failed submit.
                      helperText: '8 caractères minimum',
                      suffixIcon: IconButton(
                        icon: Icon(_obscurePassword
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined),
                        tooltip: _obscurePassword ? 'Afficher' : 'Masquer',
                        onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                      ),
                    ),
                    obscureText: _obscurePassword,
                    autofillHints: const [AutofillHints.newPassword],
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'Le mot de passe est requis';
                      if (value.length < 8) return '8 caractères minimum';
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _fullName,
                    decoration: const InputDecoration(labelText: 'Nom complet'),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _companyName,
                    decoration: const InputDecoration(labelText: 'Nom de l\'entreprise'),
                    onFieldSubmitted: (_) => _submit(),
                  ),
                  if (_error != null) ...[
                    const SizedBox(height: 16),
                    Text(_error!, style: TextStyle(color: Theme.of(context).colorScheme.error)),
                  ],
                  const SizedBox(height: 24),
                  FilledButton(
                    onPressed: _loading ? null : _submit,
                    child: _loading
                        ? const SizedBox(
                            height: 16,
                            width: 16,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                            child: Text('Créer mon compte'),
                          ),
                  ),
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: _loading ? null : () => context.go('/login'),
                    child: const Text('J\'ai déjà un compte'),
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
