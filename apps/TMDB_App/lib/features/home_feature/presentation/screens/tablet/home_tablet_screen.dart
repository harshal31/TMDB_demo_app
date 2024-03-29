import 'package:common_widgets/theme/theme_util.dart';
import 'package:common_widgets/widgets/custom_tab_bar.dart';
import 'package:common_widgets/widgets/switch_icon.dart';
import 'package:common_widgets/widgets/wrapped_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tmdb_app/constants/api_key.dart';
import 'package:tmdb_app/features/home_feature/presentation/cubits/free_to_watch_sec_cubit/free_to_watch_cubit.dart';
import 'package:tmdb_app/features/home_feature/presentation/cubits/latest_sec_cubit/latest_cubit.dart';
import 'package:tmdb_app/features/home_feature/presentation/cubits/latest_sec_cubit/latest_position_cubit.dart';
import 'package:tmdb_app/features/home_feature/presentation/cubits/trending_sec_cubit/trending_cubit.dart';
import 'package:tmdb_app/features/home_feature/presentation/cubits/trending_sec_cubit/trending_position_cubit.dart';
import 'package:tmdb_app/features/home_feature/presentation/use_case/latest_use_case.dart';
import 'package:tmdb_app/features/home_feature/presentation/use_case/movies_advance_filter_use.dart';
import 'package:tmdb_app/features/home_feature/presentation/use_case/trending_use_case.dart';
import 'package:tmdb_app/features/tmdb_widgets/tmdb_horizontal_list.dart';
import 'package:tmdb_app/routes/route_name.dart';
import 'package:tmdb_app/utils/common_navigation.dart';

class HomeTabletScreen extends StatelessWidget {
  const HomeTabletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final trendingCubit = context.read<TrendingCubit>();
    final trendingPosCubit = context.read<TrendingPositionCubit>();
    final latestCubit = context.read<LatestCubit>();
    final latestPosCubit = context.read<LatestPositionCubit>();
    final freeToWatchCubit = context.read<FreeToWatchCubit>();

