import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'empty_state.dart';
import 'error_state.dart';
import 'loading_state.dart';

/// Renders the four states every screen must handle (chargement / vide /
/// erreur / succès) for a single value. Use [AsyncListView] instead when
/// the value is a list, so "empty" is handled automatically.
class AsyncValueView<T> extends StatelessWidget {
  const AsyncValueView({
    required this.value,
    required this.builder,
    this.onRetry,
    super.key,
  });

  final AsyncValue<T> value;
  final Widget Function(BuildContext context, T data) builder;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return value.when(
      data: (data) => builder(context, data),
      loading: () => const LoadingState(),
      error: (error, _) => ErrorState(error: error, onRetry: onRetry),
    );
  }
}

/// Same as [AsyncValueView] but for lists: shows [EmptyState] automatically
/// when the loaded list is empty, so no screen has to re-implement that
/// check.
class AsyncListView<T> extends StatelessWidget {
  const AsyncListView({
    required this.value,
    required this.itemBuilder,
    this.emptyMessage = 'Aucun élément pour le moment.',
    this.emptyIcon = Icons.inbox_outlined,
    this.onRetry,
    super.key,
  });

  final AsyncValue<List<T>> value;
  final Widget Function(BuildContext context, List<T> items) itemBuilder;
  final String emptyMessage;
  final IconData emptyIcon;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return value.when(
      data: (items) => items.isEmpty
          ? EmptyState(message: emptyMessage, icon: emptyIcon)
          : itemBuilder(context, items),
      loading: () => const LoadingState(),
      error: (error, _) => ErrorState(error: error, onRetry: onRetry),
    );
  }
}
