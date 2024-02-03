import 'package:common_widgets/theme/size_detector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:tmdb_app/features/search_feature/data/search_api_service.dart';
import 'package:tmdb_app/features/search_feature/presentation/cubits/combine_count_cubit.dart';
import 'package:tmdb_app/features/search_feature/presentation/cubits/search_cubit.dart';
import 'package:tmdb_app/features/search_feature/presentation/screens/web/search_web_screen.dart';
import 'package:tmdb_app/features/search_feature/presentation/use_case/combine_count_use_case.dart';
import 'package:tmdb_app/features/search_feature/presentation/use_case/search_company_use_case.dart';
import 'package:tmdb_app/features/search_feature/presentation/use_case/search_keywords_use_case%20copy.dart';
import 'package:tmdb_app/features/search_feature/presentation/use_case/search_movies_use_case%20copy%203.dart';
import 'package:tmdb_app/features/search_feature/presentation/use_case/search_persons_use_case%20copy%202.dart';
import 'package:tmdb_app/features/search_feature/presentation/use_case/search_tv_shows_use_case%20copy%204.dart';
import 'package:tmdb_app/network/dio_manager.dart';

class SearchScreen extends StatelessWidget {
  final String searchType;
  final String query;

  const SearchScreen({
    super.key,
    required this.searchType,
    required this.query,
  });

  @override
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
        RepositoryProvider(
          create: (c) => CombineCountUseCase(
            c.read(),
          ),
        ),
        BlocProvider(
          create: (c) => CombineCountCubit(
            c.read(),
          )..fetchInitialCount(query),
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
          body: SizeDetector(
            mobileBuilder: () => Container(),
            tabletBuilder: () => Container(),
            desktopBuilder: () => SearchWebScreen(
              searchType: searchType,
              query: query,
            ),
          ),
        ),
      ),
    );
  }
}
