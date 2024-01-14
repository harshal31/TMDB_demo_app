import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:get_it/get_it.dart";
import "package:tmdb_app/features/authentication_feature/presentation/cubits/authentication_cubit.dart";
import "package:tmdb_app/features/authentication_feature/presentation/cubits/button_state_cubit.dart";
import "package:tmdb_app/features/authentication_feature/presentation/screens/mobile/authentication_mobile.dart";
import "package:tmdb_app/features/authentication_feature/presentation/screens/tablet/authentication_tablet.dart";
import "package:tmdb_app/features/authentication_feature/presentation/screens/web/authentication_web.dart";
import "package:tmdb_app/theme/size_detector.dart";

class AuthenticationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (c) => GetIt.instance.get<AuthenticationCubit>(),
        ),
        BlocProvider(
          create: (c) => GetIt.instance.get<ButtonStateCubit>(),
        ),
      ],
      child: Scaffold(
        body: SizeDetector(
          mobileBuilder: () => AuthenticationMobile(),
          tabletBuilder: () => AuthenticationTablet(),
          desktopBuilder: () => AuthenticationWeb(),
        ),
      ),
    );
  }
}
