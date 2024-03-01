import 'package:common_widgets/localizations/localized_extension.dart';
import 'package:common_widgets/theme/theme_util.dart';
import 'package:common_widgets/widgets/wrapped_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:tmdb_app/features/company_media_screen/cubits/company_media_cubit.dart';
import 'package:tmdb_app/features/home_feature/data/model/latest_results.dart';
import 'package:tmdb_app/features/home_feature/presentation/use_case/movies_advance_filter_use.dart';
import 'package:tmdb_app/features/media_listing_feature/media_listing_item.dart';
import 'package:tmdb_app/utils/dynamic_text_style.dart';

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
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Container(
            decoration: context.boxDecoration,
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: WrappedText(
                    widget.isMovies ? context.tr.movies : context.tr.tvSeries,
                    style: context.dynamicTextStyle,
                    maxLines: 3,
                  ),
                ),
                Expanded(
                  child: BlocBuilder<CompanyMediaCubit, AdvanceFilterPaginationState>(
                    buildWhen: (prev, cur) => prev.totalResults != cur.totalResults,
                    builder: (c, s) {
                      return WrappedText(
                        "${(s.totalResults).toString()}",
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
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          sliver: PagedSliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: _calculateAspectRatio,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              crossAxisCount: _getCrossAxisGridCount,
              mainAxisExtent: kIsWeb ? 450 : 250,
            ),
            pagingController: mediaListingController,
            builderDelegate: PagedChildBuilderDelegate<LatestData>(
              firstPageErrorIndicatorBuilder: (context) => Center(
                child: TextButton(
                  onPressed: () => mediaListingController.refresh(),
                  child: WrappedText(
                    context.tr.tryAgain,
                    style: context.textTheme.titleMedium,
                  ),
                ),
              ),
              animateTransitions: true,
              itemBuilder: (ctx, item, index) {
                return MediaListingItem(
                  key: ValueKey(item.posterPath),
                  latestData: item,
                  isMovies: widget.isMovies,
                );
              },
            ),
          ),
        )
      ],
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
