import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/branding/presentation/branding_providers.dart';
import '../theme/app_theme.dart';
import '../widgets/app_surfaces.dart';

/// The five main sections, in navigation order. Shared by both the desktop
/// sidebar and the mobile bottom bar so the two never drift apart.
class _NavItem {
  const _NavItem(this.icon, this.selectedIcon, this.label);
  final IconData icon;
  final IconData selectedIcon;
  final String label;
}

const List<_NavItem> _navItems = [
  _NavItem(Icons.dashboard_outlined, Icons.dashboard, 'Tableau de bord'),
  _NavItem(Icons.people_outline, Icons.people, 'Clients'),
  _NavItem(Icons.inventory_2_outlined, Icons.inventory_2, 'Catalogue'),
  _NavItem(Icons.description_outlined, Icons.description, 'Devis'),
  _NavItem(Icons.settings_outlined, Icons.settings, 'Paramètres'),
];

/// The width below which the persistent sidebar collapses into a bottom bar.
const double _kSidebarBreakpoint = 1000;

/// The frame around the five main tabs. On a wide screen it shows a persistent
/// gradient sidebar; on a narrow one it falls back to the bottom
/// [NavigationBar]. Either way each branch keeps its own navigation stack (via
/// `StatefulShellRoute.indexedStack` in `app_router.dart`), so switching tabs
/// never loses where you were. The light page background is painted once here
/// (via [AppBackground]) behind whichever tab is showing.
class AppShell extends StatelessWidget {
  const AppShell({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  void _select(int index) => navigationShell.goBranch(
    index,
    initialLocation: index == navigationShell.currentIndex,
  );

  @override
  Widget build(BuildContext context) {
    final wide = MediaQuery.sizeOf(context).width >= _kSidebarBreakpoint;

    if (wide) {
      return Scaffold(
        body: Row(
          children: [
            _Sidebar(
              currentIndex: navigationShell.currentIndex,
              onSelect: _select,
            ),
            Expanded(child: AppBackground(child: navigationShell)),
          ],
        ),
      );
    }

    return Scaffold(
      body: AppBackground(child: navigationShell),
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: _select,
        destinations: [
          for (final item in _navItems)
            NavigationDestination(
              icon: Icon(item.icon),
              selectedIcon: Icon(item.selectedIcon),
              label: item.label,
            ),
        ],
      ),
    );
  }
}

/// The desktop navigation rail: the ARTIZEN wordmark, the five sections (the
/// active one on a violet→magenta pill), and the company card pinned to the
/// bottom.
class _Sidebar extends ConsumerWidget {
  const _Sidebar({required this.currentIndex, required this.onSelect});

  final int currentIndex;
  final ValueChanged<int> onSelect;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final company = ref.watch(brandingProfileNotifierProvider).valueOrNull?.company;

    return Container(
      width: 250,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: ArtizenGradients.sidebar,
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const _SidebarBrand(),
            const SizedBox(height: ArtizenSpacing.md),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(
                  horizontal: ArtizenSpacing.sm,
                ),
                children: [
                  for (var i = 0; i < _navItems.length; i++)
                    _SidebarItem(
                      item: _navItems[i],
                      selected: i == currentIndex,
                      onTap: () => onSelect(i),
                    ),
                ],
              ),
            ),
            _SidebarCompanyCard(
              name: company?.name?.trim().isNotEmpty == true
                  ? company!.name!.trim()
                  : 'Mon entreprise',
              subtitle: company?.legalForm?.trim().isNotEmpty == true
                  ? company!.legalForm!.trim()
                  : 'Artisan',
              onTap: () => context.push('/company-profile'),
            ),
          ],
        ),
      ),
    );
  }
}

class _SidebarBrand extends StatelessWidget {
  const _SidebarBrand();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        ArtizenSpacing.sm,
        ArtizenSpacing.md,
        ArtizenSpacing.sm,
        0,
      ),
      child: Column(
        children: [
          // A gold triangle mark standing in for the ARTIZEN "A".
          const Icon(Icons.change_history, color: ArtizenColors.gold, size: 34),
          const SizedBox(height: ArtizenSpacing.xs),
          const Text(
            'ARTIZEN',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: AppTheme.displayFontFamily,
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w700,
              letterSpacing: 4,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'LE DEVIS MAÎTRISÉ,\nL’ARTISAN LIBÉRÉ',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: ArtizenColors.gold.withValues(alpha: 0.85),
              fontSize: 8.5,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.5,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

class _SidebarItem extends StatelessWidget {
  const _SidebarItem({
    required this.item,
    required this.selected,
    required this.onTap,
  });

  final _NavItem item;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(ArtizenRadii.button),
          child: Ink(
            decoration: BoxDecoration(
              gradient: selected
                  ? const LinearGradient(colors: ArtizenGradients.primary)
                  : null,
              borderRadius: BorderRadius.circular(ArtizenRadii.button),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 13,
              ),
              child: Row(
                children: [
                  Icon(
                    selected ? item.selectedIcon : item.icon,
                    size: 22,
                    color: selected
                        ? Colors.white
                        : Colors.white.withValues(alpha: 0.72),
                  ),
                  const SizedBox(width: ArtizenSpacing.sm),
                  Expanded(
                    child: Text(
                      item.label,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: AppTheme.fontFamily,
                        fontSize: 15,
                        fontWeight: selected
                            ? FontWeight.w600
                            : FontWeight.w500,
                        color: selected
                            ? Colors.white
                            : Colors.white.withValues(alpha: 0.72),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SidebarCompanyCard extends StatelessWidget {
  const _SidebarCompanyCard({
    required this.name,
    required this.subtitle,
    required this.onTap,
  });

  final String name;
  final String subtitle;
  final VoidCallback onTap;

  String get _initials {
    final words = name.split(RegExp(r'\s+')).where((w) => w.isNotEmpty).toList();
    if (words.isEmpty) return '?';
    if (words.length == 1) return words.first.characters.first.toUpperCase();
    return (words[0].characters.first + words[1].characters.first).toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(ArtizenSpacing.sm),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(ArtizenRadii.card),
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(ArtizenRadii.card),
              border: Border.all(color: Colors.white.withValues(alpha: 0.10)),
            ),
            child: Row(
              children: [
                Container(
                  width: 38,
                  height: 38,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: ArtizenColors.gold, width: 1.4),
                  ),
                  child: Text(
                    _initials,
                    style: const TextStyle(
                      color: ArtizenColors.gold,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        name,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        subtitle,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.6),
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  color: Colors.white.withValues(alpha: 0.5),
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
