import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/app_components.dart';
import '../../../core/widgets/async_value_view.dart';
import '../data/branding_models.dart';
import 'branding_providers.dart';

/// The two VAT regimes the backend accepts (`VatRegime` in
/// `app/branding/schemas.py`). Kept as plain strings — the backend contract
/// is a `Literal`, not an enum with extra behaviour on this side.
const String _vatRegimeNormal = 'normal';
const String _vatRegimeFranchise = 'franchise';

/// "Mon entreprise" — lets the artisan configure their whole company identity
/// (legal, contact, VAT regime, insurance, RGE, payment terms, quote validity)
/// straight from the app, instead of only through a PDF import. Reads and
/// writes `Company` via `/branding/*`; it never computes or stores anything
/// itself.
class CompanyProfileScreen extends ConsumerWidget {
  const CompanyProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(brandingProfileNotifierProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Mon entreprise')),
      body: AsyncValueView(
        value: profileAsync,
        // A dropped connection while opening the screen must stay recoverable
        // (a retry), not leave a dead page reachable only via the back button.
        onRetry: () => ref.read(brandingProfileNotifierProvider.notifier).refresh(),
        builder: (context, profile) => _CompanyForm(initial: profile.company),
      ),
    );
  }
}

class _CompanyForm extends ConsumerStatefulWidget {
  const _CompanyForm({required this.initial});

  final Company initial;

  @override
  ConsumerState<_CompanyForm> createState() => _CompanyFormState();
}

class _CompanyFormState extends ConsumerState<_CompanyForm> {
  final _formKey = GlobalKey<FormState>();

  // Identity
  late final _name = TextEditingController(text: widget.initial.name);
  late final _legalForm = TextEditingController(text: widget.initial.legalForm);
  late final _shareCapital = TextEditingController(text: widget.initial.shareCapital);
  late final _siret = TextEditingController(text: widget.initial.siret);
  late final _rcsRm = TextEditingController(text: widget.initial.rcsRm);
  late final _apeCode = TextEditingController(text: widget.initial.apeCode);
  late final _vatNumber = TextEditingController(text: widget.initial.vatNumber);

  // Contact
  late final _addressLine = TextEditingController(text: widget.initial.addressLine);
  late final _postalCode = TextEditingController(text: widget.initial.postalCode);
  late final _city = TextEditingController(text: widget.initial.city);
  late final _country = TextEditingController(text: widget.initial.country);
  late final _phone = TextEditingController(text: widget.initial.phone);
  late final _email = TextEditingController(text: widget.initial.email);
  late final _website = TextEditingController(text: widget.initial.website);

  // Insurance (décennale)
  late final _insuranceName = TextEditingController(text: widget.initial.insuranceName);
  late final _insuranceContract = TextEditingController(text: widget.initial.insuranceContract);
  late final _insuranceCoverage = TextEditingController(text: widget.initial.insuranceCoverage);

  // RGE + terms
  late final _rgeNumber = TextEditingController(text: widget.initial.rgeNumber);
  late final _paymentTerms = TextEditingController(text: widget.initial.paymentTerms);
  late final _quoteValidityDays =
      TextEditingController(text: widget.initial.quoteValidityDays.toString());

  late String _vatRegime = widget.initial.vatRegime;
  bool _saving = false;

  List<TextEditingController> get _controllers => [
        _name, _legalForm, _shareCapital, _siret, _rcsRm, _apeCode, _vatNumber,
        _addressLine, _postalCode, _city, _country, _phone, _email, _website,
        _insuranceName, _insuranceContract, _insuranceCoverage,
        _rgeNumber, _paymentTerms, _quoteValidityDays,
      ];

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  /// Empty input means "not provided": with the model's `include_if_null:
  /// false`, a null key is dropped from the request body, so the backend's
  /// `exclude_unset=True` leaves the stored field untouched.
  String? _blankToNull(String value) => value.trim().isEmpty ? null : value.trim();

