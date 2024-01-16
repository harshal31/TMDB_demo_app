import 'package:common_widgets/localizations/localized_extension.dart';
import 'package:common_widgets/theme/app_theme.dart';
import 'package:common_widgets/widgets/custom_tab_bar.dart';
import 'package:common_widgets/widgets/switch_icon.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb_app/constants/api_key.dart';
import 'package:tmdb_app/constants/app_constant.dart';
import 'package:tmdb_app/features/home_feature/presentation/cubits/trending_cubit.dart';
import 'package:tmdb_app/features/home_feature/presentation/cubits/trending_position_cubit.dart';
import 'package:tmdb_app/features/home_feature/presentation/use_case/trending_use_case.dart';

class HomeMobile extends StatelessWidget {
  const HomeMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final trendingCubit = context.read<TrendingCubit>();
    final trendingPosCubit = context.read<TrendingPositionCubit>();
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 0),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  context.tr.trending,
                  style: context.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Wrap(
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
                                  pos, trendingPosCubit, trendingCubit);
                            },
                          )
                        ],
                      ),
                      flex: 2,
                    ),
                    Spacer(),
                    BlocBuilder<TrendingPositionCubit, PositionState>(
                      builder: (context, state) {
                        return Switch(
                          thumbIcon: SwitchIcon.thumbIcon,
                          value: state.switchStates[state.pos],
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
        ],
      ),
    );
  }

  void _trendingTabPressApiCall(
    int pos,
    TrendingPositionCubit trendingPosCubit,
    TrendingCubit trendingCubit,
  ) {
    trendingPosCubit.storePosition(
      pos,
      trendingPosCubit.state.switchStates[pos],
    );
    trendingCubit.getTrendingResult(
      pos,
      switchState: trendingPosCubit.state.switchStates[pos],
      timeWindow: trendingPosCubit.state.switchStates[pos] ? ApiKey.day : ApiKey.week,
    );
  }

  void _trendingSwitchApiCall(
    bool s,
    TrendingPositionCubit trendingPosCubit,
    TrendingCubit trendingCubit,
    int pos,
  ) {
    if (s) {
      trendingPosCubit.storePosition(pos, s);
      trendingCubit.getTrendingResult(pos, switchState: s, timeWindow: ApiKey.day);
      return;
    }

    if (!s) {
      trendingPosCubit.storePosition(pos, s);
      trendingCubit.getTrendingResult(pos, switchState: s, timeWindow: ApiKey.week);
      return;
    }
  }
}
