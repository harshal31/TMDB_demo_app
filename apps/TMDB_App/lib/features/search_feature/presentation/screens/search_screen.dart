import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:tmdb_app/features/search_feature/data/search_api_service.dart';
import 'package:tmdb_app/features/search_feature/presentation/cubits/combine_count_cubit.dart';
import 'package:tmdb_app/features/search_feature/presentation/cubits/search_cubit.dart';
import 'package:tmdb_app/features/search_feature/presentation/screens/search_implementation_screen.dart';
import 'package:tmdb_app/features/search_feature/presentation/use_case/combine_count_use_case.dart';
import 'package:tmdb_app/features/search_feature/presentation/use_case/search_company_use_case.dart';
import 'package:tmdb_app/features/search_feature/presentation/use_case/search_keywords_use_case%20copy.dart';
import 'package:tmdb_app/features/search_feature/presentation/use_case/search_movies_use_case%20copy%203.dart';
import 'package:tmdb_app/features/search_feature/presentation/use_case/search_persons_use_case%20copy%202.dart';
import 'package:tmdb_app/features/search_feature/presentation/use_case/search_tv_shows_use_case%20copy%204.dart';
import 'package:tmdb_app/features/tmdb_widgets/tmdb_app_bar.dart';
import 'package:tmdb_app/network/dio_manager.dart';
import 'package:tmdb_app/routes/route_name.dart';
import 'package:tmdb_app/routes/route_param.dart';

class SearchScreen extends StatefulWidget {
  final String searchType;
  final String query;

  const SearchScreen({
    super.key,
    required this.searchType,
    required this.query,
  });

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late final TextEditingController _controller = TextEditingController(text: widget.query);

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
          )..fetchInitialCount(widget.query),
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
            controller: _controller,
            shouldDisplaySearchBar: true,
            onSubmitted: (s) {
              context.push(
                Uri(
                  path: "${RouteName.home}/${RouteName.search}/${widget.searchType}",
                  queryParameters: {RouteParam.query: s},
                ).toString(),
              );
            },
          ),
          body: SearchImplementationScreen(
            searchType: widget.searchType,
            query: widget.query,
            controller: _controller,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.clear();
  }
}
