import "dart:async";
import "package:flutter/material.dart";
import "package:get_it/get_it.dart";
import "package:go_router/go_router.dart";
import "package:tmdb_app/constants/hive_key.dart";
import "package:tmdb_app/data_storage/hive_manager.dart";
import 'package:tmdb_app/features/authentication_feature/presentation/screens/authentication_screen.dart';
import "package:tmdb_app/features/home_feature/presentation/screens/home_screen.dart";
import "package:tmdb_app/routes/route_name.dart";

class AppRouter {
  static GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

  static GoRouter goRouter = GoRouter(
    redirect: shouldRedirectToHomeScreenIfLoggedIn,
    navigatorKey: _rootNavigatorKey,
    initialLocation: RouteName.login,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: RouteName.login,
        builder: (ctx, state) {
          return AuthenticationScreen();
        },
      ),
      GoRoute(
        path: RouteName.home,
        builder: (ctx, state) {
          return HomeScreen();
        },
      ),
    ],
  );

  static FutureOr<String?> shouldRedirectToHomeScreenIfLoggedIn(
    BuildContext c,
    GoRouterState s,
  ) async {
    final sessionId =
        await GetIt.instance.get<HiveManager>().getString(HiveKey.sessionId);
    if (sessionId.isNotEmpty) {
      return RouteName.home;
    }
    return null;
  }
}
