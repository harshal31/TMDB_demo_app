import "package:get_it/get_it.dart";
import "package:tmdb_app/features/authentication_feature/data/authentication_api_service.dart";
import "package:tmdb_app/features/authentication_feature/presentation/cubits/authentication_cubit.dart";
import "package:tmdb_app/features/authentication_feature/presentation/cubits/button_state_cubit.dart";
import "package:tmdb_app/features/authentication_feature/presentation/use_case/login_use_case.dart";
import "package:tmdb_app/features/authentication_feature/presentation/use_case/session_use_case.dart";
import "package:tmdb_app/network/dio_manager.dart";

class AuthenticationProviders {
  static void register(GetIt getIt) {
    getIt
      ..registerFactory<AuthenticationApiService>(
        () => AuthenticationApiService(getIt<DioManager>().dio),
      )
      ..registerFactory<LoginUseCase>(
        () => LoginUseCase(getIt()),
      )
      ..registerFactory<SessionUseCase>(
        () => SessionUseCase(getIt()),
      )
      ..registerFactory<AuthenticationCubit>(
        () => AuthenticationCubit(getIt(), getIt()),
      )
      ..registerFactory<ButtonStateCubit>(
        () => ButtonStateCubit(true),
      );
  }
}
