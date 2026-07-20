import 'package:flutter/material.dart';

import '../api/api_exception.dart';

/// The "erreur" state, used identically on every screen. Renders
/// [ApiException.displayMessage], unwrapping the `DioException` the
/// interceptor rejects with (see [asApiException]) so the *real* cause is
/// shown instead of a generic sentence. Anything genuinely unexpected still
/// degrades to a readable message rather than leaking a stack trace.
class ErrorState extends StatelessWidget {
  const ErrorState({required this.error, this.onRetry, super.key});

  final Object error;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final message = asApiException(error).displayMessage;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline, size: 48, color: theme.colorScheme.error),
            const SizedBox(height: 12),
            Text(
              message,
              style: theme.textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            if (onRetry != null) ...[
              const SizedBox(height: 16),
              FilledButton.tonal(onPressed: onRetry, child: const Text('Réessayer')),
            ],
          ],
        ),
      ),
    );
  }
}
