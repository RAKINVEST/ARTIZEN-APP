import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/knowledge_model.dart';
import '../data/knowledge_repository_impl.dart';

/// Holds the last search result. `null` = nothing searched yet. Every search
/// funnels through [search] so the screen renders one consistent async state.
class KnowledgeSearchController extends AutoDisposeAsyncNotifier<KnowledgeSearchResult?> {
  @override
  Future<KnowledgeSearchResult?> build() async => null;

  Future<void> search(String q, {String? metier, bool includeDrafts = false}) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(knowledgeRepositoryProvider).search(
            q: q.trim(),
            metier: (metier != null && metier.trim().isNotEmpty) ? metier.trim() : null,
            includeDrafts: includeDrafts,
          ),
    );
  }
}

final knowledgeSearchProvider =
    AutoDisposeAsyncNotifierProvider<KnowledgeSearchController, KnowledgeSearchResult?>(
  KnowledgeSearchController.new,
);

/// One item + its relations, fetched fresh for the detail screen.
final knowledgeDetailProvider =
    FutureProvider.autoDispose.family<KnowledgeDetail, ({String type, String slug})>(
  (ref, args) => ref.read(knowledgeRepositoryProvider).detail(args.type, args.slug),
);
