import 'package:common_widgets/localizations/localized_extension.dart';
import 'package:common_widgets/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:tmdb_app/constants/api_key.dart';
import 'package:tmdb_app/features/home_feature/data/model/latest_results.dart';
import 'package:tmdb_app/features/home_feature/presentation/use_case/movies_advance_filter_use.dart';
import 'package:tmdb_app/features/network_media_screen/cubits/network_media_cubit.dart';
import 'package:tmdb_app/features/tmdb_widgets/tmdb_media_search_list_item.dart';
import 'package:tmdb_app/utils/common_navigation.dart';

class NetworkTvShowsScreenImpl extends StatefulWidget {
  final String networkName;
  final String networkId;

  const NetworkTvShowsScreenImpl({
    super.key,
    required this.networkName,
    required this.networkId,
  });

  @override
  State<NetworkTvShowsScreenImpl> createState() => _NetworkTvShowsScreenImplState();
}

class _NetworkTvShowsScreenImplState extends State<NetworkTvShowsScreenImpl> {
  final PagingController<int, LatestData> tvShowsController = PagingController(firstPageKey: 1);

  @override
  void initState() {
    super.initState();
    _listenMoviesPaginationChanges(context.read());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(
                      color: context.colorTheme.onSurface.withOpacity(0.4), // Border color
                      width: 2.0, // Border width
                    ),
                    borderRadius: BorderRadius.circular(20), // Border radius
                  ),
                  child: Text(
                    widget.networkName,
                    style: context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(
                      color: context.colorTheme.onSurface.withOpacity(0.4), // Border color
                      width: 2.0, // Border width
                    ),
                    borderRadius: BorderRadius.circular(20), // Border radius
                  ),
                  child: BlocBuilder<NetworkMediaCubit, AdvanceFilterPaginationState>(
                    buildWhen: (prev, cur) => prev.totalResults != cur.totalResults,
                    builder: (c, s) {
                      return Text(
                        "${(s.totalResults).toString()} ${context.tr.movies}",
                        style: context.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          const SliverPadding(padding: EdgeInsets.only(top: 16)),
          PagedSliverList(
            pagingController: tvShowsController,
            builderDelegate: PagedChildBuilderDelegate<LatestData>(
              firstPageProgressIndicatorBuilder: (context) => const Center(
                child: CircularProgressIndicator(),
              ),
              firstPageErrorIndicatorBuilder: (context) => Center(
                child: TextButton(
                  onPressed: () => tvShowsController.refresh(),
                  child: Text(
                    context.tr.tryAgain,
                    style: context.textTheme.titleMedium,
                  ),
                ),
              ),
              animateTransitions: true,
              itemBuilder: (ctx, item, index) {
                return TmdbMediaSearchListItem(
                  key: ValueKey(index),
                  title: item.name ?? item.originalName ?? "",
                  subtitle: item.overview ?? "",
                  date: item.firstAirDate ?? "",
                  imageUrl: item.getImagePath(),
                  onItemClick: () {
                    CommonNavigation.redirectToDetailScreen(
                      context,
                      mediaType: ApiKey.tv,
                      mediaId: item.id?.toString() ?? "",
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }

  void _listenMoviesPaginationChanges(NetworkMediaCubit networkMediaCubit) {
    tvShowsController.addPageRequestListener((pageKey) {
      networkMediaCubit.fetchKeywordMedias(widget.networkId, pageKey);
    });

    networkMediaCubit.stream.listen((state) {
      if (state.advancePaginationState is AdvanceFilterPaginationLoaded) {
        final isLastPage =
            (state.advancePaginationState as AdvanceFilterPaginationLoaded).hasReachedMax;
        if (isLastPage) {
          tvShowsController.appendLastPage(
            (state.advancePaginationState as AdvanceFilterPaginationLoaded).results,
          );
        } else {
          final nextPageKey = tvShowsController.nextPageKey! + 1;
          tvShowsController.appendPage(
            (state.advancePaginationState as AdvanceFilterPaginationLoaded).results,
            nextPageKey,
          );
        }
      } else if (state.advancePaginationState is AdvanceFilterPaginationError) {
        tvShowsController.error =
            (state.advancePaginationState as AdvanceFilterPaginationError).error;
      }
    });
  }
}