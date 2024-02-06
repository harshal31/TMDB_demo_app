import "dart:async";

import "package:common_widgets/localizations/localized_extension.dart";
import "package:common_widgets/widgets/youtube_video.dart";
import "package:flutter/material.dart";
import "package:get_it/get_it.dart";
import "package:go_router/go_router.dart";
import "package:tmdb_app/constants/hive_key.dart";
import "package:tmdb_app/data_storage/hive_manager.dart";
import 'package:tmdb_app/features/authentication_feature/presentation/screens/authentication_screen.dart';
import "package:tmdb_app/features/company_media_screen/company_tv_shows_screen.dart";
import "package:tmdb_app/features/company_media_screen/compnay_movie_screen.dart";
import "package:tmdb_app/features/home_feature/presentation/screens/home_screen.dart";
import "package:tmdb_app/features/keyword_media_screen/keyword_movie_screen.dart";
import "package:tmdb_app/features/keyword_media_screen/keyword_tv_shows_screen.dart";
import "package:tmdb_app/features/movie_detail_feature/presentation/screens/movie_detail_screen.dart";
import "package:tmdb_app/features/network_media_screen/network_tv_shows_screen.dart";
import "package:tmdb_app/features/person_detail_feature/presentation/screens/person_detail_screen.dart";
import "package:tmdb_app/features/persons_listing_feature/person_listing_screen.dart";
import "package:tmdb_app/features/search_feature/presentation/screens/search_screen.dart";
import "package:tmdb_app/features/tv_detail_feature/presentation/screens/tv_detail_screen.dart";
import "package:tmdb_app/routes/route_name.dart";
import "package:tmdb_app/routes/route_param.dart";

class AppRouter {
  static GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
  static GlobalKey<NavigatorState> _homeRouterKey = GlobalKey<NavigatorState>();

