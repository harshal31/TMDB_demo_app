import 'package:common_widgets/theme/size_detector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:tmdb_app/features/person_detail_feature/presentation/cubits/person_detail_cubit.dart';
import 'package:tmdb_app/features/person_detail_feature/presentation/screens/mobile/perosn_detail_mobile_screen.dart';
import 'package:tmdb_app/features/person_detail_feature/presentation/screens/tablet/person_detail_tablet_screen.dart';
import 'package:tmdb_app/features/person_detail_feature/presentation/screens/web/person_detail_web_screen.dart';

class PersonDetailScreen extends StatelessWidget {
  final String personId;

  const PersonDetailScreen({
    super.key,
    required this.personId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.instance.get<PersonDetailCubit>()..fetchPersonDetails(personId),
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
