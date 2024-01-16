import 'package:common_widgets/localizations/localized_extension.dart';
import 'package:common_widgets/theme/app_theme.dart';
import 'package:common_widgets/widgets/custom_tab_bar.dart';
import 'package:common_widgets/widgets/switch_icon.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb_app/constants/api_key.dart';
import 'package:tmdb_app/constants/app_constant.dart';
import 'package:tmdb_app/features/home_feature/presentation/cubits/latest_sec_cubit/latest_cubit.dart';
import 'package:tmdb_app/features/home_feature/presentation/cubits/latest_sec_cubit/latest_position_cubit.dart';
import 'package:tmdb_app/features/home_feature/presentation/cubits/trending_sec_cubit/trending_cubit.dart';
import 'package:tmdb_app/features/home_feature/presentation/cubits/trending_sec_cubit/trending_position_cubit.dart';
import 'package:tmdb_app/features/home_feature/presentation/use_case/latest_use_case.dart';
import 'package:tmdb_app/features/home_feature/presentation/use_case/trending_use_case.dart';

class HomeMobileScreen extends StatelessWidget {
  const HomeMobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final trendingCubit = context.read<TrendingCubit>();
    final trendingPosCubit = context.read<TrendingPositionCubit>();
    final latestCubit = context.read<LatestCubit>();
    final latestPosCubit = context.read<LatestPositionCubit>();
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 0),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                BlocBuilder<TrendingPositionCubit, TrendingPositionState>(
                  builder: (context, state) {
                    return Text(
                      state.getTrendingText(context),
                      style: context.textTheme.headlineLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                      maxLines: 1,
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    );
                  },
                ),
                Row(
                  children: [
                    Wrap(
                      children: [
                        CustomTabBar(
                          titles: [
                            context.tr.all,
                            context.tr.movies,
                            context.tr.tv,
                            context.tr.people,
                          ],
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
                        )
                      ],
                    ),
                    Spacer(),
                    BlocBuilder<TrendingPositionCubit, TrendingPositionState>(
                      builder: (context, state) {
                        return Switch(
                          thumbIcon: SwitchIcon.thumbIcon,
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
                BlocBuilder<TrendingCubit, TrendingState>(
                  builder: (context, state) {
                    return AnimatedOpacity(
                      opacity: state.trendingStatus is TrendingDone ? 1.0 : 0.0,
                      duration: Duration(milliseconds: 500),
                      child: SizedBox(
                        height: 225,
                        child: ListView.builder(
                          itemCount: state.trendingResult?.results?.length ?? 0,
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (ctx, index) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 16.0),
                              child: ExtendedImage.network(
                                AppConstant.imageBaseUrl +
                                    (state.trendingResult?.results?[index]
                                            .getImagePath() ??
                                        ""),
                                width: 150,
                                height: 225,
                                fit: BoxFit.fill,
                                cache: true,
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                //cancelToken: cancellationToken,
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 16)),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                BlocBuilder<LatestPositionCubit, LatestPositionState>(
                  builder: (context, state) {
                    return Text(
                      state.getLatestText(context),
                      style: context.textTheme.headlineLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                      maxLines: 1,
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    );
                  },
                ),
                Row(
                  children: [
                    Expanded(
                      child: BlocBuilder<LatestPositionCubit, LatestPositionState>(
                        builder: (context, state) {
                          return CustomTabBar(
                            titles: state.getLatestTabTitles(context),
                            isScrollable: true,
                            tabAlignment: TabAlignment.start,
                            selectedColor: context.colorTheme.primaryContainer,
                            onSelectedTab: (pos) {},
                          );
                        },
                      ),
                    ),
                    SizedBox(width: 8),
                    BlocBuilder<LatestPositionCubit, LatestPositionState>(
                      builder: (context, state) {
                        return Switch(
                          thumbIcon: SwitchIcon.thumbIcon,
                          value: state.currentSwitchState,
                          onChanged: (s) {
                            _latestSwitchApiCall(
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
                BlocBuilder<LatestCubit, LatestState>(
                  builder: (context, state) {
                    return AnimatedOpacity(
                      opacity: 1.0,
                      duration: Duration(milliseconds: 500),
                      child: SizedBox(
                        height: 225,
                        child: ListView.builder(
                          itemCount: 0,
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (ctx, index) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 16.0),
                              child: ExtendedImage.network(
                                "",
                                width: 150,
                                height: 225,
                                fit: BoxFit.fill,
                                cache: true,
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                //cancelToken: cancellationToken,
                              ),
                            );
                          },
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
    trendingPosCubit.storePosition(
      pos,
      trendingPosCubit.state.switchState,
    );
    trendingCubit.fetchTrendingResults(
      pos,
      switchState: trendingPosCubit.state.switchState,
      timeWindow: trendingPosCubit.state.switchState ? ApiKey.day : ApiKey.week,
    );
  }

  /// This method is called when trending switcher is pressed
  void _trendingSwitchApiCall(
    bool switchState,
    TrendingPositionCubit trendingPosCubit,
    TrendingCubit trendingCubit,
    int pos,
  ) {
    if (switchState) {
      trendingPosCubit.storePosition(pos, switchState);
      trendingCubit.fetchTrendingResults(pos,
          switchState: switchState, timeWindow: ApiKey.day);
      return;
    }

    if (!switchState) {
      trendingPosCubit.storePosition(pos, switchState);
      trendingCubit.fetchTrendingResults(pos,
          switchState: switchState, timeWindow: ApiKey.week);
      return;
    }
  }

  /// This method is called when latest switcher is pressed
  void _latestSwitchApiCall(
    bool switchState,
    LatestPositionCubit latestPosCubit,
    LatestCubit latestCubit,
    int pos,
  ) {
    if (switchState) {
      latestPosCubit.storePosition(pos, switchState);
      latestCubit.fetchLatestResults();
      return;
    }

    if (!switchState) {
      latestPosCubit.storePosition(pos, switchState);
      latestCubit.fetchLatestResults();
      return;
    }
  }
}
