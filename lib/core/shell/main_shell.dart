import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MainShell extends StatelessWidget {
  final Widget child;

  const MainShell({super.key, required this.child});

  int _currentIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;
    if (location.startsWith('/timer')) return 0;
    if (location.startsWith('/explore')) return 1;
    if (location.startsWith('/stats')) return 2;
    if (location.startsWith('/achievements')) return 3;
    if (location.startsWith('/profile')) return 4;
    return 0;
  }

  void _onTap(BuildContext context, int index) {
    HapticFeedback.selectionClick();
    switch (index) {
      case 0:
        context.go('/timer');
      case 1:
        context.go('/explore');
      case 2:
        context.go('/stats');
      case 3:
        context.go('/achievements');
      case 4:
        context.go('/profile');
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = _currentIndex(context);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: child,
      bottomNavigationBar: SafeArea(
        top: false,
        child: NavigationBar(
          selectedIndex: currentIndex,
          onDestinationSelected: (index) => _onTap(context, index),
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          destinations: [
            NavigationDestination(
              icon: PhosphorIcon(PhosphorIcons.house()),
              selectedIcon: PhosphorIcon(
                PhosphorIcons.house(PhosphorIconsStyle.fill),
              ),
              label: l10n.tab_timer,
            ),
            NavigationDestination(
              icon: PhosphorIcon(PhosphorIcons.compass()),
              selectedIcon: PhosphorIcon(
                PhosphorIcons.compass(PhosphorIconsStyle.fill),
              ),
              label: l10n.tab_explore,
            ),
            NavigationDestination(
              icon: PhosphorIcon(PhosphorIcons.chartBar()),
              selectedIcon: PhosphorIcon(
                PhosphorIcons.chartBar(PhosphorIconsStyle.fill),
              ),
              label: l10n.tab_stats,
            ),
            NavigationDestination(
              icon: PhosphorIcon(PhosphorIcons.trophy()),
              selectedIcon: PhosphorIcon(
                PhosphorIcons.trophy(PhosphorIconsStyle.fill),
              ),
              label: l10n.tab_achievements,
            ),
            NavigationDestination(
              icon: PhosphorIcon(PhosphorIcons.user()),
              selectedIcon: PhosphorIcon(
                PhosphorIcons.user(PhosphorIconsStyle.fill),
              ),
              label: l10n.tab_profile,
            ),
          ],
        ),
      ),
    );
  }
}
