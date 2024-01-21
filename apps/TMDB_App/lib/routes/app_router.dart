import "dart:async";
import "package:common_widgets/widgets/youtube_video.dart";
import "package:flutter/material.dart";
import "package:get_it/get_it.dart";
import "package:go_router/go_router.dart";
import "package:tmdb_app/constants/hive_key.dart";
import "package:tmdb_app/data_storage/hive_manager.dart";
import 'package:tmdb_app/features/authentication_feature/presentation/screens/authentication_screen.dart';
import "package:tmdb_app/features/home_feature/presentation/screens/home_screen.dart";
import "package:tmdb_app/features/movie_detail_feature/presentation/screens/movie_detail_screen.dart";
import "package:tmdb_app/routes/route_name.dart";
import "package:tmdb_app/routes/route_param.dart";

class AppRouter {
  static GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
  static GlobalKey<NavigatorState> _homeRouterKey = GlobalKey<NavigatorState>();

  static GoRouter goRouter = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: RouteName.login,
    debugLogDiagnostics: true,
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return ScaffoldWithNestedNavigation(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            navigatorKey: _homeRouterKey,
            routes: [
              GoRoute(
                path: RouteName.home,
                builder: (ctx, state) {
                  return HomeScreen();
                },
                routes: [
                  GoRoute(
                    name: RouteName.movie,
                    path: "${RouteName.movie}/:${RouteParam.id}",
                    builder: (ctx, state) {
                      final movieId = state.pathParameters[RouteParam.id] ?? "";
                      return MovieDetailScreen(key: ValueKey(movieId), movieId: movieId);
                    },
                    routes: [
                      GoRoute(
                        name: RouteName.youtubeVideo,
                        path: "${RouteName.youtubeVideo}/:${RouteParam.videoId}",
                        builder: (ctx, state) {
                          final id = state.pathParameters[RouteParam.videoId] ?? "";
                          return YoutubeVideo(id: id);
                        },
                      )
                    ],
                  ),
                ],
              ),
            ],
          )
        ],
      ),
      GoRoute(
        path: RouteName.login,
        redirect: (ctx, s) {
          return shouldRedirectToHomeScreenIfLoggedIn(ctx, s);
        },
        builder: (ctx, state) {
          return AuthenticationScreen();
        },
      ),
    ],
  );

  static FutureOr<String?> shouldRedirectToHomeScreenIfLoggedIn(
    BuildContext c,
    GoRouterState s,
  ) async {
    final sessionId = await GetIt.instance.get<HiveManager>().getString(HiveKey.sessionId);
    if (sessionId.isNotEmpty) {
      return RouteName.home;
    }
    return null;
  }
}

// Stateful navigation based on:
// https://github.com/flutter/packages/blob/main/packages/go_router/example/lib/stateful_shell_route.dart
class ScaffoldWithNestedNavigation extends StatelessWidget {
  const ScaffoldWithNestedNavigation({
    Key? key,
    required this.navigationShell,
  }) : super(key: key ?? const ValueKey<String>('ScaffoldWithNestedNavigation'));
  final StatefulNavigationShell navigationShell;

  void _goBranch(int index) {
    navigationShell.goBranch(
      index,
      // A common pattern when using bottom navigation bars is to support
      // navigating to the initial location when tapping the item that is
      // already active. This example demonstrates how to support this behavior,
      // using the initialLocation parameter of goBranch.
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < 450) {
        return ScaffoldWithNavigationBar(
          body: navigationShell,
          selectedIndex: navigationShell.currentIndex,
          onDestinationSelected: _goBranch,
        );
      } else {
        return ScaffoldWithNavigationRail(
          body: navigationShell,
          selectedIndex: navigationShell.currentIndex,
          onDestinationSelected: _goBranch,
        );
      }
    });
  }
}

class ScaffoldWithNavigationBar extends StatelessWidget {
  const ScaffoldWithNavigationBar({
    super.key,
    required this.body,
    required this.selectedIndex,
    required this.onDestinationSelected,
  });

  final Widget body;
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body,
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        destinations: const [
          NavigationDestination(label: 'Section A', icon: Icon(Icons.home)),
          NavigationDestination(label: 'Section B', icon: Icon(Icons.settings)),
        ],
        onDestinationSelected: onDestinationSelected,
      ),
    );
  }
}

class ScaffoldWithNavigationRail extends StatelessWidget {
  const ScaffoldWithNavigationRail({
    super.key,
    required this.body,
    required this.selectedIndex,
    required this.onDestinationSelected,
  });

  final Widget body;
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: selectedIndex,
            onDestinationSelected: onDestinationSelected,
            labelType: NavigationRailLabelType.all,
            destinations: const <NavigationRailDestination>[
              NavigationRailDestination(
                label: Text(""),
                icon: Icon(Icons.home),
              ),
              NavigationRailDestination(
                label: Text(""),
                icon: Icon(Icons.settings),
              ),
            ],
          ),
          const VerticalDivider(thickness: 1, width: 1),
          // This is the main content.
          Expanded(
            child: body,
          ),
        ],
      ),
    );
  }
}
