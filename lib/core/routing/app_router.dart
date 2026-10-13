import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:dabawenyos/core/theme/app_theme.dart';
import 'package:dabawenyos/features/splash/presentation/splash_screen.dart';
import 'package:dabawenyos/features/home/presentation/home_screen.dart';
import 'package:dabawenyos/features/reports/presentation/reports_screen.dart';
import 'package:dabawenyos/features/reports/presentation/create_report_screen.dart';
import 'package:dabawenyos/features/announcements/presentation/announcements_screen.dart';
import 'package:dabawenyos/features/emergency/presentation/emergency_screen.dart';
import 'package:dabawenyos/features/explore/presentation/explore_screen.dart';
import 'package:dabawenyos/features/events/presentation/events_screen.dart';
import 'package:dabawenyos/features/explore/presentation/jobs_screen.dart';
import 'package:dabawenyos/features/explore/presentation/marketplace_screen.dart';
import 'package:dabawenyos/features/explore/presentation/directory_screen.dart';
import 'package:dabawenyos/features/explore/presentation/traffic_flood_screen.dart';
import 'package:dabawenyos/features/profile/presentation/profile_screen.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey<NavigatorState>();

final appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: '/splash',
      builder: (context, state) => const SplashScreen(),
    ),
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) {
        return ScaffoldWithNavBar(child: child);
      },
      routes: [
        GoRoute(
          path: '/home',
          pageBuilder: (context, state) => const NoTransitionPage(
            child: HomeScreen(),
          ),
        ),
        GoRoute(
          path: '/explore',
          pageBuilder: (context, state) => const NoTransitionPage(
            child: ExploreScreen(),
          ),
        ),
        GoRoute(
          path: '/reports',
          pageBuilder: (context, state) => const NoTransitionPage(
            child: ReportsScreen(),
          ),
        ),
        GoRoute(
          path: '/updates',
          pageBuilder: (context, state) => const NoTransitionPage(
            child: AnnouncementsScreen(),
          ),
        ),
        GoRoute(
          path: '/profile',
          pageBuilder: (context, state) => const NoTransitionPage(
            child: ProfileScreen(),
          ),
        ),
      ],
    ),
    GoRoute(
      path: '/create-report',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const CreateReportScreen(),
    ),
    GoRoute(
      path: '/emergency',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const EmergencyScreen(),
    ),
    GoRoute(
      path: '/events',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const EventsScreen(),
    ),
    GoRoute(
      path: '/jobs',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const JobsScreen(),
    ),
    GoRoute(
      path: '/marketplace',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const MarketplaceScreen(),
    ),
    GoRoute(
      path: '/directory',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const DirectoryScreen(),
    ),
    GoRoute(
      path: '/traffic-flood',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const TrafficFloodScreen(),
    ),
  ],
);

class ScaffoldWithNavBar extends StatelessWidget {
  final Widget child;

  const ScaffoldWithNavBar({super.key, required this.child});

  int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.path;
    if (location.startsWith('/home')) return 0;
    if (location.startsWith('/explore')) return 1;
    if (location.startsWith('/reports')) return 2;
    if (location.startsWith('/updates')) return 3;
    if (location.startsWith('/profile')) return 4;
    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.go('/home');
        break;
      case 1:
        context.go('/explore');
        break;
      case 2:
        context.go('/reports');
        break;
      case 3:
        context.go('/updates');
        break;
      case 4:
        context.go('/profile');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedIndex = _calculateSelectedIndex(context);

    return Scaffold(
      body: child,
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(color: AppColors.border, width: 1),
          ),
        ),
        child: NavigationBar(
          selectedIndex: selectedIndex,
          onDestinationSelected: (index) => _onItemTapped(index, context),
          backgroundColor: Colors.white,
          indicatorColor: AppColors.primarySurface,
          elevation: 0,
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home, color: AppColors.primary),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.explore_outlined),
              selectedIcon: Icon(Icons.explore, color: AppColors.primary),
              label: 'Explore',
            ),
            NavigationDestination(
              icon: Icon(Icons.report_problem_outlined),
              selectedIcon: Icon(Icons.report_problem, color: AppColors.primary),
              label: 'Report',
            ),
            NavigationDestination(
              icon: Icon(Icons.newspaper_outlined),
              selectedIcon: Icon(Icons.newspaper, color: AppColors.primary),
              label: 'Updates',
            ),
            NavigationDestination(
              icon: Icon(Icons.person_outline),
              selectedIcon: Icon(Icons.person, color: AppColors.primary),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