  Future<void> _save() async {
    // Guard against double submission: bail if a save is already running or the
    // form is invalid, before flipping into the saving state.
    if (_saving) return;
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    final input = CompanyUpdateInput(
      name: _blankToNull(_name.text),
      legalForm: _blankToNull(_legalForm.text),
      shareCapital: _blankToNull(_shareCapital.text),
      siret: _blankToNull(_siret.text),
      rcsRm: _blankToNull(_rcsRm.text),
      apeCode: _blankToNull(_apeCode.text),
      vatNumber: _blankToNull(_vatNumber.text),
      addressLine: _blankToNull(_addressLine.text),
      postalCode: _blankToNull(_postalCode.text),
      city: _blankToNull(_city.text),
      country: _blankToNull(_country.text),
      phone: _blankToNull(_phone.text),
      email: _blankToNull(_email.text),
      website: _blankToNull(_website.text),
      insuranceName: _blankToNull(_insuranceName.text),
      insuranceContract: _blankToNull(_insuranceContract.text),
      insuranceCoverage: _blankToNull(_insuranceCoverage.text),
      rgeNumber: _blankToNull(_rgeNumber.text),
      paymentTerms: _blankToNull(_paymentTerms.text),
      // Always sent: both are required config with a known current value.
      vatRegime: _vatRegime,
      quoteValidityDays: int.tryParse(_quoteValidityDays.text.trim()),
    );
    try {
      await ref.read(brandingProfileNotifierProvider.notifier).updateCompany(input);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Entreprise enregistrée')),
        );
      }
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

  String? _validateEmail(String? value) {
    final trimmed = value?.trim() ?? '';
    if (trimmed.isEmpty) return null; // optional field
    // Deliberately loose: just enough to catch a typo (missing @ / domain),
    // not a full RFC 5322 validator — the backend stays the source of truth.
    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    return emailRegex.hasMatch(trimmed) ? null : 'Adresse email invalide';
  }

  String? _validateValidityDays(String? value) {
    final trimmed = value?.trim() ?? '';
    if (trimmed.isEmpty) return 'Requis';
    final days = int.tryParse(trimmed);
    // Mirrors the backend's `ge=1, le=365` bound so an out-of-range value is
    // caught on the field instead of coming back as an opaque 422.
    if (days == null || days < 1 || days > 365) {
      return 'Entre 1 et 365 jours';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.all(ArtizenSpacing.sm),
        children: [
          const _SectionHeader('Identité'),
          AppTextField(
            label: 'Nom commercial',
            controller: _name,
            hintText: 'Nom affiché de l\'entreprise',
            icon: Icons.storefront_outlined,
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: ArtizenSpacing.sm),
          AppTextField(
            label: 'Forme juridique',
            controller: _legalForm,
            hintText: 'SARL, SAS, EI, micro-entreprise…',
            icon: Icons.account_balance_outlined,
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: ArtizenSpacing.sm),
          AppTextField(
            label: 'Capital social',
            controller: _shareCapital,
            hintText: 'ex. 5 000 €',
            icon: Icons.savings_outlined,
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: ArtizenSpacing.sm),
          AppTextField(
            label: 'SIRET',
            controller: _siret,
            hintText: 'Numéro SIRET (14 chiffres)',
            icon: Icons.numbers_outlined,
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: ArtizenSpacing.sm),
          AppTextField(
            label: 'RCS / Répertoire des Métiers',
            controller: _rcsRm,
            hintText: 'N° RCS ou n° RM',
            icon: Icons.gavel_outlined,
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: ArtizenSpacing.sm),
          AppTextField(
            label: 'Code APE / NAF',
            controller: _apeCode,
            hintText: 'ex. 4332A',
            icon: Icons.category_outlined,
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: ArtizenSpacing.sm),
          AppTextField(
            label: 'N° de TVA intracommunautaire',
            controller: _vatNumber,
            hintText: 'ex. FR12345678900',
            icon: Icons.receipt_long_outlined,
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: ArtizenSpacing.md),

          const _SectionHeader('Coordonnées'),
          AppTextField(
            label: 'Adresse',
            controller: _addressLine,
            hintText: 'Numéro et rue',
            icon: Icons.place_outlined,
            maxLines: 2,
          ),
          const SizedBox(height: ArtizenSpacing.sm),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: AppTextField(
                  label: 'Code postal',
                  controller: _postalCode,
                  hintText: '75000',
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                ),
              ),
              const SizedBox(width: ArtizenSpacing.sm),
              Expanded(
                flex: 2,
                child: AppTextField(
                  label: 'Ville',
                  controller: _city,
                  hintText: 'Ville',
                  textInputAction: TextInputAction.next,
                ),
              ),
            ],
          ),
          const SizedBox(height: ArtizenSpacing.sm),
          AppTextField(
            label: 'Pays',
            controller: _country,
            hintText: 'France',
            icon: Icons.public_outlined,
            textInputAction: TextInputAction.next,
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
            validator: _validateEmail,
          ),
          const SizedBox(height: ArtizenSpacing.sm),
          AppTextField(
            label: 'Site web',
            controller: _website,
            hintText: 'https://…',
            icon: Icons.language_outlined,
            keyboardType: TextInputType.url,
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: ArtizenSpacing.md),

