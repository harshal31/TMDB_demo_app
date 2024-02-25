import 'package:common_widgets/localizations/localized_extension.dart';
import 'package:common_widgets/theme/app_theme.dart';
import 'package:common_widgets/widgets/wrapped_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';
import 'package:tmdb_app/features/persons_listing_feature/cubits/persons_listing_cubit.dart';
import 'package:tmdb_app/features/persons_listing_feature/cubits/persons_listing_use_case.dart';
import 'package:tmdb_app/features/persons_listing_feature/person_listing_item.dart';
import 'package:tmdb_app/features/search_feature/data/model/search_person_model.dart';
import 'package:tmdb_app/utils/dynamic_text_style.dart';

class PersonListingScreenImpl extends StatefulWidget {
  PersonListingScreenImpl();

  @override
  State<PersonListingScreenImpl> createState() => _PersonListingScreenImplState();
}

class _PersonListingScreenImplState extends State<PersonListingScreenImpl> {
  final PagingController<int, Persons> personListingController = PagingController(firstPageKey: 1);

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
                    context.tr.people,
                    style: context.dynamicTextStyle,
                    maxLines: 3,
                  ),
                ),
                const Spacer(),
                Expanded(
                  child: BlocBuilder<PersonListingCubit, PersonListingState>(
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
            pagingController: personListingController,
            builderDelegate: PagedChildBuilderDelegate<Persons>(
              firstPageErrorIndicatorBuilder: (context) => Center(
                child: TextButton(
                  onPressed: () => personListingController.refresh(),
                  child: WrappedText(
                    context.tr.tryAgain,
                    style: context.textTheme.titleMedium,
                  ),
                ),
              ),
              animateTransitions: true,
              itemBuilder: (ctx, item, index) {
                return PersonListingItem(
                  key: ValueKey(index),
                  person: item,
                );
              },
            ),
          ),
        )
      ],
    );
  }

  void _listenMoviesPaginationChanges(PersonListingCubit personListingCubit) {
    personListingController.addPageRequestListener((pageKey) {
      personListingCubit.fetchPopularPersons(pageKey);
    });

    personListingCubit.stream.listen((state) {
      if (state.personListingState is PersonListingPaginationLoaded) {
        final isLastPage =
            (state.personListingState as PersonListingPaginationLoaded).hasReachedMax;
        if (isLastPage) {
          personListingController.appendLastPage(
            (state.personListingState as PersonListingPaginationLoaded).items,
          );
        } else {
          final nextPageKey = personListingController.nextPageKey! + 1;
          personListingController.appendPage(
            (state.personListingState as PersonListingPaginationLoaded).items,
            nextPageKey,
          );
        }
      } else if (state.personListingState is PersonListingPaginationError) {
        personListingController.error =
            (state.personListingState as PersonListingPaginationError).error;
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
