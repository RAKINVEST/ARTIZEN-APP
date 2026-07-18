import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';
import '../../core/utils/debouncer.dart';

/// The unified search input for every list and picker. Debounces keystrokes
/// (~300 ms) so a query fires once the artisan stops typing, and shows a
/// discrete trailing spinner while results refresh — never a full-screen
/// loader, so the current rows stay put.
///
/// Supersedes the plain `SearchField`: same look (outlined, leading search
/// icon), plus debounce, an optional seeded value, and a clear button.
class DebouncedSearchField extends StatefulWidget {
  const DebouncedSearchField({
    required this.hintText,
    required this.onChanged,
    this.initialValue = '',
    this.isLoading = false,
    this.debounce = const Duration(milliseconds: 300),
    super.key,
  });

  final String hintText;
  final ValueChanged<String> onChanged;
  final String initialValue;

  /// Drives the discrete trailing spinner — bind it to the list's
  /// `AsyncValue.isLoading` so the artisan sees the search is working
  /// without the list ever disappearing.
  final bool isLoading;
  final Duration debounce;

  @override
  State<DebouncedSearchField> createState() => _DebouncedSearchFieldState();
}

class _DebouncedSearchFieldState extends State<DebouncedSearchField> {
  late final TextEditingController _controller = TextEditingController(text: widget.initialValue);
  late final Debouncer _debouncer = Debouncer(widget.debounce);

  @override
  void dispose() {
    _debouncer.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _onChanged(String value) {
    // Rebuild so the clear button appears/disappears with the text.
    setState(() {});
    _debouncer.run(() => widget.onChanged(value));
  }

  void _clear() {
    _controller.clear();
    // Clearing is deliberate — apply it immediately, without waiting out the
    // debounce, so the full list comes back the instant the artisan taps ×.
    _debouncer.cancel();
    setState(() {});
    widget.onChanged('');
  }

  @override
  Widget build(BuildContext context) {
    final hasText = _controller.text.isNotEmpty;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
      child: TextField(
        controller: _controller,
        onChanged: _onChanged,
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          hintText: widget.hintText,
          prefixIcon: const Icon(Icons.search),
          suffixIcon: _buildSuffix(hasText),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(ArtizenRadii.field)),
          ),
        ),
      ),
    );
  }

  Widget? _buildSuffix(bool hasText) {
    if (widget.isLoading) {
      return const Padding(
        padding: EdgeInsets.all(12),
        child: SizedBox(
          height: 18,
          width: 18,
          child: CircularProgressIndicator(strokeWidth: 2.2),
        ),
      );
    }
    if (hasText) {
      return IconButton(
        icon: const Icon(Icons.close),
        tooltip: 'Effacer',
        onPressed: _clear,
      );
    }
    return null;
  }
}
