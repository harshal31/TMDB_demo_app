import "dart:async";

import "package:common_widgets/localizations/localized_extension.dart";
import "package:common_widgets/widgets/wrapped_text.dart";
import "package:common_widgets/widgets/youtube_video.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:get_it/get_it.dart";
import "package:go_router/go_router.dart";
import "package:tmdb_app/app_level_provider/bottom_nav_cubit.dart";
import "package:tmdb_app/constants/hive_key.dart";
import "package:tmdb_app/data_storage/hive_manager.dart";
import 'package:tmdb_app/features/authentication_feature/presentation/screens/authentication_screen.dart';
import "package:tmdb_app/features/cast_crew_listing_feature/presentation/cast_crew_screen.dart";
import "package:tmdb_app/features/company_media_screen/company_tv_shows_screen.dart";
import "package:tmdb_app/features/company_media_screen/compnay_movie_screen.dart";
import "package:tmdb_app/features/home_feature/presentation/screens/home_screen.dart";
import "package:tmdb_app/features/keyword_media_screen/keyword_movie_screen.dart";
import "package:tmdb_app/features/keyword_media_screen/keyword_tv_shows_screen.dart";
import "package:tmdb_app/features/media_listing_feature/media_listing_screen.dart";
import "package:tmdb_app/features/movie_detail_feature/data/model/media_detail.dart";
import "package:tmdb_app/features/movie_detail_feature/presentation/screens/movie_detail_screen.dart";
import "package:tmdb_app/features/network_media_screen/network_tv_shows_screen.dart";
import "package:tmdb_app/features/person_detail_feature/presentation/screens/person_detail_screen.dart";
import "package:tmdb_app/features/persons_listing_feature/person_listing_screen.dart";
import "package:tmdb_app/features/profile_feature/profile_screen.dart";
import "package:tmdb_app/features/reviews_listing_feature/reviews_listing_screen.dart";
import "package:tmdb_app/features/search_feature/presentation/screens/search_detail_screen/search_detail_screen.dart";
import "package:tmdb_app/features/search_feature/presentation/screens/search_screen/search_screen.dart";
import "package:tmdb_app/features/tmdb_media_feature/screens/video_listing_screen/poster_backdrop_screen_detail.dart";
import "package:tmdb_app/features/tmdb_media_feature/screens/video_listing_screen/tmdb_media_youtube_media_listing.dart";
import "package:tmdb_app/features/tv_detail_feature/presentation/screens/tv_detail_screen.dart";
import "package:tmdb_app/routes/route_name.dart";
import "package:tmdb_app/routes/route_param.dart";

class AppRouter {
  static GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
  static GlobalKey<NavigatorState> _homeRouterKey = GlobalKey<NavigatorState>();
  static GlobalKey<NavigatorState> _profileRouterKey = GlobalKey<NavigatorState>();
  static GlobalKey<NavigatorState> _searchRouterKey = GlobalKey<NavigatorState>();

