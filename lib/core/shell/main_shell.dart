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
    if (location.startsWith('/stats')) return 1;
    if (location.startsWith('/meals')) return 2;
    if (location.startsWith('/profile')) return 3;
    return 0;
  }

  void _onTap(BuildContext context, int index) {
    HapticFeedback.selectionClick();
    switch (index) {
      case 0:
        context.go('/timer');
      case 1:
        context.go('/stats');
      case 2:
        context.go('/meals');
      case 3:
        context.go('/profile');
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = _currentIndex(context);
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: child,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: theme.dividerTheme.color ?? Colors.transparent,
              width: 0.5,
            ),
          ),
        ),
        child: NavigationBar(
          selectedIndex: currentIndex,
          onDestinationSelected: (index) => _onTap(context, index),
          backgroundColor: theme.bottomNavigationBarTheme.backgroundColor,
          indicatorColor: theme.colorScheme.primary.withValues(alpha:0.1),
          height: 65,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          destinations: [
            NavigationDestination(
              icon: PhosphorIcon(PhosphorIcons.timer()),
              selectedIcon: PhosphorIcon(PhosphorIcons.timer(PhosphorIconsStyle.fill)),
              label: l10n.tab_timer,
            ),
            NavigationDestination(
              icon: PhosphorIcon(PhosphorIcons.chartBar()),
              selectedIcon: PhosphorIcon(PhosphorIcons.chartBar(PhosphorIconsStyle.fill)),
              label: l10n.tab_stats,
            ),
            NavigationDestination(
              icon: PhosphorIcon(PhosphorIcons.forkKnife()),
              selectedIcon: PhosphorIcon(PhosphorIcons.forkKnife(PhosphorIconsStyle.fill)),
              label: l10n.tab_meals,
            ),
            NavigationDestination(
              icon: PhosphorIcon(PhosphorIcons.user()),
              selectedIcon: PhosphorIcon(PhosphorIcons.user(PhosphorIconsStyle.fill)),
              label: l10n.tab_profile,
            ),
          ],
        ),
      ),
    );
  }
}
