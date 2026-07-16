import 'package:flutter/material.dart';

/// Reused by both `clients` and `catalog` list screens.
class SearchField extends StatelessWidget {
  const SearchField({
    required this.hintText,
    required this.onChanged,
    super.key,
  });

  final String hintText;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
      child: TextField(
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: const Icon(Icons.search),
          border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
        ),
        onChanged: onChanged,
      ),
    );
  }
}
