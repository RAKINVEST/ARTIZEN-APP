import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/app_components.dart';
import '../../data/catalog_models.dart';

/// A minimal add-category form (name + optional description) — the brief
/// only asks for "Liste catégories" in the UI, but the artisan needs some
/// way to create the first one, since the backend seeds none by default.
Future<CatalogCategoryInput?> showAddCategoryDialog(BuildContext context) {
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  return showDialog<CatalogCategoryInput>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Nouvelle catégorie'),
      content: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppTextField(
              label: 'Nom *',
              controller: nameController,
              hintText: 'Nom de la catégorie',
              icon: Icons.label_outline,
              textInputAction: TextInputAction.next,
              validator: (value) => (value == null || value.trim().isEmpty) ? 'Requis' : null,
            ),
            const SizedBox(height: ArtizenSpacing.sm),
            AppTextField(
              label: 'Description',
              controller: descriptionController,
              hintText: 'Optionnel',
              icon: Icons.notes_outlined,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Annuler')),
        FilledButton(
          onPressed: () {
            if (!formKey.currentState!.validate()) return;
            Navigator.of(context).pop(
              CatalogCategoryInput(
                name: nameController.text.trim(),
                description: descriptionController.text.trim().isEmpty
                    ? null
                    : descriptionController.text.trim(),
              ),
            );
          },
          child: const Text('Créer'),
        ),
      ],
    ),
  );
}
