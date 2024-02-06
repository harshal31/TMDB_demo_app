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

class CompanyTvShowsScreenImpl extends StatefulWidget {
  final String companyName;
  final String companyId;

  const CompanyTvShowsScreenImpl({
    super.key,
    required this.companyName,
    required this.companyId,
  });

  @override
  State<CompanyTvShowsScreenImpl> createState() => _CompanyTvShowsScreenImplState();
}

class _CompanyTvShowsScreenImplState extends State<CompanyTvShowsScreenImpl> {
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
                    widget.companyName,
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
                  child: BlocBuilder<CompanyMediaCubit, AdvanceFilterPaginationState>(
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
                  defaultSelectedItem: context.tr.tvSeries,
                )
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

  void _listenMoviesPaginationChanges(CompanyMediaCubit companyMediaCubit) {
    tvShowsController.addPageRequestListener((pageKey) {
      companyMediaCubit.fetchKeywordMedias(widget.companyId, pageKey, false);
    });

    companyMediaCubit.stream.listen((state) {
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