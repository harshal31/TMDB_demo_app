import 'package:common_widgets/theme/size_detector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:tmdb_app/features/person_detail_feature/data/person_detail_api_service.dart';
import 'package:tmdb_app/features/person_detail_feature/presentation/cubits/person_detail_cubit.dart';
import 'package:tmdb_app/features/person_detail_feature/presentation/screens/mobile/perosn_detail_mobile_screen.dart';
import 'package:tmdb_app/features/person_detail_feature/presentation/screens/tablet/person_detail_tablet_screen.dart';
import 'package:tmdb_app/features/person_detail_feature/presentation/screens/web/person_detail_web_screen.dart';
import 'package:tmdb_app/features/person_detail_feature/presentation/use_cases/person_detail_use_case.dart';
import 'package:tmdb_app/network/dio_manager.dart';

class PersonDetailScreen extends StatelessWidget {
  final String personId;

  const PersonDetailScreen({
    super.key,
    required this.personId,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        RepositoryProvider<PersonDetailApiService>(
          create: (_) => PersonDetailApiService(GetIt.instance.get<DioManager>().dio),
        ),
        RepositoryProvider<PersonDetailUseCase>(
          create: (c) => PersonDetailUseCase(c.read()),
        ),
        BlocProvider(
          create: (c) => PersonDetailCubit(c.read())..fetchPersonDetails(personId),
        ),
      ],
      child: SafeArea(
        child: Scaffold(
          body: SizeDetector(
            mobileBuilder: () => const PersonDetailMobileScreen(),
            tabletBuilder: () => const PersonDetailTabletScreen(),
            desktopBuilder: () => const PersonDetailWebScreen(),
          ),
        ),
      ),
    );
  }
}
