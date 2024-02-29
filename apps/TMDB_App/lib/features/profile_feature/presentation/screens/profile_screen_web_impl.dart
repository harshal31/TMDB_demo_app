import 'package:common_widgets/localizations/localized_extension.dart';
import 'package:common_widgets/theme/app_theme.dart';
import 'package:common_widgets/widgets/country_flag.dart';
import 'package:common_widgets/widgets/custom_tab_bar.dart';
import 'package:common_widgets/widgets/extended_image_creator.dart';
import 'package:common_widgets/widgets/lottie_loader.dart';
import 'package:common_widgets/widgets/wrapped_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:tmdb_app/constants/api_key.dart';
import 'package:tmdb_app/constants/hive_key.dart';
import 'package:tmdb_app/data_storage/hive_manager.dart';
import 'package:tmdb_app/features/profile_feature/presentation/cubit/favorite_cubit.dart';
import 'package:tmdb_app/features/profile_feature/presentation/cubit/profile_cubit.dart';
import 'package:tmdb_app/features/profile_feature/presentation/cubit/rated_cubit.dart';
import 'package:tmdb_app/features/profile_feature/presentation/cubit/watchlist_cubit.dart';
import 'package:tmdb_app/features/profile_feature/presentation/use_cases/profile_use_case.dart';
import 'package:tmdb_app/features/tmdb_widgets/tmdb_horizontal_list.dart';
import 'package:tmdb_app/routes/route_param.dart';
import 'package:tmdb_app/utils/common_navigation.dart';

