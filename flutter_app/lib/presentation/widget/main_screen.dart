import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

class MainScreen extends HookWidget {
  static const routeName = '/triage';
  final Widget child;

  const MainScreen({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: const _BottomNav(),
    );
  }
}

class _BottomNav extends HookWidget {
  const _BottomNav();

  // maps each tab to its route
  static const _tabs = [
    _TabItem(
      route: '/triage',
      label: 'Triage',
      icon: Icons.dashboard_outlined,
      activeIcon: Icons.dashboard,
    ),
    _TabItem(
      route: '/assessment',
      label: 'Assessments',
      icon: Icons.medical_services_outlined,
      activeIcon: Icons.medical_services,
    ),
    _TabItem(
      route: '/resources',
      label: 'Resources',
      icon: Icons.menu_book_outlined,
      activeIcon: Icons.menu_book,
    ),
    _TabItem(
      route: '/history',
      label: 'History',
      icon: Icons.history_outlined,
      activeIcon: Icons.history,
    ),
  ];

  // finds which tab is active based on current location
  int _currentIndex(BuildContext context) {
    final location = GoRouterState.of(context).matchedLocation;
    for (int i = 0; i < _tabs.length; i++) {
      if (location.startsWith(_tabs[i].route)) return i;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = _currentIndex(context);
    final primary = Theme.of(context).colorScheme.primary;

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 64,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(_tabs.length, (index) {
              final tab = _tabs[index];
              final isActive = currentIndex == index;

              return Expanded(
                child: InkWell(
                  onTap: () => context.go(tab.route),
                  splashColor: primary.withOpacity(0.1),
                  highlightColor: Colors.transparent,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeInOut,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // active indicator dot
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          height: 3,
                          width: isActive ? 24 : 0,
                          margin: const EdgeInsets.only(bottom: 4),
                          decoration: BoxDecoration(
                            color: primary,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),

                        Icon(
                          isActive ? tab.activeIcon : tab.icon,
                          color: isActive ? primary : Colors.grey.shade400,
                          size: 22,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          tab.label,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight:
                                isActive ? FontWeight.w600 : FontWeight.w400,
                            color: isActive ? primary : Colors.grey.shade400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class _TabItem {
  final String route;
  final String label;
  final IconData icon;
  final IconData activeIcon;

  const _TabItem({
    required this.route,
    required this.label,
    required this.icon,
    required this.activeIcon,
  });
}
