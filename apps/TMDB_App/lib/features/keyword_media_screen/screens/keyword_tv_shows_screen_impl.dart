import 'package:common_widgets/localizations/localized_extension.dart';
import 'package:common_widgets/theme/theme_util.dart';
import 'package:common_widgets/widgets/listing_tooltip.dart';
import 'package:common_widgets/widgets/lottie_loader.dart';
import 'package:common_widgets/widgets/wrapped_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:tmdb_app/constants/api_key.dart';
import 'package:tmdb_app/features/home_feature/data/model/latest_results.dart';
import 'package:tmdb_app/features/home_feature/presentation/use_case/movies_advance_filter_use.dart';
import 'package:tmdb_app/features/keyword_media_screen/cubits/keyword_media_cubit.dart';
import 'package:tmdb_app/features/tmdb_widgets/tmdb_media_search_list_item.dart';
import 'package:tmdb_app/routes/route_name.dart';
import 'package:tmdb_app/routes/route_param.dart';
import 'package:tmdb_app/utils/common_navigation.dart';
import 'package:tmdb_app/utils/dynamic_text_style.dart';

class KeywordTvShowsScreenImpl extends StatefulWidget {
  final String keywordName;
  final String keywordId;

  const KeywordTvShowsScreenImpl({
    super.key,
    required this.keywordName,
    required this.keywordId,
  });

  @override
  State<KeywordTvShowsScreenImpl> createState() => _KeywordTvShowsScreenImplState();
}

class _KeywordTvShowsScreenImplState extends State<KeywordTvShowsScreenImpl> {
  final PagingController<int, LatestData> tvShowsController = PagingController(firstPageKey: 1);

  @override
  void initState() {
    super.initState();
    _listenMoviesPaginationChanges(context.read());
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: context.boxDecoration,
            child: Row(
              children: [
                Expanded(
                  child: WrappedText(
                    widget.keywordName,
                    style: context.dynamicTextStyle,
                    maxLines: 3,
                  ),
                ),
                Expanded(
                  child: BlocBuilder<KeywordMediaCubit, AdvanceFilterPaginationState>(
                    buildWhen: (prev, cur) => prev.totalResults != cur.totalResults,
                    builder: (c, s) {
                      return WrappedText(
                        "${(s.totalResults).toString()} ${context.tr.movies}",
                        style: context.dynamicTextStyle,
                        maxLines: 3,
                        textAlign: TextAlign.end,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        const SliverPadding(padding: EdgeInsets.only(top: 16)),
        SliverToBoxAdapter(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ListingTooltip(
                items: [
                  context.tr.movies,
                  context.tr.tvSeries,
                ],
                onItemClick: (data, index) {
                  String mediaType = index == 0 ? ApiKey.movie : ApiKey.tv;
                  context.push(
                    Uri(
                      path:
                          "${RouteName.home}/${RouteName.keywords}/$mediaType/${widget.keywordId}",
                    ).toString(),
                    extra: widget.keywordName,
                  );
                },
                defaultSelectedItem: context.tr.tvSeries,
              )
            ],
          ),
        ),
        const SliverPadding(padding: EdgeInsets.only(top: 16)),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          sliver: PagedSliverList(
            pagingController: tvShowsController,
            builderDelegate: PagedChildBuilderDelegate<LatestData>(
              firstPageProgressIndicatorBuilder: (context) => const LinearLoader(),
              firstPageErrorIndicatorBuilder: (context) => Center(
                child: TextButton(
                  onPressed: () => tvShowsController.refresh(),
                  child: WrappedText(
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
                      mediaType: RouteParam.tv,
                      mediaId: item.id?.toString() ?? "",
                    );
                  },
                );
              },
            ),
          ),
        )
      ],
    );
  }

  void _listenMoviesPaginationChanges(KeywordMediaCubit keywordMediaCubit) {
    tvShowsController.addPageRequestListener((pageKey) {
      keywordMediaCubit.fetchKeywordMedias(widget.keywordId, pageKey, false);
    });

    keywordMediaCubit.stream.listen((state) {
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