class ProfileScreenWebImpl extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        if (state.profileStatus is ProfileLoading || state.profileStatus is ProfileNone) {
          return const LinearLoader();
        }

        if (state.profileStatus is ProfileError) {
          return Center(
            child: WrappedText(
              (state.profileStatus as ProfileError).error,
              style: context.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
          );
        }

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Container(
                  padding: const EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(
                      color: context.colorTheme.onBackground.withOpacity(0.4), // Border color
                      width: 1.0, // Border width
                    ),
                    borderRadius: BorderRadius.circular(10), // Border radius
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        backgroundColor: context.colorTheme.onBackground.withOpacity(0.6),
                        radius: 50,
                        child: CircleAvatar(
                          backgroundColor: context.colorTheme.primary.withOpacity(0.6),
                          radius: 50,
                          child: (state.profileDetailModel?.avatar?.tmdb?.avatarPath?.isNotEmpty ??
                                  false)
                              ? Stack(
                                  children: [
                                    Positioned.fill(
                                      child: ExtendedImageCreator(
                                        imageUrl:
                                            state.profileDetailModel?.avatar?.tmdb?.avatarPath ??
                                                "",
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        height: double.infinity,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.center,
                                      child: FlagWidget(
                                        code: state.profileDetailModel?.iso31661 ?? "IN",
                                        width: 30,
                                        height: 30,
                                      ),
                                    )
                                  ],
                                )
                              : Stack(
                                  children: [
                                    Align(
                                      alignment: Alignment.center,
                                      child: WrappedText(
                                        ((state.profileDetailModel?.name ??
                                                            state.profileDetailModel?.username)
                                                        ?.length ??
                                                    0) >
                                                0
                                            ? (state.profileDetailModel?.name ??
                                                    state.profileDetailModel?.username ??
                                                    "A")[0]
                                                .toUpperCase()
                                            : "A",
                                        style: context.textTheme.displayMedium?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: context.colorTheme.onPrimary,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      right: 0,
                                      child: FlagWidget(
                                        code: state.profileDetailModel?.iso31661 ?? "IN",
                                        width: 30,
                                        height: 30,
                                      ),
                                    )
                                  ],
                                ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Visibility(
                              visible: (state.profileDetailModel?.name ??
                                      state.profileDetailModel?.username ??
                                      "")
                                  .isNotEmpty,
                              child: WrappedText(
                                context.tr.hello(
                                  (state.profileDetailModel?.name ??
                                      state.profileDetailModel?.username ??
                                      ""),
                                ),
                                style: context.textTheme.headlineLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                WrappedText(
                                  context.tr.language,
                                  style: context.textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                WrappedText(
                                  (state.profileDetailModel?.iso6391 ?? "en").toString(),
                                  style: context.textTheme.titleMedium,
                                )
                              ],
                            ),
                            const SizedBox(height: 4),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                WrappedText(
                                  context.tr.isAdultIncluded,
                                  style: context.textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                WrappedText(
                                  (state.profileDetailModel?.includeAdult ?? false).toString(),
                                  style: context.textTheme.titleMedium,
                                )
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SliverPadding(padding: EdgeInsets.only(top: 16)),
              SliverToBoxAdapter(
                child: BlocBuilder<FavoriteCubit, AccountState>(
                  builder: (context, favState) {
                    if (state.accountDetailData.favorites != null &&
                        favState.accountStatus is AccountNone) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          WrappedText(
                            context.tr.favorite(
                              favState.pos == 0 ? context.tr.movies : context.tr.tvSeries,
                            ),
                            style: context.textTheme.displayLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          FittedBox(
                            child: CustomTabBar(
                              initialIndex: favState.pos,
                              titles: [context.tr.movies, context.tr.tvSeries],
                              isScrollable: true,
                              tabAlignment: TabAlignment.start,
                              selectedColor: context.colorTheme.primaryContainer,
                              onSelectedTab: (pos) {
                                context.read<FavoriteCubit>().fetchAccountMedia(
                                      accountId: GetIt.instance
                                          .get<HiveManager>()
                                          .getString(HiveKey.accountId),
                                      mediaType: pos == 0 ? ApiKey.movies : ApiKey.tv,
                                      pos: pos,
                                    );
                              },
                            ),
                          ),
                          const SizedBox(height: 8),
                          TmdbHorizontalList(
                            imageUrls: state.accountDetailData.favorites?.latestData
                                    ?.map((e) => e.getImagePath())
                                    .toList() ??
                                [],
                            onItemClick: (index) {
                              final media = favState.latestResults?.latestData?[index];
                              CommonNavigation.redirectToDetailScreen(
                                context,
                                mediaType: favState.pos == 0 ? RouteParam.movie : RouteParam.tv,
                                mediaId: media?.id.toString(),
                              );
                            },
                          ),
                        ],
                      );
                    }

                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        WrappedText(
                          context.tr.favorite(
                            favState.pos == 0 ? context.tr.movies : context.tr.tvSeries,
                          ),
                          style: context.textTheme.displayLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        FittedBox(
                          child: CustomTabBar(
                            initialIndex: favState.pos,
                            titles: [context.tr.movies, context.tr.tvSeries],
                            isScrollable: true,
                            tabAlignment: TabAlignment.start,
                            selectedColor: context.colorTheme.primaryContainer,
                            onSelectedTab: (pos) {
                              context.read<FavoriteCubit>().fetchAccountMedia(
                                    accountId: GetIt.instance
                                        .get<HiveManager>()
                                        .getString(HiveKey.accountId),
                                    mediaType: pos == 0 ? ApiKey.movies : ApiKey.tv,
                                    pos: pos,
                                  );
                            },
                          ),
                        ),
                        const SizedBox(height: 8),
                        AnimatedOpacity(
                          opacity: favState.accountStatus is AccountDone ? 1.0 : 0.0,
                          duration: const Duration(milliseconds: 200),
                          child: TmdbHorizontalList(
                            imageUrls: favState.latestResults?.latestData
                                    ?.map((e) => e.getImagePath())
                                    .toList() ??
                                [],
                            onItemClick: (index) {
                              final media = favState.latestResults?.latestData?[index];
                              CommonNavigation.redirectToDetailScreen(
                                context,
                                mediaType: favState.pos == 0 ? RouteParam.movie : RouteParam.tv,
                                mediaId: media?.id.toString(),
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              const SliverPadding(padding: EdgeInsets.only(top: 22)),
              SliverToBoxAdapter(
                child: BlocBuilder<RatedCubit, AccountState>(
                  builder: (context, favState) {
                    if (state.accountDetailData.rated != null &&
                        favState.accountStatus is AccountNone) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          WrappedText(
                            context.tr.rated(
                              favState.pos == 0 ? context.tr.movies : context.tr.tvSeries,
                            ),
                            style: context.textTheme.displayLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          FittedBox(
                            child: CustomTabBar(
                              titles: [context.tr.movies, context.tr.tvSeries],
                              isScrollable: true,
                              tabAlignment: TabAlignment.start,
                              selectedColor: context.colorTheme.primaryContainer,
                              onSelectedTab: (pos) {
                                context.read<RatedCubit>().fetchAccountMedia(
                                      accountId: GetIt.instance
                                          .get<HiveManager>()
                                          .getString(HiveKey.accountId),
                                      mediaType: pos == 0 ? ApiKey.movies : ApiKey.tv,
                                      pos: pos,
                                    );
                              },
                            ),
                          ),
                          const SizedBox(height: 8),
                          TmdbHorizontalList(
                            imageUrls: state.accountDetailData.rated?.latestData
                                    ?.map((e) => e.getImagePath())
                                    .toList() ??
                                [],
                            onItemClick: (index) {
                              final media = favState.latestResults?.latestData?[index];
                              CommonNavigation.redirectToDetailScreen(
                                context,
                                mediaType: favState.pos == 0 ? RouteParam.movie : RouteParam.tv,
                                mediaId: media?.id.toString(),
                              );
                            },
                          ),
                        ],
                      );
                    }

                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        WrappedText(
                          context.tr.rated(
                            favState.pos == 0 ? context.tr.movies : context.tr.tvSeries,
                          ),
                          style: context.textTheme.displayLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        FittedBox(
                          child: CustomTabBar(
                            titles: [context.tr.movies, context.tr.tvSeries],
                            isScrollable: true,
                            tabAlignment: TabAlignment.start,
                            selectedColor: context.colorTheme.primaryContainer,
                            onSelectedTab: (pos) {
                              context.read<RatedCubit>().fetchAccountMedia(
                                    accountId: GetIt.instance
                                        .get<HiveManager>()
                                        .getString(HiveKey.accountId),
                                    mediaType: pos == 0 ? ApiKey.movies : ApiKey.tv,
                                    pos: pos,
                                  );
                            },
                          ),
                        ),
                        const SizedBox(height: 8),
                        AnimatedOpacity(
                          opacity: favState.accountStatus is AccountDone ? 1.0 : 0.0,
                          duration: const Duration(milliseconds: 200),
                          child: TmdbHorizontalList(
                            imageUrls: favState.latestResults?.latestData
                                    ?.map((e) => e.getImagePath())
                                    .toList() ??
                                [],
                            onItemClick: (index) {
                              final media = favState.latestResults?.latestData?[index];
                              CommonNavigation.redirectToDetailScreen(
                                context,
                                mediaType: favState.pos == 0 ? RouteParam.movie : RouteParam.tv,
                                mediaId: media?.id.toString(),
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              const SliverPadding(padding: EdgeInsets.only(top: 22)),
              SliverToBoxAdapter(
                child: BlocBuilder<WatchListCubit, AccountState>(
                  builder: (context, favState) {
                    if (state.accountDetailData.watchList != null &&
                        favState.accountStatus is AccountNone) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          WrappedText(
                            context.tr.watchlist(
                              favState.pos == 0 ? context.tr.movies : context.tr.tvSeries,
                            ),
                            style: context.textTheme.displayLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          FittedBox(
                            child: CustomTabBar(
                              titles: [context.tr.movies, context.tr.tvSeries],
                              isScrollable: true,
                              tabAlignment: TabAlignment.start,
                              selectedColor: context.colorTheme.primaryContainer,
                              onSelectedTab: (pos) {
                                context.read<WatchListCubit>().fetchAccountMedia(
                                      accountId: GetIt.instance
                                          .get<HiveManager>()
                                          .getString(HiveKey.accountId),
                                      mediaType: pos == 0 ? ApiKey.movies : ApiKey.tv,
                                      pos: pos,
                                    );
                              },
                            ),
                          ),
                          const SizedBox(height: 8),
                          TmdbHorizontalList(
                            imageUrls: state.accountDetailData.watchList?.latestData
                                    ?.map((e) => e.getImagePath())
                                    .toList() ??
                                [],
                            onItemClick: (index) {
                              final media = favState.latestResults?.latestData?[index];
                              CommonNavigation.redirectToDetailScreen(
                                context,
                                mediaType: favState.pos == 0 ? RouteParam.movie : RouteParam.tv,
                                mediaId: media?.id.toString(),
                              );
                            },
                          ),
                        ],
                      );
                    }

                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        WrappedText(
                          context.tr.watchlist(
                            favState.pos == 0 ? context.tr.movies : context.tr.tvSeries,
                          ),
                          style: context.textTheme.displayLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        FittedBox(
                          child: CustomTabBar(
                            titles: [context.tr.movies, context.tr.tvSeries],
                            isScrollable: true,
                            tabAlignment: TabAlignment.start,
                            selectedColor: context.colorTheme.primaryContainer,
                            onSelectedTab: (pos) {
                              context.read<WatchListCubit>().fetchAccountMedia(
                                    accountId: GetIt.instance
                                        .get<HiveManager>()
                                        .getString(HiveKey.accountId),
                                    mediaType: pos == 0 ? ApiKey.movies : ApiKey.tv,
                                    pos: pos,
                                  );
                            },
                          ),
                        ),
                        const SizedBox(height: 8),
                        AnimatedOpacity(
                          opacity: favState.accountStatus is AccountDone ? 1.0 : 0.0,
                          duration: const Duration(milliseconds: 200),
                          child: TmdbHorizontalList(
                            imageUrls: favState.latestResults?.latestData
                                    ?.map((e) => e.getImagePath())
                                    .toList() ??
                                [],
                            onItemClick: (index) {
                              final media = favState.latestResults?.latestData?[index];
                              CommonNavigation.redirectToDetailScreen(
                                context,
                                mediaType: favState.pos == 0 ? RouteParam.movie : RouteParam.tv,
                                mediaId: media?.id.toString(),
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              const SliverPadding(padding: EdgeInsets.only(top: 22)),
            ],
          ),
        );
      },
    );
  }
}
