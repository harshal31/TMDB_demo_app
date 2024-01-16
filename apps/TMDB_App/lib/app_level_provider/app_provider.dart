import "package:get_it/get_it.dart";
import "package:tmdb_app/constants/app_constant.dart";
import "package:tmdb_app/data_storage/hive_manager.dart";
import "package:tmdb_app/features/authentication_feature/authentication_providers.dart";
import "package:tmdb_app/features/home_feature/home_providers.dart";
import "package:tmdb_app/network/dio_manager.dart";

class AppProviders {
  static registerAppLevelProviders() {
    GetIt.instance.registerLazySingleton<HiveManager>(
      () => HiveManager.createHiveManager(),
    );

    GetIt.instance.registerLazySingleton<DioManager>(
      () => DioManager(baseUrl: AppConstant.baseUrl),
    );

    AuthenticationProviders.register(GetIt.instance);
    HomeProviders.register(GetIt.instance);
  }
}
