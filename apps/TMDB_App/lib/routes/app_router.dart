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

  static GoRouter goRouter = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: RouteName.login,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: RouteName.login,
        redirect: (ctx, s) {
          return shouldRedirectToHomeScreenIfLoggedIn(ctx, s);
        },
        builder: (ctx, state) {
          return AuthenticationScreen();
        },
      ),
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
              return MovieDetailScreen(movieId: movieId);
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
