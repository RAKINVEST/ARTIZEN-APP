import 'package:flutter/material.dart';

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
            TextFormField(
              controller: nameController,
              autofocus: true,
              decoration: const InputDecoration(labelText: 'Nom *'),
              validator: (value) => (value == null || value.trim().isEmpty) ? 'Requis' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
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
