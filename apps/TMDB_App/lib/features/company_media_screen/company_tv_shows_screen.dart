import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:tmdb_app/features/company_media_screen/cubits/company_media_cubit.dart';
import 'package:tmdb_app/features/company_media_screen/screens/company_tv_shows_screen_impl.dart';
import 'package:tmdb_app/features/home_feature/data/home_api_service.dart';
import 'package:tmdb_app/features/home_feature/presentation/use_case/movies_advance_filter_use.dart';
import 'package:tmdb_app/features/home_feature/presentation/use_case/tv_advance_filter_use_case.dart';
import 'package:tmdb_app/features/tmdb_widgets/tmdb_app_bar.dart';
import 'package:tmdb_app/network/dio_manager.dart';

class CompanyTvShowsScreen extends StatelessWidget {
  final String companyId;
  final String companyName;

  const CompanyTvShowsScreen({
    super.key,
    required this.companyId,
    required this.companyName,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        RepositoryProvider<HomeApiService>(
          create: (_) => HomeApiService(GetIt.instance.get<DioManager>().dio),
        ),
        RepositoryProvider<MoviesAdvanceFilterUseCase>(
          create: (c) => MoviesAdvanceFilterUseCase(c.read()),
        ),
        RepositoryProvider<TvAdvanceFilterUseCase>(
          create: (c) => TvAdvanceFilterUseCase(c.read()),
        ),
        BlocProvider(
          create: (c) => CompanyMediaCubit(c.read(), c.read()),
        )
      ],
      child: SafeArea(
        child: Scaffold(
          appBar: const TmdbAppBar(
            shouldDisplayBack: !kIsWeb,
          ),
          body: CompanyTvShowsScreenImpl(
            companyName: companyName,
            companyId: companyId,
          ),
        ),
      ),
    );
  }
}
