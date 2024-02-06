import 'package:common_widgets/localizations/localized_extension.dart';
import 'package:common_widgets/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';
import 'package:tmdb_app/features/persons_listing_feature/cubits/persons_listing_cubit.dart';
import 'package:tmdb_app/features/persons_listing_feature/cubits/persons_listing_use_case.dart';
import 'package:tmdb_app/features/persons_listing_feature/person_listing_item.dart';
import 'package:tmdb_app/features/search_feature/data/model/search_person_model.dart';

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
                    context.tr.people,
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
                  child: BlocBuilder<PersonListingCubit, PersonListingState>(
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
            pagingController: personListingController,
            builderDelegate: PagedChildBuilderDelegate<Persons>(
              firstPageErrorIndicatorBuilder: (context) => Center(
                child: TextButton(
                  onPressed: () => personListingController.refresh(),
                  child: Text(
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
          )
        ],
      ),
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