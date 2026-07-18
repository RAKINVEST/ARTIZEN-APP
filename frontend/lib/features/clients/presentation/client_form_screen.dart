import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/app_components.dart';
import '../../../core/widgets/async_value_view.dart';
import '../data/client_model.dart';
import 'clients_providers.dart';

/// Used for both creation (`clientId == null`) and editing — one form, one
/// set of validation rules, no duplication between the two flows.
class ClientFormScreen extends ConsumerWidget {
  const ClientFormScreen({this.clientId, super.key});

  final String? clientId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (clientId == null) {
      return _ClientForm(clientId: null, initial: null);
    }
    final clientAsync = ref.watch(clientByIdProvider(clientId!));
    return Scaffold(
      appBar: AppBar(title: const Text('Modifier le client')),
      body: AsyncValueView(
        value: clientAsync,
        // Without this the error state has no action: a dropped connection
        // while opening a client left a dead screen whose only way out was
        // the back button.
        onRetry: () => ref.invalidate(clientByIdProvider(clientId!)),
        builder: (context, client) => _ClientForm(clientId: clientId, initial: client),
      ),
    );
  }
}

class _ClientForm extends ConsumerStatefulWidget {
  const _ClientForm({required this.clientId, required this.initial});

  final String? clientId;
  final Client? initial;

  @override
  ConsumerState<_ClientForm> createState() => _ClientFormState();
}

class _ClientFormState extends ConsumerState<_ClientForm> {
  final _formKey = GlobalKey<FormState>();
  late final _lastName = TextEditingController(text: widget.initial?.lastName);
  late final _firstName = TextEditingController(text: widget.initial?.firstName);
  late final _companyName = TextEditingController(text: widget.initial?.companyName);
  late final _address = TextEditingController(text: widget.initial?.address);
  late final _phone = TextEditingController(text: widget.initial?.phone);
  late final _email = TextEditingController(text: widget.initial?.email);
  late final _notes = TextEditingController(text: widget.initial?.notes);
  bool _saving = false;

  @override
  void dispose() {
    for (final controller in [_lastName, _firstName, _companyName, _address, _phone, _email, _notes]) {
      controller.dispose();
    }
    super.dispose();
  }

  String? _blankToNull(String value) => value.trim().isEmpty ? null : value.trim();

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    final input = ClientInput(
      lastName: _lastName.text.trim(),
      firstName: _blankToNull(_firstName.text),
      companyName: _blankToNull(_companyName.text),
      address: _blankToNull(_address.text),
      phone: _blankToNull(_phone.text),
      email: _blankToNull(_email.text),
      notes: _blankToNull(_notes.text),
    );
    try {
      if (widget.clientId == null) {
        await ref.read(clientsNotifierProvider.notifier).createClient(input);
      } else {
        await ref.read(clientsNotifierProvider.notifier).updateClient(widget.clientId!, input);
      }
      if (mounted) context.pop();
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Échec de l\'enregistrement : $error')),
        );
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.clientId != null;
    final form = Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.all(ArtizenSpacing.sm),
        children: [
          AppTextField(
            label: 'Nom *',
            controller: _lastName,
            hintText: 'Nom du client',
            icon: Icons.person_outline,
            textInputAction: TextInputAction.next,
            validator: (value) => (value == null || value.trim().isEmpty) ? 'Le nom est requis' : null,
          ),
          const SizedBox(height: ArtizenSpacing.sm),
          AppTextField(
            label: 'Prénom',
            controller: _firstName,
            hintText: 'Prénom',
            icon: Icons.badge_outlined,
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: ArtizenSpacing.sm),
          AppTextField(
            label: 'Société',
            controller: _companyName,
            hintText: 'Raison sociale (optionnel)',
            icon: Icons.business_outlined,
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: ArtizenSpacing.sm),
          AppTextField(
            label: 'Adresse',
            controller: _address,
            hintText: 'Adresse complète',
            icon: Icons.place_outlined,
            maxLines: 2,
          ),
          const SizedBox(height: ArtizenSpacing.sm),
          AppTextField(
            label: 'Téléphone',
            controller: _phone,
            hintText: 'Numéro de téléphone',
            icon: Icons.phone_outlined,
            keyboardType: TextInputType.phone,
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: ArtizenSpacing.sm),
          AppTextField(
            label: 'Email',
            controller: _email,
            hintText: 'Adresse email',
            icon: Icons.mail_outline,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: ArtizenSpacing.sm),
          AppTextField(
            label: 'Notes',
            controller: _notes,
            hintText: 'Notes internes',
            icon: Icons.notes_outlined,
            maxLines: 3,
          ),
          const SizedBox(height: ArtizenSpacing.md),
          AppPrimaryButton(
            label: isEditing ? 'Enregistrer' : 'Créer le client',
            icon: Icons.check_circle_outline,
            loading: _saving,
            onPressed: _save,
          ),
        ],
      ),
    );

    if (!isEditing) {
      return Scaffold(
        appBar: AppBar(title: const Text('Nouveau client')),
        body: form,
      );
    }
    return form;
  }
}
