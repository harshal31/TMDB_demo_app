import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:tmdb_app/features/persons_listing_feature/cubits/persons_listing_cubit.dart';
import 'package:tmdb_app/features/persons_listing_feature/cubits/persons_listing_use_case.dart';
import 'package:tmdb_app/features/persons_listing_feature/data/person_listing_api_service.dart';
import 'package:tmdb_app/features/persons_listing_feature/person_listing_screen_impl.dart';
import 'package:tmdb_app/features/tmdb_widgets/tmdb_app_bar.dart';
import 'package:tmdb_app/network/dio_manager.dart';

class PersonListingScreen extends StatelessWidget {
  const PersonListingScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        RepositoryProvider<PersonListingApiService>(
          create: (_) => PersonListingApiService(GetIt.instance.get<DioManager>().dio),
        ),
        RepositoryProvider<PersonListingUseCase>(
          create: (c) => PersonListingUseCase(c.read()),
        ),
        BlocProvider(
          create: (c) => PersonListingCubit(c.read()),
        )
      ],
      child: SafeArea(
        child: Scaffold(
          appBar: const TmdbAppBar(
            shouldDisplayBack: !kIsWeb,
          ),
          body: PersonListingScreenImpl(),
        ),
      ),
    );
  }
}
