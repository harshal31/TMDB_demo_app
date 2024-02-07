import 'package:common_widgets/localizations/localized_extension.dart';
import 'package:common_widgets/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';
import 'package:tmdb_app/features/company_media_screen/cubits/company_media_cubit.dart';
import 'package:tmdb_app/features/home_feature/data/model/latest_results.dart';
import 'package:tmdb_app/features/home_feature/presentation/use_case/movies_advance_filter_use.dart';
import 'package:tmdb_app/features/media_listing_feature/media_listing_item.dart';

class MediaListingScreenImpl extends StatefulWidget {
  final bool isMovies;

  MediaListingScreenImpl(this.isMovies);

  @override
  State<MediaListingScreenImpl> createState() => _MediaListingScreenImplState();
}

class _MediaListingScreenImplState extends State<MediaListingScreenImpl> {
  final PagingController<int, LatestData> mediaListingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    super.initState();
    _listenMediaPaginationChanges(context.read());
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
                      widget.isMovies ? context.tr.movies : context.tr.tvSeries,
                      style: context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
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
                          "${(s.totalResults).toString()}",
                          style: context.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SliverPadding(padding: EdgeInsets.only(top: 16)),
          PagedSliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: _calculateAspectRatio,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              crossAxisCount: _getCrossAxisGridCount,
              mainAxisExtent: 400,
            ),
            pagingController: mediaListingController,
            builderDelegate: PagedChildBuilderDelegate<LatestData>(
              firstPageErrorIndicatorBuilder: (context) => Center(
                child: TextButton(
                  onPressed: () => mediaListingController.refresh(),
                  child: Text(
                    context.tr.tryAgain,
                    style: context.textTheme.titleMedium,
                  ),
                ),
              ),
              animateTransitions: true,
              itemBuilder: (ctx, item, index) {
                return MediaListingItem(
                  key: ValueKey(index),
                  latestData: item,
                  isMovies: widget.isMovies,
                );
              },
            ),
          )
        ],
      ),
    );
  }

  void _listenMediaPaginationChanges(CompanyMediaCubit companyMediaCubit) {
    mediaListingController.addPageRequestListener((pageKey) {
      companyMediaCubit.fetchPaginatedMedia(pageKey, widget.isMovies);
    });

    companyMediaCubit.stream.listen((state) {
      if (state.advancePaginationState is AdvanceFilterPaginationLoaded) {
        final isLastPage =
            (state.advancePaginationState as AdvanceFilterPaginationLoaded).hasReachedMax;
        if (isLastPage) {
          mediaListingController.appendLastPage(
            (state.advancePaginationState as AdvanceFilterPaginationLoaded).results,
          );
        } else {
          final nextPageKey = mediaListingController.nextPageKey! + 1;
          mediaListingController.appendPage(
            (state.advancePaginationState as AdvanceFilterPaginationLoaded).results,
            nextPageKey,
          );
        }
      } else if (state.advancePaginationState is AdvanceFilterPaginationError) {
        mediaListingController.error =
            (state.advancePaginationState as AdvanceFilterPaginationError).error;
      }
    });
  }

  int get _getCrossAxisGridCount =>
      ResponsiveBreakpoints.of(context).isTablet || ResponsiveBreakpoints.of(context).isDesktop
          ? 4
          : 2;

  double get _calculateAspectRatio =>
      MediaQuery.of(context).size.width / MediaQuery.of(context).size.height;
}
