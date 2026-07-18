import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../pagination/paged_list.dart';
import 'empty_state.dart';
import 'error_state.dart';
import 'loading_state.dart';

/// Renders a server-paginated list: the four states (chargement / vide /
/// erreur / succès), pull-to-refresh, infinite scroll, and — crucially — it
/// keeps the current rows on screen while a search or refresh is in flight,
/// showing a discrete top bar instead of a full-screen spinner.
///
/// The keep-the-rows behaviour relies on the notifier setting an
/// `AsyncLoading` that carries the previous value (see [PagedListNotifier]):
/// `skipLoadingOnReload`/`skipLoadingOnRefresh` then route to `data(previous)`
/// rather than `loading()`.
class PagedListView<T> extends StatefulWidget {
  const PagedListView({
    required this.value,
    required this.itemBuilder,
    required this.onRefresh,
    required this.onLoadMore,
    this.onRetry,
    this.emptyMessage = 'Aucun élément pour le moment.',
    this.emptyIcon = Icons.inbox_outlined,
    this.padding = const EdgeInsets.only(top: 8, bottom: 88),
    super.key,
  });

  final AsyncValue<PagedList<T>> value;
  final Widget Function(BuildContext context, T item) itemBuilder;
  final Future<void> Function() onRefresh;
  final VoidCallback onLoadMore;
  final VoidCallback? onRetry;
  final String emptyMessage;
  final IconData emptyIcon;
  final EdgeInsets padding;

  @override
  State<PagedListView<T>> createState() => _PagedListViewState<T>();
}

class _PagedListViewState<T> extends State<PagedListView<T>> {
  /// Fires "load more" a little before the last row, so the next page is
  /// usually there by the time the artisan reaches it.
  static const double _loadMoreThreshold = 320;

  bool _onScroll(ScrollNotification notification, PagedList<T> paged) {
    if (!paged.hasMore || paged.isLoadingMore) return false;
    final metrics = notification.metrics;
    if (metrics.axis != Axis.vertical) return false;
    if (metrics.pixels >= metrics.maxScrollExtent - _loadMoreThreshold) {
      widget.onLoadMore();
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return widget.value.when(
      skipLoadingOnReload: true,
      skipLoadingOnRefresh: true,
      data: (paged) => _buildData(paged, refreshing: widget.value.isLoading),
      loading: () => const LoadingState(),
      error: (error, _) => ErrorState(error: error, onRetry: widget.onRetry),
    );
  }

  Widget _buildData(PagedList<T> paged, {required bool refreshing}) {
    // Empty and settled: the "vide" state, still pull-to-refreshable.
    if (paged.items.isEmpty && !refreshing) {
      return RefreshIndicator(
        onRefresh: widget.onRefresh,
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.6,
              child: EmptyState(message: widget.emptyMessage, icon: widget.emptyIcon),
            ),
          ],
        ),
      );
    }

    final footerCount = paged.isLoadingMore ? 1 : 0;
    return Column(
      children: [
        // Discrete refresh/search indicator — 2 px, never the full page.
        SizedBox(
          height: 2,
          child: refreshing ? const LinearProgressIndicator(minHeight: 2) : null,
        ),
        Expanded(
          child: RefreshIndicator(
            onRefresh: widget.onRefresh,
            child: NotificationListener<ScrollNotification>(
              onNotification: (notification) => _onScroll(notification, paged),
              child: ListView.builder(
                padding: widget.padding,
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: paged.items.length + footerCount,
                itemBuilder: (context, index) {
                  if (index >= paged.items.length) return const _PageFooterLoader();
                  return widget.itemBuilder(context, paged.items[index]);
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// The pied-de-liste loader shown only while the next page is being fetched.
class _PageFooterLoader extends StatelessWidget {
  const _PageFooterLoader();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Center(
        child: SizedBox(
          height: 24,
          width: 24,
          child: CircularProgressIndicator(strokeWidth: 2.4),
        ),
      ),
    );
  }
}
