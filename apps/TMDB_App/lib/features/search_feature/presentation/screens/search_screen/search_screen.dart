import 'package:tmdb_app/utils/size_detector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:tmdb_app/features/search_feature/data/search_api_service.dart';
import 'package:tmdb_app/features/search_feature/presentation/cubits/combine_search_result_cubit.dart';
import 'package:tmdb_app/features/search_feature/presentation/screens/search_screen/search_screen_impl.dart';
import 'package:tmdb_app/features/search_feature/presentation/screens/search_screen/search_screen_web_tab_impl.dart';
import 'package:tmdb_app/features/search_feature/presentation/use_case/combine_count_use_case.dart';
import 'package:tmdb_app/features/tmdb_widgets/tmdb_app_bar.dart';
import 'package:tmdb_app/network/dio_manager.dart';

class SearchScreen extends StatelessWidget {
  final String query;

  const SearchScreen({super.key, required this.query});

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
          create: (c) => CombineSearchResultUseCase(
            c.read(),
          ),
        ),
        BlocProvider(
          create: (c) => CombineSearchResultCubit(
            c.read(),
          )..consolidatedSearchResult(query),
        ),
      ],
      child: SafeArea(
        child: Scaffold(
          appBar: TmdbAppBar(
            shouldDisplaySearchBar: true,
            onSubmitted: (s) {
              context.read<CombineSearchResultCubit>();
            },
          ),
          body: SizeDetector(
            mobileBuilder: () {
              return SearchScreenImpl(
                query: query,
              );
            },
            tabletBuilder: () {
              return SearchScreenWebTabImpl(
                query: query,
              );
            },
            desktopBuilder: () {
              return SearchScreenWebTabImpl(
                query: query,
              );
            },
          ),
        ),
      ),
    );
  }
}
