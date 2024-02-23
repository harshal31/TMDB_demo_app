import 'package:common_widgets/localizations/localized_extension.dart';
import 'package:common_widgets/theme/app_theme.dart';
import 'package:common_widgets/widgets/lottie_loader.dart';
import 'package:common_widgets/widgets/wrapped_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tmdb_app/features/search_feature/presentation/cubits/combine_search_result_cubit.dart';
import 'package:tmdb_app/features/search_feature/presentation/cubits/combine_search_state.dart';
import 'package:tmdb_app/features/search_feature/presentation/screens/search_screen/url_id_name_mapper.dart';
import 'package:tmdb_app/features/tmdb_widgets/tmdb_horizontal_list.dart';
import 'package:tmdb_app/features/tmdb_widgets/tmdb_search_widget.dart';
import 'package:tmdb_app/routes/route_name.dart';
import 'package:tmdb_app/routes/route_param.dart';
import 'package:tmdb_app/utils/common_navigation.dart';

class SearchScreenWebTabImpl extends StatelessWidget {
  final String query;

  const SearchScreenWebTabImpl({
    super.key,
    required this.query,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TmdbSearchWidget(
            query: query,
            onSearch: (s) {
              context.read<CombineSearchResultCubit>().consolidatedSearchResult(s);
            },
          ),
        ),
        Expanded(
          child: BlocBuilder<CombineSearchResultCubit, CombineSearchState>(
            builder: (context, state) {
              final translations = [
                context.tr.movies,
                context.tr.tvSeries,
                context.tr.people,
                context.tr.keywords,
                context.tr.companies,
              ];

              if (state.status is CombineSearchStateLoading ||
                  state.status is CombineSearchStateNone) {
                return const LottieLoader();
              }

              if (state.status is CombineSearchStateError) {
                return Center(
                  child: WrappedText(
                    (state.status as CombineSearchStateError).error,
                    style: context.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              }

              if (state.status is CombineSearchStateEmptyQuery) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: WrappedText(
                      context.tr.pleaseEnterBeginQuery,
                      style: context.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              }
              return AnimatedOpacity(
                opacity: (state.status is CombineSearchStateSuccess) ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 500),
                curve: Curves.linearToEaseOut,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 0, 16, 16),
                  child: CustomScrollView(
                    slivers: [
                      SliverList.separated(
                        itemCount: translations.length,
                        itemBuilder: (ctx, index) {
                          final results = [
                            (
                              state.movies.keys.toList()[0],
                              state.movies.values
                                  .toList()[0]
                                  .map((e) => UrlIdNameMapper(e.imageUrl, e.id))
                                  .toList()
                            ),
                            (
                              state.tvShows.keys.toList()[0],
                              state.tvShows.values
                                  .toList()[0]
                                  .map((e) => UrlIdNameMapper(e.imageUrl, e.id))
                                  .toList()
                            ),
                            (
                              state.persons.keys.toList()[0],
                              state.persons.values
                                  .toList()[0]
                                  .map((e) => UrlIdNameMapper(e.imageUrl, e.id))
                                  .toList()
                            ),
                            (
                              state.searchKeywords.keys.toList()[0],
                              state.searchKeywords.values
                                  .toList()[0]
                                  .map((e) => UrlIdNameMapper(e.name, e.id))
                                  .toList()
                            ),
                            (
                              state.companies.keys.toList()[0],
                              state.companies.values
                                  .toList()[0]
                                  .map((e) => UrlIdNameMapper(e.name, e.id))
                                  .toList()
                            ),
                          ];

                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        WrappedText(
                                          translations[index],
                                          style: context.textTheme.titleLarge?.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 4.0,
                                            horizontal: 8,
                                          ),
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(30),
                                            border: Border.all(
                                              color:
                                                  context.colorTheme.onBackground.withOpacity(0.4),
                                            ),
                                          ),
                                          child: WrappedText(
                                            results[index].$1,
                                            style: context.textTheme.titleSmall?.copyWith(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Visibility(
                                    visible: int.parse(results[index].$1) >= 10,
                                    child: IconButton(
                                      icon: const Icon(
                                        Icons.arrow_circle_right_outlined,
                                        size: 40,
                                      ),
                                      onPressed: () {
                                        final q =
                                            context.read<CombineSearchResultCubit>().state.query;
                                        context.push(
                                          Uri(
                                            path:
                                                "${RouteName.search}/${RouteName.searchDetail}/${UrlIdNameMapper.getSearchDetailType(index)}",
                                            queryParameters: {RouteParam.query: q},
                                          ).toString(),
                                        );
                                      },
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(height: 8),
                              if (index == 3 || index == 4)
                                Visibility(
                                  visible: results[index].$2.isNotEmpty,
                                  child: Container(
                                    alignment: Alignment.topLeft,
                                    child: Wrap(
                                      spacing: 8.0,
                                      runSpacing: 2.0,
                                      children: List<Widget>.generate(
                                        results[index].$2.length,
                                        (int i) {
                                          return ActionChip(
                                            padding: EdgeInsets.zero,
                                            onPressed: () {
                                              final urlIdNameMapper = results[index].$2[i];
                                              if (index == 3) {
                                                CommonNavigation.redirectToKeywordsScreen(
                                                  context,
                                                  type: RouteParam.movie,
                                                  id: urlIdNameMapper.id,
                                                  extra: urlIdNameMapper.value ?? "",
                                                );
                                              }

                                              if (index == 4) {
                                                CommonNavigation.redirectToCompaniesScreen(
                                                  context,
                                                  type: RouteParam.movie,
                                                  id: urlIdNameMapper.id,
                                                  extra: urlIdNameMapper.value ?? "",
                                                );
                                              }
                                            },
                                            label: WrappedText(
                                              results[index].$2[i].value,
                                              style: context.textTheme.titleSmall,
                                            ),
                                            backgroundColor: context.colorTheme.surface,
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  replacement: SizedBox(
                                    height: 225,
                                    child: Center(
                                      child: WrappedText(
                                        context.tr.noSearchResultFound(translations[index]),
                                        style: context.textTheme.titleMedium?.copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              else
                                Visibility(
                                  visible: results[index].$2.isNotEmpty,
                                  child: TmdbHorizontalList(
                                    onItemClick: (i) {
                                      CommonNavigation.redirectToDetailScreen(
                                        context,
                                        mediaType: UrlIdNameMapper.getSearchDetailType(index),
                                        mediaId: results[index].$2[i].id?.toString() ?? "",
                                      );
                                    },
                                    imageUrls: results[index].$2.map((e) => e.value ?? "").toList(),
                                    onViewAllClick: () {
                                      final q =
                                          context.read<CombineSearchResultCubit>().state.query;

                                      context.push(
                                        Uri(
                                          path:
                                              "${RouteName.search}/${RouteName.searchDetail}/${UrlIdNameMapper.getSearchDetailType(index)}",
                                          queryParameters: {RouteParam.query: q},
                                        ).toString(),
                                      );
                                    },
                                  ),
                                  replacement: SizedBox(
                                    height: 225,
                                    child: Center(
                                      child: WrappedText(
                                        context.tr.noSearchResultFound(translations[index]),
                                        style: context.textTheme.titleMedium?.copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          );
                        },
                        separatorBuilder: (ctx, index) => const SizedBox(height: 16),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
