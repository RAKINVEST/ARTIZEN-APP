import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/auth_providers.dart';
import '../../features/auth/presentation/login_screen.dart';
import '../../features/auth/presentation/register_screen.dart';
import '../../features/branding/presentation/branding_sample_preview_screen.dart';
import '../../features/branding/presentation/company_profile_screen.dart';
import '../../features/catalog/presentation/catalog_screen.dart';
import '../../features/catalog/presentation/item_form_screen.dart';
import '../../features/clients/presentation/client_form_screen.dart';
import '../../features/clients/presentation/clients_list_screen.dart';
import '../../features/dashboard/presentation/dashboard_screen.dart';
import '../../features/quote_assistant/presentation/quote_assistant_screen.dart';
import '../../features/quotes/presentation/quote_detail_screen.dart';
import '../../features/quotes/presentation/quote_form_screen.dart';
import '../../features/quotes/presentation/quote_pdf_preview_screen.dart';
import '../../features/quotes/presentation/quotes_list_screen.dart';
import '../../features/settings/presentation/settings_screen.dart';
import '../../features/template_import/presentation/template_import_screen.dart';
import 'app_shell.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

/// Bridges [authNotifierProvider] to GoRouter's `refreshListenable` so a
/// logout that isn't triggered by the user tapping something in the app —
/// a 401 from an expired/invalid token bumping `authSessionEpochProvider`,
/// see `core/api/dio_client.dart` — still bounces the user back to
/// `/login` immediately, instead of only on the next navigation attempt.
class _AuthRouterRefresh extends ChangeNotifier {
  _AuthRouterRefresh(Ref ref) {
    ref.listen(authNotifierProvider, (_, _) => notifyListeners());
  }
}

/// Create/edit/detail routes are declared with [_rootNavigatorKey] as their
/// `parentNavigatorKey` so they push full-screen on top of the whole shell
/// (hiding the bottom nav bar) instead of inside a single tab's own stack —
/// the expected behavior for a form, not a tab.
final appRouterProvider = Provider<GoRouter>((ref) {
  final refresh = _AuthRouterRefresh(ref);
  ref.onDispose(refresh.dispose);

  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/login',
    refreshListenable: refresh,
    redirect: (context, state) async {
      final isLoggedIn = await ref.read(authNotifierProvider.future);
      final isAuthRoute = state.matchedLocation == '/login' || state.matchedLocation == '/register';
      if (!isLoggedIn && !isAuthRoute) return '/login';
      if (isLoggedIn && isAuthRoute) return '/dashboard';
      return null;
    },
    routes: [
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
      GoRoute(path: '/register', builder: (context, state) => const RegisterScreen()),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) => AppShell(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            navigatorKey: _shellNavigatorKey,
            routes: [GoRoute(path: '/dashboard', builder: (context, state) => const DashboardScreen())],
          ),
          StatefulShellBranch(
            routes: [GoRoute(path: '/clients', builder: (context, state) => const ClientsListScreen())],
          ),
          StatefulShellBranch(
            routes: [GoRoute(path: '/catalog', builder: (context, state) => const CatalogScreen())],
          ),
          StatefulShellBranch(
            routes: [GoRoute(path: '/quotes', builder: (context, state) => const QuotesListScreen())],
          ),
          StatefulShellBranch(
            routes: [GoRoute(path: '/settings', builder: (context, state) => const SettingsScreen())],
          ),
        ],
      ),
      GoRoute(
        path: '/clients/new',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const ClientFormScreen(),
      ),
      GoRoute(
        path: '/clients/:id/edit',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => ClientFormScreen(clientId: state.pathParameters['id']),
      ),
      GoRoute(
        path: '/catalog/items/new',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const ItemFormScreen(),
      ),
      GoRoute(
        path: '/catalog/items/:id/edit',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => ItemFormScreen(itemId: state.pathParameters['id']),
      ),
      GoRoute(
        path: '/quotes/new',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const QuoteFormScreen(),
      ),
      GoRoute(
        path: '/quote-assistant',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const QuoteAssistantScreen(),
      ),
      GoRoute(
        path: '/template-import',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const TemplateImportScreen(),
      ),
      GoRoute(
        path: '/branding/sample-preview',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const BrandingSamplePreviewScreen(),
      ),
      GoRoute(
        path: '/company-profile',
        parentNavigatorKey: _rootNavigatorKey,
        // `?field=` lets the readiness gate deep-link straight to the field a
        // quote is missing, which the form then focuses and scrolls to.
        builder: (context, state) =>
            CompanyProfileScreen(focusField: state.uri.queryParameters['field']),
      ),
      GoRoute(
        path: '/quotes/:id',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => QuoteDetailScreen(quoteId: state.pathParameters['id']!),
      ),
      GoRoute(
        path: '/quotes/:id/pdf',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => QuotePdfPreviewScreen(quoteId: state.pathParameters['id']!),
      ),
    ],
  );
});
