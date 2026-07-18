import 'package:flutter/foundation.dart';

/// One accumulated, paginated slice of a list: the rows loaded so far, plus
/// whether a further page may exist and whether that further page is being
/// fetched right now.
///
/// Immutable — [PagedListNotifier] replaces it wholesale, so a widget
/// watching it rebuilds only on a real change. Deliberately not a Freezed
/// model: a generic Freezed class is awkward, and this carries no JSON.
@immutable
class PagedList<T> {
  const PagedList({
    required this.items,
    required this.hasMore,
    this.isLoadingMore = false,
  });

  const PagedList.empty()
      : items = const [],
        hasMore = false,
        isLoadingMore = false;

  /// The rows loaded so far, in order.
  final List<T> items;

  /// True while the last fetched page came back full — a floor, never a
  /// guarantee: the next fetch may return nothing. Mirrors how the backend
  /// paginates (offset/limit), where "a full page" is the only signal of
  /// "maybe more".
  final bool hasMore;

  /// True while the *next* page is being appended, so the UI can show a
  /// footer loader without blanking the rows already on screen.
  final bool isLoadingMore;

  PagedList<T> copyWith({
    List<T>? items,
    bool? hasMore,
    bool? isLoadingMore,
  }) {
    return PagedList<T>(
      items: items ?? this.items,
      hasMore: hasMore ?? this.hasMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }
}
