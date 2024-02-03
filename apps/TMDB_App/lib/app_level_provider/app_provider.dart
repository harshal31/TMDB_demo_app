import "package:get_it/get_it.dart";
import "package:tmdb_app/constants/app_constant.dart";
import "package:tmdb_app/data_storage/hive_manager.dart";
import "package:tmdb_app/features/search_feature/presentation/screens/search_manager.dart";
import "package:tmdb_app/network/dio_manager.dart";

class AppProviders {
  static registerAppLevelProviders() {
    GetIt.instance.registerLazySingleton<HiveManager>(
      () => HiveManager.createHiveManager(),
    );

    GetIt.instance.registerLazySingleton<DioManager>(
      () => DioManager(baseUrl: AppConstant.baseUrl),
    );

    GetIt.instance.registerFactory<SearchManager>(
      () => SearchManager(),
    );
  }
}
