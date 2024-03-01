import 'package:tmdb_app/utils/size_detector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:tmdb_app/constants/hive_key.dart';
import 'package:tmdb_app/data_storage/hive_manager.dart';
import 'package:tmdb_app/features/profile_feature/data/profile_api_service.dart';
import 'package:tmdb_app/features/profile_feature/presentation/cubit/favorite_cubit.dart';
import 'package:tmdb_app/features/profile_feature/presentation/cubit/profile_cubit.dart';
import 'package:tmdb_app/features/profile_feature/presentation/cubit/rated_cubit.dart';
import 'package:tmdb_app/features/profile_feature/presentation/cubit/watchlist_cubit.dart';
import 'package:tmdb_app/features/profile_feature/presentation/screens/profile_screen_mobile_impl.dart';
import 'package:tmdb_app/features/profile_feature/presentation/screens/profile_screen_tab_impl.dart';
import 'package:tmdb_app/features/profile_feature/presentation/screens/profile_screen_web_impl.dart';
import 'package:tmdb_app/features/profile_feature/presentation/use_cases/account_media_use_case.dart';
import 'package:tmdb_app/features/profile_feature/presentation/use_cases/profile_use_case.dart';
import 'package:tmdb_app/features/tmdb_widgets/tmdb_app_bar.dart';
import 'package:tmdb_app/network/dio_manager.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final accountId = GetIt.instance.get<HiveManager>().getString(HiveKey.accountId);
    final sessionId = GetIt.instance.get<HiveManager>().getString(HiveKey.sessionId);

    return MultiBlocProvider(
      providers: [
        RepositoryProvider<ProfileApiService>(
          create: (_) => ProfileApiService(GetIt.instance.get<DioManager>().dio),
        ),
        RepositoryProvider<ProfileUseCase>(
          create: (c) => ProfileUseCase(c.read()),
        ),
        RepositoryProvider<AccountMediaUseCase>(
          create: (c) => AccountMediaUseCase(c.read()),
        ),
        BlocProvider(
          create: (c) => FavoriteCubit(c.read()),
        ),
        BlocProvider(
          create: (c) => RatedCubit(c.read()),
        ),
        BlocProvider(
          create: (c) => WatchListCubit(c.read()),
        ),
        BlocProvider(
          create: (c) => ProfileCubit(c.read(), c.read())..fetchProfileDetail(accountId, sessionId),
        ),
      ],
      child: SafeArea(
        child: Scaffold(
          appBar: const TmdbAppBar(),
          body: SizeDetector(
            mobileBuilder: () => ProfileScreenMobileImpl(),
            tabletBuilder: () => ProfileScreenTabImpl(),
            desktopBuilder: () => ProfileScreenWebImpl(),
          ),
        ),
      ),
    );
  }
}