  static GoRouter goRouter = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: RouteName.login,
    debugLogDiagnostics: true,
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          _changeBottomNavVisibility(context);
          return ScaffoldWithNestedNavigation(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            navigatorKey: _homeRouterKey,
            routes: [
              GoRoute(
                redirect: _shouldRedirectToLoginScreenIfNotLoggedIn,
                path: RouteName.home,
                builder: (ctx, state) {
                  return const HomeScreen();
                },
                routes: [
                  GoRoute(
                    path: "${RouteName.keywords}/${RouteParam.movie}/:${RouteParam.id}",
                    pageBuilder: (ctx, state) {
                      final keywordType = (state.extra is String ? state.extra as String : "");
                      final keywordId = state.pathParameters[RouteParam.id] ?? "";

                      return _animatedPage(
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

                      return _animatedPage(
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

                      return _animatedPage(
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

                      return _animatedPage(
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

                      return _animatedPage(
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
                    path: RouteName.movie,
                    pageBuilder: (ctx, state) {
                      return _animatedPage(
                        ctx,
                        state,
                        widget: const MediaListingScreen(isMovies: true),
                      );
                    },
                    routes: [
                      GoRoute(
                        path: ":${RouteParam.id}",
                        pageBuilder: (ctx, state) {
                          final movieId = state.pathParameters[RouteParam.id] ?? "";
                          return _animatedPage(
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
                              return _animatedPage(
                                ctx,
                                state,
                                widget: YoutubeVideo(id: id),
                              );
                            },
                          ),
                          GoRoute(
                            path: RouteName.reviews,
                            pageBuilder: (ctx, state) {
                              final movieId = state.pathParameters[RouteParam.id] ?? "";
                              return _animatedPage(
                                ctx,
                                state,
                                widget: ReviewsListingScreen(
                                  mediaId: movieId,
                                  isMovies: true,
                                ),
                              );
                            },
                          ),
                          GoRoute(
                            path: RouteName.cast,
                            pageBuilder: (ctx, state) {
                              final tvId = state.pathParameters[RouteParam.id] ?? "";
                              return _animatedPage(
                                ctx,
                                state,
                                widget: CastCrewScreen(
                                  isMovies: true,
                                  mediaId: tvId,
                                ),
                              );
                            },
                          ),
                          GoRoute(
                            path: RouteName.videos,
                            pageBuilder: (ctx, state) {
                              final movieId = state.pathParameters[RouteParam.id] ?? "";
                              return _animatedPage(
                                ctx,
                                state,
                                widget: TmdbYoutubeMediaListingScreen(
                                  mediaId: movieId,
                                  isMovies: true,
                                ),
                              );
                            },
                            routes: [
                              GoRoute(
                                path: "${RouteName.youtubeVideo}/:${RouteParam.videoId}",
                                pageBuilder: (ctx, state) {
                                  final id = state.pathParameters[RouteParam.videoId] ?? "";
                                  return _animatedPage(
                                    ctx,
                                    state,
                                    widget: YoutubeVideo(id: id),
                                  );
                                },
                              )
                            ],
                          ),
                          GoRoute(
                            path: RouteName.backdrops,
                            pageBuilder: (ctx, state) {
                              final movieId = state.pathParameters[RouteParam.id] ?? "";
                              return _animatedPage(
                                ctx,
                                state,
                                widget: Container(),
                              );
                            },
                            routes: [
                              GoRoute(
                                path: ":${RouteParam.backdrop}",
                                pageBuilder: (ctx, state) {
                                  final movieId = state.pathParameters[RouteParam.id] ?? "";
                                  final index = int.parse(
                                    state.pathParameters[RouteParam.backdrop] ?? "0",
                                  );
                                  final mediaDetail = state.extra is MediaDetail
                                      ? state.extra as MediaDetail
                                      : null;

                                  return _animatedPage(
                                    ctx,
                                    state,
                                    widget: PosterBackdropScreenDetail(
                                      mediaDetail: mediaDetail,
                                      mediaId: movieId,
                                      gotToIndex: index,
                                      isMovies: true,
                                      isPosters: false,
                                    ),
                                  );
                                },
                              )
                            ],
                          ),
                          GoRoute(
                            path: RouteName.posters,
                            pageBuilder: (ctx, state) {
                              final movieId = state.pathParameters[RouteParam.id] ?? "";
                              return _animatedPage(
                                ctx,
                                state,
                                widget: Container(),
                              );
                            },
                            routes: [
                              GoRoute(
                                path: ":${RouteParam.poster}",
                                pageBuilder: (ctx, state) {
                                  final movieId = state.pathParameters[RouteParam.id] ?? "";
                                  final index = int.parse(
                                    state.pathParameters[RouteParam.backdrop] ?? "0",
                                  );
                                  final mediaDetail = state.extra is MediaDetail
                                      ? state.extra as MediaDetail
                                      : null;

                                  return _animatedPage(
                                    ctx,
                                    state,
                                    widget: PosterBackdropScreenDetail(
                                      mediaDetail: mediaDetail,
                                      mediaId: movieId,
                                      gotToIndex: index,
                                      isMovies: true,
                                      isPosters: true,
                                    ),
                                  );
                                },
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  GoRoute(
                    path: RouteName.tv,
                    pageBuilder: (ctx, state) {
                      return _animatedPage(
                        ctx,
                        state,
                        widget: const MediaListingScreen(isMovies: false),
                      );
                    },
                    routes: [
                      GoRoute(
                        path: ":${RouteParam.id}",
                        pageBuilder: (ctx, state) {
                          final seriesId = state.pathParameters[RouteParam.id] ?? "";
                          return _animatedPage(
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
                              return _animatedPage(
                                ctx,
                                state,
                                widget: YoutubeVideo(id: id),
                              );
                            },
                          ),
                          GoRoute(
                            path: RouteName.reviews,
                            pageBuilder: (ctx, state) {
                              final movieId = state.pathParameters[RouteParam.id] ?? "";
                              return _animatedPage(
                                ctx,
                                state,
                                widget: ReviewsListingScreen(
                                  mediaId: movieId,
                                  isMovies: false,
                                ),
                              );
                            },
                          ),
                          GoRoute(
                            path: RouteName.cast,
                            pageBuilder: (ctx, state) {
                              final tvId = state.pathParameters[RouteParam.id] ?? "";
                              return _animatedPage(
                                ctx,
                                state,
                                widget: CastCrewScreen(
                                  isMovies: false,
                                  mediaId: tvId,
                                ),
                              );
                            },
                          ),
                          GoRoute(
                            path: RouteName.videos,
                            pageBuilder: (ctx, state) {
                              final movieId = state.pathParameters[RouteParam.id] ?? "";
                              return _animatedPage(
                                ctx,
                                state,
                                widget: TmdbYoutubeMediaListingScreen(
                                  mediaId: movieId,
                                  isMovies: false,
                                ),
                              );
                            },
                            routes: [
                              GoRoute(
                                path: "${RouteName.youtubeVideo}/:${RouteParam.videoId}",
                                pageBuilder: (ctx, state) {
                                  final id = state.pathParameters[RouteParam.videoId] ?? "";
                                  return _animatedPage(
                                    ctx,
                                    state,
                                    widget: YoutubeVideo(id: id),
                                  );
                                },
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  GoRoute(
                    path: "${RouteName.person}",
                    pageBuilder: (ctx, state) {
                      return _animatedPage(
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
                          return _animatedPage(
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
          ),
          StatefulShellBranch(
            navigatorKey: _searchRouterKey,
            routes: [
              GoRoute(
                path: RouteName.search,
                redirect: _shouldRedirectToLoginScreenIfNotLoggedIn,
                pageBuilder: (ctx, state) {
                  final searchQuery = state.uri.queryParameters[RouteParam.query] ?? "";
                  return _animatedPage(
                    ctx,
                    state,
                    widget: SearchScreen(
                      query: searchQuery.trim(),
                    ),
                  );
                },
                routes: [
                  GoRoute(
                    path: "${RouteName.searchDetail}/:${RouteParam.searchType}",
                    pageBuilder: (ctx, state) {
                      final path = state.pathParameters[RouteParam.searchType] ?? "";
                      final searchQuery = state.uri.queryParameters[RouteParam.query] ?? "";

                      return _animatedPage(
                        ctx,
                        state,
                        widget: SearchDetailScreen(
                          searchType: path,
                          key: ValueKey(path + searchQuery),
                          query: searchQuery,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _profileRouterKey,
            routes: [
              GoRoute(
                path: RouteName.profile,
                redirect: _shouldRedirectToLoginScreenIfNotLoggedIn,
                builder: (ctx, state) {
                  return ProfileScreen();
                },
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: RouteName.login,
        redirect: (ctx, s) {
          return _shouldRedirectToHomeScreenIfLoggedIn(ctx, s);
        },
        builder: (ctx, state) {
          return AuthenticationScreen();
        },
      ),
    ],
  );

  static Page<dynamic> _animatedPage(
    BuildContext ctx,
    GoRouterState state, {
    required Widget widget,
  }) {
    return CustomTransitionPage<void>(
      key: state.pageKey,
      child: widget,
      transitionDuration: const Duration(milliseconds: 300),
      reverseTransitionDuration: const Duration(milliseconds: 300),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        if (kIsWeb) {
          return FadeTransition(opacity: animation, child: child);
        }

        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  static FutureOr<String?> _shouldRedirectToHomeScreenIfLoggedIn(
    BuildContext c,
    GoRouterState s,
  ) async {
    final sessionId = await GetIt.instance.get<HiveManager>().getString(HiveKey.sessionId);
    if (sessionId.isNotEmpty) {
      return RouteName.home;
    }
    return null;
  }

  static FutureOr<String?> _shouldRedirectToLoginScreenIfNotLoggedIn(
    BuildContext c,
    GoRouterState s,
  ) async {
    final sessionId = await GetIt.instance.get<HiveManager>().getString(HiveKey.sessionId);
    if (sessionId.isEmpty) {
      return RouteName.login;
    }
    return null;
  }

  static void _changeBottomNavVisibility(BuildContext context) {
    final pathSegment =
        GoRouter.of(context).routerDelegate.currentConfiguration.last.matchedLocation.split("/");

    context.read<BottomNavCubit>().changeBottomNavVisibility(
        (pathSegment.length == 2 || pathSegment.length == 1) &&
                pathSegment[1] == RouteName.home.replaceAll("/", "") ||
            pathSegment[1] == RouteName.search.replaceAll("/", "") ||
            pathSegment[1] == RouteName.profile.replaceAll("/", ""));
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
      bottomNavigationBar: BlocBuilder<BottomNavCubit, bool>(
        buildWhen: (prev, cur) => prev != cur,
        builder: (context, state) {
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            transitionBuilder: (child, animation) {
              const begin = Offset(0.0, 1.0);
              var tween = Tween(begin: begin, end: Offset.zero).chain(
                CurveTween(curve: Curves.ease),
              );
              return SlideTransition(
                position: animation.drive(tween),
                child: child,
              );
            },
            child: state
                ? NavigationBar(
                    key: UniqueKey(),
                    selectedIndex: selectedIndex,
                    destinations: [
                      NavigationDestination(
                        label: context.tr.home,
                        icon: const Icon(Icons.home),
                      ),
                      NavigationDestination(
                        label: context.tr.search,
                        icon: const Icon(Icons.search),
                      ),
                      NavigationDestination(
                        label: context.tr.profile,
                        icon: const Icon(Icons.emoji_people),
                      ),
                    ],
                    onDestinationSelected: onDestinationSelected,
                  )
                : SizedBox.shrink(key: UniqueKey()),
          );
        },
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
                label: WrappedText(""),
                icon: Icon(Icons.home),
              ),
              NavigationRailDestination(
                label: WrappedText(""),
                icon: Icon(Icons.search),
              ),
              NavigationRailDestination(
                label: WrappedText(""),
                icon: Icon(Icons.emoji_people),
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
