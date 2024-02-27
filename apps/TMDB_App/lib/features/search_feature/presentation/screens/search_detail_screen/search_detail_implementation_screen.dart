import 'package:common_widgets/localizations/localized_extension.dart';
import 'package:common_widgets/theme/app_theme.dart';
import 'package:common_widgets/widgets/wrapped_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:tmdb_app/constants/api_key.dart';
import 'package:tmdb_app/features/search_feature/data/model/search_company_model.dart';
import 'package:tmdb_app/features/search_feature/data/model/search_keywords_model.dart';
import 'package:tmdb_app/features/search_feature/data/model/search_movie_model.dart';
import 'package:tmdb_app/features/search_feature/data/model/search_person_model.dart';
import 'package:tmdb_app/features/search_feature/data/model/search_tv_model.dart';
import 'package:tmdb_app/features/search_feature/presentation/cubits/search_cubit.dart';
import 'package:tmdb_app/features/search_feature/presentation/cubits/search_state.dart';
import 'package:tmdb_app/features/search_feature/presentation/screens/search_manager.dart';
import 'package:tmdb_app/features/tmdb_widgets/tmdb_keyword_company_search_list_item.dart';
import 'package:tmdb_app/features/tmdb_widgets/tmdb_media_search_list_item.dart';
import 'package:tmdb_app/features/tmdb_widgets/tmdb_person_search_list_item.dart';
import 'package:tmdb_app/routes/route_name.dart';
import 'package:tmdb_app/routes/route_param.dart';
import 'package:tmdb_app/utils/common_navigation.dart';

class SearchDetailImplementationScreen extends StatefulWidget {
  final String searchType;
  final String query;

  const SearchDetailImplementationScreen({
    super.key,
    required this.searchType,
    required this.query,
  });

  @override
  State<SearchDetailImplementationScreen> createState() => _SearchDetailImplementationScreenState();
}

class _SearchDetailImplementationScreenState extends State<SearchDetailImplementationScreen> {
  late SearchManager _searchManager;

  @override
  void initState() {
    super.initState();
    _searchManager = SearchManager();
    _searchManager.listenPaginationChanges(context, widget.query);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: BlocBuilder<SearchCubit, SearchState>(
              builder: (context, state) {
                return Column(
                  children: [
                    Expanded(
                      child: PagedListView<int, dynamic>(
                        pagingController: _searchManager.getController(),
                        builderDelegate: PagedChildBuilderDelegate<dynamic>(
                          firstPageProgressIndicatorBuilder: (context) => const Center(
                            child: CircularProgressIndicator(),
                          ),
                          firstPageErrorIndicatorBuilder: (context) => Center(
                            child: TextButton(
                              onPressed: () => _searchManager.getController().refresh(),
                              child: WrappedText(
                                context.tr.tryAgain,
                                style: context.textTheme.titleMedium,
                              ),
                            ),
                          ),
                          animateTransitions: true,
                          itemBuilder: (ctx, item, index) {
                            if (item is Movies) {
                              return TmdbMediaSearchListItem(
                                key: ValueKey(index),
                                title: item.title ?? item.originalTitle ?? "",
                                subtitle: item.overview ?? "",
                                date: item.releaseDate ?? "",
                                imageUrl: item.imageUrl,
                                onItemClick: () {
                                  CommonNavigation.redirectToDetailScreen(
                                    context,
                                    mediaType: RouteParam.movie,
                                    mediaId: item.id?.toString() ?? "",
                                  );
                                },
                              );
                            }

                            if (item is TvShows) {
                              return TmdbMediaSearchListItem(
                                key: ValueKey(index),
                                title: item.name ?? item.originalName ?? "",
                                subtitle: item.overview ?? "",
                                date: item.firstAirDate ?? "",
                                imageUrl: item.imageUrl,
                                onItemClick: () {
                                  CommonNavigation.redirectToDetailScreen(
                                    context,
                                    mediaType: RouteParam.tv,
                                    mediaId: item.id?.toString() ?? "",
                                  );
                                },
                              );
                            }

                            if (item is Persons) {
                              return TmdbPersonSearchListItem(
                                key: ValueKey(index),
                                person: item,
                                onItemClick: () {
                                  CommonNavigation.redirectToDetailScreen(
                                    context,
                                    mediaType: ApiKey.person,
                                    mediaId: item.id?.toString() ?? "",
                                  );
                                },
                              );
                            }

                            if (item is SearchKeywords) {
                              return TmdbKeywordCompanySearchListItem(
                                key: ValueKey(index),
                                name: item.name ?? "",
                                onItemClick: () {
                                  context.push(
                                    Uri(
                                      path:
                                          "${RouteName.home}/${RouteName.keywords}/${RouteParam.movie}/${item.id}",
                                    ).toString(),
                                    extra: item.name ?? "",
                                  );
                                },
                              );
                            }

                            if (item is Companies) {
                              return TmdbKeywordCompanySearchListItem(
                                key: ValueKey(index),
                                name: item.name ?? "",
                                onItemClick: () {
                                  context.push(
                                    Uri(
                                      path:
                                          "${RouteName.home}/${RouteName.company}/${RouteParam.movie}/${item.id}",
                                    ).toString(),
                                    extra: item.name ?? "",
                                  );
                                },
                              );
                            }

                            return const SizedBox.shrink();
                          },
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchManager.disposeControllers();
    super.dispose();
  }
}
