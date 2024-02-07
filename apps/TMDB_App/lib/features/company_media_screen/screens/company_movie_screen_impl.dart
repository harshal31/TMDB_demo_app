import 'package:common_widgets/localizations/localized_extension.dart';
import 'package:common_widgets/theme/app_theme.dart';
import 'package:common_widgets/widgets/listing_tooltip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:tmdb_app/constants/api_key.dart';
import 'package:tmdb_app/features/company_media_screen/cubits/company_media_cubit.dart';
import 'package:tmdb_app/features/home_feature/data/model/latest_results.dart';
import 'package:tmdb_app/features/home_feature/presentation/use_case/movies_advance_filter_use.dart';
import 'package:tmdb_app/features/tmdb_widgets/tmdb_media_search_list_item.dart';
import 'package:tmdb_app/routes/route_name.dart';
import 'package:tmdb_app/utils/common_navigation.dart';
import 'package:tmdb_app/utils/dynamic_text_style.dart';

class CompanyMovieScreenMovieImpl extends StatefulWidget {
  final String companyName;
  final String companyId;

  const CompanyMovieScreenMovieImpl({
    super.key,
    required this.companyName,
    required this.companyId,
  });

  @override
  State<CompanyMovieScreenMovieImpl> createState() => _CompanyMovieScreenMovieImplState();
}

class _CompanyMovieScreenMovieImplState extends State<CompanyMovieScreenMovieImpl> {
  final PagingController<int, LatestData> movieController = PagingController(firstPageKey: 1);

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
                Flexible(
                  child: Container(
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
                      widget.companyName,
                      style: context.dynamicTextStyle,
                      maxLines: 2,
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                ),
                const Spacer(),
                Flexible(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(
                        color: context.colorTheme.onSurface.withOpacity(0.4), // Border color
                        width: 2.0, // Border width
                      ),
                      borderRadius: BorderRadius.circular(20), // Border radius
                    ),
                    child: BlocBuilder<CompanyMediaCubit, AdvanceFilterPaginationState>(
                      buildWhen: (prev, cur) => prev.totalResults != cur.totalResults,
                      builder: (c, s) {
                        return Text(
                          "${(s.totalResults).toString()} ${context.tr.movies}",
                          style: context.dynamicTextStyle,
                          maxLines: 2,
                          softWrap: true,
                          overflow: TextOverflow.fade,
                        );
                      },
                    ),
                  ),
                ),
              ],
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
                            "${RouteName.home}/${RouteName.company}/$mediaType/${widget.companyId}",
                      ).toString(),
                      extra: widget.companyName,
                    );
                  },
                  defaultSelectedItem: context.tr.movies,
                )
              ],
            ),
          ),
          const SliverPadding(padding: EdgeInsets.only(top: 16)),
          PagedSliverList(
            pagingController: movieController,
            builderDelegate: PagedChildBuilderDelegate<LatestData>(
              firstPageProgressIndicatorBuilder: (context) => const Center(
                child: CircularProgressIndicator(),
              ),
              firstPageErrorIndicatorBuilder: (context) => Center(
                child: TextButton(
                  onPressed: () => movieController.refresh(),
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
                  title: item.title ?? item.originalTitle ?? "",
                  subtitle: item.overview ?? "",
                  date: item.releaseDate ?? "",
                  imageUrl: item.getImagePath(),
                  onItemClick: () {
                    CommonNavigation.redirectToDetailScreen(
                      context,
                      mediaType: ApiKey.movie,
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

  void _listenMoviesPaginationChanges(CompanyMediaCubit companyMediaCubit) {
    movieController.addPageRequestListener((pageKey) {
      companyMediaCubit.fetchKeywordMedias(widget.companyId, pageKey, true);
    });

    companyMediaCubit.stream.listen((state) {
      if (state.advancePaginationState is AdvanceFilterPaginationLoaded) {
        final isLastPage =
            (state.advancePaginationState as AdvanceFilterPaginationLoaded).hasReachedMax;
        if (isLastPage) {
          movieController.appendLastPage(
            (state.advancePaginationState as AdvanceFilterPaginationLoaded).results,
          );
        } else {
          final nextPageKey = movieController.nextPageKey! + 1;
          movieController.appendPage(
            (state.advancePaginationState as AdvanceFilterPaginationLoaded).results,
            nextPageKey,
          );
        }
      } else if (state.advancePaginationState is AdvanceFilterPaginationError) {
        movieController.error =
            (state.advancePaginationState as AdvanceFilterPaginationError).error;
      }
    });
  }
}
