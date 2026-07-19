import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

import 'core/navigation/app_router.dart';
import 'core/theme/app_theme.dart';

void main() {
  // Path-based URLs (no `#`), so deep links resolve to their GoRoute instead
  // of the hash router ignoring the path. Without this, the password-reset
  // email link `<APP_BASE_URL>/reset-password?token=...` lands on the landing
  // page (empty fragment -> `/`) and the token is dropped. Nginx serves
  // index.html for unknown paths (try_files), so these deep links work.
  usePathUrlStrategy();
  runApp(const ProviderScope(child: ArtizenApp()));
}

class ArtizenApp extends ConsumerWidget {
  const ArtizenApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    return MaterialApp.router(
      title: 'Artizen',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      routerConfig: router,
    );
  }
}
