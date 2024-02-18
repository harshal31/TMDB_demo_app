import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:tmdb_app/constants/hive_key.dart';
import 'package:tmdb_app/data_storage/hive_manager.dart';
import 'package:tmdb_app/features/profile_feature/data/profile_api_service.dart';
import 'package:tmdb_app/features/profile_feature/presentation/cubit/profile_cubit.dart';
import 'package:tmdb_app/features/profile_feature/presentation/profile_screen_impl.dart';
import 'package:tmdb_app/features/profile_feature/presentation/use_cases/profile_use_case.dart';
import 'package:tmdb_app/features/tmdb_widgets/tmdb_app_bar.dart';
import 'package:tmdb_app/network/dio_manager.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final accountId = GetIt.instance.get<HiveManager>().getString(HiveKey.accountId);
    return MultiBlocProvider(
      providers: [
        RepositoryProvider<ProfileApiService>(
          create: (_) => ProfileApiService(GetIt.instance.get<DioManager>().dio),
        ),
        RepositoryProvider<ProfileUseCase>(
          create: (c) => ProfileUseCase(c.read()),
        ),
        BlocProvider(
          create: (c) => ProfileCubit(c.read())..fetchProfileDetail(accountId),
        ),
      ],
      child: SafeArea(
        child: Scaffold(
          appBar: const TmdbAppBar(),
          body: ProfileScreenImpl(),
        ),
      ),
    );
  }
}
