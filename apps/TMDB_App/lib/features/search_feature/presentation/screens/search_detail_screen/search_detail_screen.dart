import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:tmdb_app/features/search_feature/data/search_api_service.dart';
import 'package:tmdb_app/features/search_feature/presentation/cubits/search_cubit.dart';
import 'package:tmdb_app/features/search_feature/presentation/screens/search_detail_screen/search_detail_implementation_screen.dart';
import 'package:tmdb_app/features/search_feature/presentation/use_case/search_company_use_case.dart';
import 'package:tmdb_app/features/search_feature/presentation/use_case/search_keywords_use_case%20copy.dart';
import 'package:tmdb_app/features/search_feature/presentation/use_case/search_movies_use_case%20copy%203.dart';
import 'package:tmdb_app/features/search_feature/presentation/use_case/search_persons_use_case%20copy%202.dart';
import 'package:tmdb_app/features/search_feature/presentation/use_case/search_tv_shows_use_case%20copy%204.dart';
import 'package:tmdb_app/features/tmdb_widgets/tmdb_app_bar.dart';
import 'package:tmdb_app/network/dio_manager.dart';
import 'package:tmdb_app/routes/route_name.dart';
import 'package:tmdb_app/routes/route_param.dart';

class SearchDetailScreen extends StatelessWidget {
  final String searchType;
  final String query;

  const SearchDetailScreen({
    super.key,
    required this.searchType,
    required this.query,
  });

  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        RepositoryProvider(
          create: (c) => SearchApiService(
            GetIt.instance.get<DioManager>().dio,
          ),
        ),
        RepositoryProvider(
          create: (c) => SearchCompanyUseCase(
            c.read(),
          ),
        ),
        RepositoryProvider(
          create: (c) => SearchKeywordsUseCase(
            c.read(),
          ),
        ),
        RepositoryProvider(
          create: (c) => SearchPersonsUseCase(
            c.read(),
          ),
        ),
        RepositoryProvider(
          create: (c) => SearchMoviesUseCase(
            c.read(),
          ),
        ),
        RepositoryProvider(
          create: (c) => SearchCompanyUseCase(
            c.read(),
          ),
        ),
        RepositoryProvider(
          create: (c) => SearchTvShowsUseCase(
            c.read(),
          ),
        ),
        BlocProvider(
          create: (c) => SearchCubit(
            searchCompanyUseCase: c.read(),
            searchKeywordsUseCase: c.read(),
            searchMoviesUseCase: c.read(),
            searchPersonsUseCase: c.read(),
            searchTvShowsUseCase: c.read(),
          ),
        ),
      ],
      child: SafeArea(
        child: Scaffold(
          appBar: TmdbAppBar(
            shouldDisplayBack: !kIsWeb,
            shouldDisplaySearchBar: true,
            onSubmitted: (s) {
              context.push(
                Uri(
                  path: "${RouteName.home}/${RouteName.search}/${searchType}",
                  queryParameters: {RouteParam.query: s},
                ).toString(),
              );
            },
          ),
          body: SearchDetailImplementationScreen(
            searchType: searchType,
            query: query,
          ),
        ),
      ),
    );
  }
}
