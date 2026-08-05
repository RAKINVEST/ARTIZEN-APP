import 'package:flutter/material.dart';

import '../../data/decision_model.dart';

/// Renders the "why" behind each proposed line — the Decision Engine is never a
/// black box (Loi 6). Display-only.
class ExplanationView extends StatelessWidget {
  const ExplanationView({required this.explanation, super.key});

  final DecisionExplanation explanation;

  @override
  Widget build(BuildContext context) {
    if (explanation.items.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Text('Pourquoi ces propositions',
              style: TextStyle(fontWeight: FontWeight.w700)),
        ),
        for (final item in explanation.items)
          Card(
            child: ListTile(
              leading: const Icon(Icons.help_outline),
              title: Text(item.subject),
              subtitle: Text('${item.why}\n${item.basis}'),
              isThreeLine: true,
              trailing: Chip(label: Text(item.confidence)),
            ),
          ),
      ],
    );
  }
}
