import 'package:tmdb_app/utils/size_detector.dart';
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:get_it/get_it.dart";
import "package:tmdb_app/features/authentication_feature/data/authentication_api_service.dart";
import "package:tmdb_app/features/authentication_feature/presentation/cubits/authentication_cubit.dart";
import "package:tmdb_app/features/authentication_feature/presentation/cubits/button_state_cubit.dart";
import "package:tmdb_app/features/authentication_feature/presentation/screens/mobile/authentication_mobile_screen.dart";
import "package:tmdb_app/features/authentication_feature/presentation/screens/tablet/authentication_tablet_screen.dart";
import "package:tmdb_app/features/authentication_feature/presentation/screens/web/authentication_web_screen.dart";
import "package:tmdb_app/features/authentication_feature/presentation/use_case/login_use_case.dart";
import "package:tmdb_app/features/authentication_feature/presentation/use_case/session_use_case.dart";
import "package:tmdb_app/network/dio_manager.dart";

class AuthenticationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        RepositoryProvider<AuthenticationApiService>(
          create: (_) => AuthenticationApiService(GetIt.instance.get<DioManager>().dio),
        ),
        RepositoryProvider<LoginUseCase>(
          create: (c) => LoginUseCase(c.read()),
        ),
        RepositoryProvider<SessionUseCase>(
          create: (c) => SessionUseCase(c.read()),
        ),
        BlocProvider(
          create: (c) => AuthenticationCubit(c.read(), c.read()),
        ),
        BlocProvider(
          create: (c) => ButtonStateCubit(true),
        ),
      ],
      child: Scaffold(
        body: SizeDetector(
          mobileBuilder: () => const AuthenticationMobileScreen(),
          tabletBuilder: () => const AuthenticationTabletScreen(),
          desktopBuilder: () => const AuthenticationWebScreen(),
        ),
      ),
    );
  }
}