  static GoRouter goRouter = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: RouteName.home,
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
                  return const HomeScreen();
                },
                routes: [
                  GoRoute(
                    path: "${RouteName.search}/:${RouteParam.searchType}",
                    pageBuilder: (ctx, state) {
                      final path = state.pathParameters[RouteParam.searchType] ?? "";
                      final searchQuery = state.uri.queryParameters[RouteParam.query] ?? "";

                      return animatedPage(
                        ctx,
                        state,
                        widget: SearchScreen(
                          searchType: path,
                          key: ValueKey(path + searchQuery),
                          query: searchQuery,
                        ),
                      );
                    },
                  ),
                  GoRoute(
                    path: "${RouteName.keywords}/${RouteParam.movie}/:${RouteParam.id}",
                    pageBuilder: (ctx, state) {
                      final keywordType = (state.extra is String ? state.extra as String : "");
                      final keywordId = state.pathParameters[RouteParam.id] ?? "";

                      return animatedPage(
                        ctx,
                        state,
                        widget: KeywordMoviesScreen(
                          keywordName: keywordType,
                          keywordId: keywordId,
                          key: state.pageKey,
                        ),
                      );
                    },
                  ),
                  GoRoute(
                    path: "${RouteName.keywords}/${RouteParam.tv}/:${RouteParam.id}",
                    pageBuilder: (ctx, state) {
                      final keywordType = (state.extra is String ? state.extra as String : "");
                      final keywordId = state.pathParameters[RouteParam.id] ?? "";

                      return animatedPage(
                        ctx,
                        state,
                        widget: KeywordTvShowsScreen(
                          keywordName: keywordType,
                          keywordId: keywordId,
                          key: state.pageKey,
                        ),
                      );
                    },
                  ),
                  GoRoute(
                    path: "${RouteName.company}/${RouteParam.movie}/:${RouteParam.id}",
                    pageBuilder: (ctx, state) {
                      final companyName = (state.extra is String ? state.extra as String : "");
                      final companyId = state.pathParameters[RouteParam.id] ?? "";

                      return animatedPage(
                        ctx,
                        state,
                        widget: CompanyMoviesScreen(
                          companyName: companyName,
                          companyId: companyId,
                          key: state.pageKey,
                        ),
                      );
                    },
                  ),
                  GoRoute(
                    path: "${RouteName.company}/${RouteParam.tv}/:${RouteParam.id}",
                    pageBuilder: (ctx, state) {
                      final companyName = (state.extra is String ? state.extra as String : "");
                      final companyId = state.pathParameters[RouteParam.id] ?? "";

                      return animatedPage(
                        ctx,
                        state,
                        widget: CompanyTvShowsScreen(
                          companyName: companyName,
                          companyId: companyId,
                          key: state.pageKey,
                        ),
                      );
                    },
                  ),
                  GoRoute(
                    path: "${RouteName.network}/${RouteParam.tv}/:${RouteParam.id}",
                    pageBuilder: (ctx, state) {
                      final networkName = (state.extra is String ? state.extra as String : "");
                      final networkId = state.pathParameters[RouteParam.id] ?? "";

                      return animatedPage(
                        ctx,
                        state,
                        widget: NetworkTvShowsScreen(
                          networkName: networkName,
                          networkId: networkId,
                          key: state.pageKey,
                        ),
                      );
                    },
                  ),
                  GoRoute(
                    path: "${RouteName.movie}/:${RouteParam.id}",
                    pageBuilder: (ctx, state) {
                      final movieId = state.pathParameters[RouteParam.id] ?? "";
                      return animatedPage(
                        ctx,
                        state,
                        widget: MovieDetailScreen(key: ValueKey(movieId), movieId: movieId),
                      );
                    },
                    routes: [
                      GoRoute(
                        path: "${RouteName.youtubeVideo}/:${RouteParam.videoId}",
                        pageBuilder: (ctx, state) {
                          final id = state.pathParameters[RouteParam.videoId] ?? "";
                          return animatedPage(
                            ctx,
                            state,
                            widget: YoutubeVideo(id: id),
                          );
                        },
                      )
                    ],
                  ),
                  GoRoute(
                    name: RouteName.tv,
                    path: "${RouteName.tv}/:${RouteParam.id}",
                    pageBuilder: (ctx, state) {
                      final seriesId = state.pathParameters[RouteParam.id] ?? "";
                      return animatedPage(
                        ctx,
                        state,
                        widget: TvDetailScreen(key: ValueKey(seriesId), seriesId: seriesId),
                      );
                    },
                    routes: [
                      GoRoute(
                        path: "${RouteName.youtubeVideo}/:${RouteParam.videoId}",
                        pageBuilder: (ctx, state) {
                          final id = state.pathParameters[RouteParam.videoId] ?? "";
                          return animatedPage(
                            ctx,
                            state,
                            widget: YoutubeVideo(id: id),
                          );
                        },
                      )
                    ],
                  ),
                  GoRoute(
                    path: "${RouteName.person}",
                    pageBuilder: (ctx, state) {
                      return animatedPage(
                        ctx,
                        state,
                        widget: const PersonListingScreen(),
                      );
                    },
                    routes: [
                      GoRoute(
                        path: ":${RouteParam.id}",
                        pageBuilder: (ctx, state) {
                          final personId = state.pathParameters[RouteParam.id] ?? "";
                          return animatedPage(
                            ctx,
                            state,
                            widget: PersonDetailScreen(key: ValueKey(personId), personId: personId),
                          );
                        },
                      ),
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

  static Page<dynamic> animatedPage(
    BuildContext ctx,
    GoRouterState state, {
    required Widget widget,
  }) {
    return CustomTransitionPage<void>(
      key: state.pageKey,
      child: widget,
      transitionDuration: const Duration(milliseconds: 200),
      reverseTransitionDuration: const Duration(milliseconds: 200),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
    );
  }

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

class ScaffoldWithNestedNavigation extends StatelessWidget {
  const ScaffoldWithNestedNavigation({
    Key? key,
    required this.navigationShell,
  }) : super(key: key ?? const ValueKey<String>('ScaffoldWithNestedNavigation'));
  final StatefulNavigationShell navigationShell;

  void _goBranch(int index) {
    navigationShell.goBranch(
      index,
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
        destinations: [
          NavigationDestination(
            label: context.tr.home,
            icon: const Icon(Icons.home_filled),
          ),
          NavigationDestination(
            label: context.tr.profile,
            icon: const Icon(Icons.person_pin),
          ),
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
            destinations: const [
              NavigationRailDestination(
                label: Text(""),
                icon: Icon(Icons.home_filled),
              ),
              NavigationRailDestination(
                label: Text(""),
                icon: Icon(Icons.person_pin),
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