    return Padding(
      padding: const EdgeInsets.all(16),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: BlocBuilder<TrendingPositionCubit, TrendingPositionState>(
                        builder: (context, state) {
                          return WrappedText(
                            state.getTrendingText(context),
                            style: context.textTheme.displayMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                          );
                        },
                      ),
                    ),
                    BlocBuilder<TrendingPositionCubit, TrendingPositionState>(
                      builder: (context, state) {
                        return Switch(
                          thumbIcon: SwitchIcon.trendingSwitchIcon,
                          value: state.switchState,
                          onChanged: (s) {
                            _trendingSwitchApiCall(
                              s,
                              trendingPosCubit,
                              trendingCubit,
                              state.pos,
                            );
                          },
                        );
                      },
                    )
                  ],
                ),
                const SizedBox(height: 8),
                FittedBox(
                  child: CustomTabBar(
                    titles: trendingPosCubit.state.getTrendingTabTitles(context),
                    isScrollable: true,
                    tabAlignment: TabAlignment.start,
                    selectedColor: context.colorTheme.primaryContainer,
                    onSelectedTab: (pos) {
                      _trendingTabPressApiCall(
                        pos,
                        trendingPosCubit,
                        trendingCubit,
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16),
                BlocBuilder<TrendingCubit, TrendingState>(
                  builder: (context, state) {
                    return AnimatedOpacity(
                      opacity: state.trendingStatus is TrendingDone ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 500),
                      child: SizedBox(
                        height: 225,
                        child: Visibility(
                          visible: state.error?.isEmpty ?? true,
                          replacement: Center(
                            child: WrappedText(
                              state.error,
                              style: context.textTheme.titleLarge,
                            ),
                          ),
                          child: TmdbHorizontalList(
                            imageUrls: state.getImageUrls,
                            onViewAllClick: () {
                              if (trendingPosCubit.state.pos == 0) {
                                context.push("${RouteName.home}/${RouteName.movie}");
                                return;
                              }

                              if (trendingPosCubit.state.pos == 1) {
                                context.push("${RouteName.home}/${RouteName.movie}");
                                return;
                              }

                              if (trendingPosCubit.state.pos == 2) {
                                context.push("${RouteName.home}/${RouteName.tv}");
                                return;
                              }

                              if (trendingPosCubit.state.pos == 3) {
                                context.push("${RouteName.home}/${RouteName.person}");
                                return;
                              }
                            },
                            onItemClick: (i) {
                              CommonNavigation.redirectToDetailScreen(
                                context,
                                mediaType: state.trendingResult?.results?[i].mediaType,
                                mediaId: state.trendingResult?.results?[i].id.toString(),
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 16)),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: BlocBuilder<LatestPositionCubit, LatestPositionState>(
                        builder: (context, state) {
                          return WrappedText(
                            state.getLatestText(context),
                            style: context.textTheme.displayMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    BlocBuilder<LatestPositionCubit, LatestPositionState>(
                      builder: (context, state) {
                        return Switch(
                          thumbIcon: SwitchIcon.latestSwitchIcon,
                          value: state.currentSwitchState,
                          onChanged: (s) {
                            _latestSwitchApiCall(
                              context,
                              s,
                              latestPosCubit,
                              latestCubit,
                              state.pos,
                            );
                          },
                        );
                      },
                    )
                  ],
                ),
                const SizedBox(height: 8),
                FittedBox(
                  child: BlocBuilder<LatestPositionCubit, LatestPositionState>(
                    builder: (context, state) {
                      return CustomTabBar(
                        titles: state.getLatestTabTitles(context),
                        isScrollable: true,
                        tabAlignment: TabAlignment.start,
                        selectedColor: context.colorTheme.primaryContainer,
                        onSelectedTab: (pos) {
                          _latestTabPressApiCall(
                            context,
                            pos,
                            latestPosCubit,
                            latestCubit,
                          );
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16),
                BlocBuilder<LatestCubit, LatestState>(
                  builder: (context, state) {
                    return AnimatedOpacity(
                      opacity: state.latestStatus is LatestSectionDone ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 500),
                      child: SizedBox(
                        height: 225,
                        child: Visibility(
                          visible: state.error?.isEmpty ?? true,
                          replacement: Center(
                            child: WrappedText(
                              state.error,
                              style: context.textTheme.titleLarge,
                            ),
                          ),
                          child: TmdbHorizontalList(
                            imageUrls: state.getImageUrls,
                            onViewAllClick: () {
                              if (latestPosCubit.state.currentSwitchState) {
                                context.push("${RouteName.home}/${RouteName.movie}");
                              } else {
                                context.push("${RouteName.home}/${RouteName.tv}");
                              }
                            },
                            onItemClick: (i) {
                              CommonNavigation.redirectToDetailScreen(
                                context,
                                mediaType: latestPosCubit.state.currentSwitchState
                                    ? ApiKey.movie
                                    : ApiKey.tv,
                                mediaId: state.results[i].id.toString(),
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 16)),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                BlocBuilder<FreeToWatchCubit, AdvanceFilterState>(
                  builder: (context, state) {
                    return WrappedText(
                      state.getFreeToWatchText(context, state.pos),
                      style: context.textTheme.displayMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                    );
                  },
                ),
                const SizedBox(height: 8),
                FittedBox(
                  child: CustomTabBar(
                    titles: freeToWatchCubit.state.getFreeToWatchMovieTabTitles(context),
                    isScrollable: true,
                    tabAlignment: TabAlignment.start,
                    selectedColor: context.colorTheme.primaryContainer,
                    onSelectedTab: (pos) {
                      freeToWatchCubit.fetchFreeResults(pos);
                    },
                  ),
                ),
                const SizedBox(height: 16),
                BlocBuilder<FreeToWatchCubit, AdvanceFilterState>(
                  builder: (context, state) {
                    return AnimatedOpacity(
                      opacity: state.latestStatus is AdvanceFilterStatusDone ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 500),
                      child: SizedBox(
                        height: 225,
                        child: Visibility(
                          visible: state.error?.isEmpty ?? true,
                          replacement: Center(
                            child: WrappedText(
                              state.error,
                              style: context.textTheme.titleLarge,
                            ),
                          ),
                          child: TmdbHorizontalList(
                            imageUrls: state.getImageUrls,
                            onViewAllClick: () {
                              if (freeToWatchCubit.state.pos == 0) {
                                context.push("${RouteName.home}/${RouteName.movie}");
                                return;
                              }

                              if (freeToWatchCubit.state.pos == 1) {
                                context.push("${RouteName.home}/${RouteName.tv}");
                                return;
                              }
                            },
                            onItemClick: (i) {
                              CommonNavigation.redirectToDetailScreen(
                                context,
                                mediaType: state.pos == 0 ? ApiKey.movie : ApiKey.tv,
                                mediaId: state.results[i].id.toString(),
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// This method is called when trending tab item is pressed
  void _trendingTabPressApiCall(
    int pos,
    TrendingPositionCubit trendingPosCubit,
    TrendingCubit trendingCubit,
  ) {
    if (pos != trendingPosCubit.state.pos) {
      trendingPosCubit.storePosition(pos, trendingPosCubit.state.switchState);
      trendingCubit.fetchTrendingResults(
        pos,
        switchState: trendingPosCubit.state.switchState,
        timeWindow: trendingPosCubit.state.switchState ? ApiKey.day : ApiKey.week,
      );
    }
  }

  /// This method is called when trending switcher is pressed
  void _trendingSwitchApiCall(
    bool s,
    TrendingPositionCubit trendingPosCubit,
    TrendingCubit trendingCubit,
    int pos,
  ) {
    if (s) {
      trendingPosCubit.storePosition(pos, s);
      trendingCubit.fetchTrendingResults(pos, switchState: s, timeWindow: ApiKey.day);
      return;
    }

    if (!s) {
      trendingPosCubit.storePosition(pos, s);
      trendingCubit.fetchTrendingResults(pos, switchState: s, timeWindow: ApiKey.week);
      return;
    }
  }

  /// This method is called when latest tab item is pressed
  void _latestTabPressApiCall(
    BuildContext context,
    int pos,
    LatestPositionCubit latestPosCubit,
    LatestCubit latestCubit,
  ) {
    if (pos != latestPosCubit.state.pos) {
      latestPosCubit.storePosition(pos, latestPosCubit.state.currentSwitchState);
      latestCubit.fetchLatestResults(
        latestPosCubit.state.currentSwitchState,
        latestPosCubit.state.getCurrentTabTitle(context),
      );
    }
  }

  /// This method is called when latest switcher is pressed
  void _latestSwitchApiCall(
    BuildContext context,
    bool switchState,
    LatestPositionCubit latestPosCubit,
    LatestCubit latestCubit,
    int pos,
  ) {
    if (switchState) {
      latestPosCubit.storePosition(pos, switchState);
      latestCubit.fetchLatestResults(
        switchState,
        latestPosCubit.state.getCurrentTabTitle(context),
      );
      return;
    }

    if (!switchState) {
      latestPosCubit.storePosition(pos, switchState);
      latestCubit.fetchLatestResults(
        switchState,
        latestPosCubit.state.getCurrentTabTitle(context),
      );
      return;
    }
  }
}