          const _SectionHeader('Régime de TVA'),
          SegmentedButton<String>(
            segments: const [
              ButtonSegment(
                value: _vatRegimeNormal,
                label: Text('TVA normale'),
                icon: Icon(Icons.percent_outlined),
              ),
              ButtonSegment(
                value: _vatRegimeFranchise,
                label: Text('Franchise en base'),
                icon: Icon(Icons.money_off_outlined),
              ),
            ],
            selected: {_vatRegime},
            onSelectionChanged: (selection) => setState(() => _vatRegime = selection.first),
          ),
          const SizedBox(height: ArtizenSpacing.sm),
          const AppInfoCard(
            icon: Icons.info_outline,
            title: 'Franchise en base — micro-entrepreneur (art. 293 B)',
            description:
                'En franchise en base, les devis ne portent aucune TVA et affichent '
                'la mention « TVA non applicable, art. 293 B du CGI ».',
          ),
          const SizedBox(height: ArtizenSpacing.md),

          const _SectionHeader('Assurance décennale'),
          AppTextField(
            label: 'Assureur',
            controller: _insuranceName,
            hintText: 'Nom de la compagnie',
            icon: Icons.shield_outlined,
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: ArtizenSpacing.sm),
          AppTextField(
            label: 'N° de contrat',
            controller: _insuranceContract,
            hintText: 'Numéro de police',
            icon: Icons.tag_outlined,
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: ArtizenSpacing.sm),
          AppTextField(
            label: 'Couverture géographique',
            controller: _insuranceCoverage,
            hintText: 'ex. France métropolitaine',
            icon: Icons.map_outlined,
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: ArtizenSpacing.md),

          const _SectionHeader('Qualification RGE'),
          AppTextField(
            label: 'N° RGE',
            controller: _rgeNumber,
            hintText: 'Numéro RGE (si applicable)',
            icon: Icons.verified_outlined,
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: ArtizenSpacing.md),

          const _SectionHeader('Conditions de paiement'),
          AppTextField(
            label: 'Conditions et délais',
            controller: _paymentTerms,
            hintText: 'Acompte, délais, pénalités de retard…',
            icon: Icons.description_outlined,
            maxLines: 4,
          ),
          const SizedBox(height: ArtizenSpacing.md),

          const _SectionHeader('Validité du devis'),
          AppTextField(
            label: 'Durée de validité',
            controller: _quoteValidityDays,
            hintText: '30',
            icon: Icons.event_available_outlined,
            suffixText: 'jours',
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            validator: _validateValidityDays,
          ),
          const SizedBox(height: ArtizenSpacing.md),

          AppPrimaryButton(
            label: 'Enregistrer',
            icon: Icons.check_circle_outline,
            loading: _saving,
            onPressed: _save,
          ),
        ],
      ),
    );
  }
}

/// An uppercase, primary-tinted section title — mirrors the Paramètres screen's
/// own section labels so both feel like the same screen family.
class _SectionHeader extends StatelessWidget {
  const _SectionHeader(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: ArtizenSpacing.xs, top: ArtizenSpacing.xs),
      child: Text(
        text.toUpperCase(),
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: Theme.of(context).colorScheme.primary,
              letterSpacing: 0.8,
            ),
      ),
    );
  }
}
