import 'package:common_widgets/localizations/localized_extension.dart';
import 'package:common_widgets/theme/app_theme.dart';
import 'package:common_widgets/widgets/custom_tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:tmdb_app/features/search_feature/data/model/search_company_model.dart';
import 'package:tmdb_app/features/search_feature/data/model/search_keywords_model.dart';
import 'package:tmdb_app/features/search_feature/data/model/search_movie_model.dart';
import 'package:tmdb_app/features/search_feature/data/model/search_person_model.dart';
import 'package:tmdb_app/features/search_feature/data/model/search_tv_model.dart';
import 'package:tmdb_app/features/search_feature/presentation/cubits/search_cubit.dart';
import 'package:tmdb_app/features/search_feature/presentation/cubits/search_state.dart';
import 'package:tmdb_app/routes/route_param.dart';

class SearchWebScreen extends StatefulWidget {
  final String searchType;
  final String query;
  final int page;

  const SearchWebScreen({
    super.key,
    required this.searchType,
    required this.query,
    required this.page,
  });

  @override
  State<SearchWebScreen> createState() => _SearchWebScreenState();
}

class _SearchWebScreenState extends State<SearchWebScreen> {
  final PagingController<int, Movies> _movieController = PagingController(firstPageKey: 1);
  final PagingController<int, TvShows> _tvShowsController = PagingController(firstPageKey: 1);
  final PagingController<int, SearchKeywords> _keywordsController =
      PagingController(firstPageKey: 1);
  final PagingController<int, Companies> _companiesController = PagingController(firstPageKey: 1);
  final PagingController<int, Persons> _personsController = PagingController(firstPageKey: 1);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(50, 16, 50, 16),
      child: Column(
        children: [
          FittedBox(
            child: CustomTabBar(
              initialIndex: _getIndex(widget.searchType),
              isScrollable: true,
              tabAlignment: TabAlignment.start,
              selectedColor: context.colorTheme.primaryContainer,
              titles: [
                context.tr.tvShowsCount(0),
                context.tr.moviesCount(0),
                context.tr.peopleCount(0),
                context.tr.keywordsCount(0),
                context.tr.companiesCount(0),
              ],
              onSelectedTab: (p) {},
            ),
          ),
          Expanded(
            child: BlocBuilder<SearchCubit, SearchState>(
              builder: (context, state) {
                return Column(
                  children: [
                    Container(),
                    SizedBox(
                      height: 30,
                      child: Center(
                        child: ListView.builder(
                          itemCount: 10,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (ctx, index) {
                            return Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                border: widget.page == (index + 1)
                                    ? Border.all(color: context.colorTheme.onSurface)
                                    : null,
                              ),
                              child: Text(
                                widget.page.toString(),
                                style: context.textTheme.titleSmall,
                              ),
                            );
                          },
                        ),
                      ),
                    )
                  ],
                );
              },
            ),
          )
        ],
      ),
    );
  }

  int _getIndex(String searchType) {
    if (searchType == RouteParam.movie) {
      return 0;
    } else if (searchType == RouteParam.tv) {
      return 1;
    } else if (searchType == RouteParam.person) {
      return 2;
    } else if (searchType == RouteParam.keyword) {
      return 3;
    } else if (searchType == RouteParam.company) {
      return 4;
    } else {
      return 0;
    }
  }
}
