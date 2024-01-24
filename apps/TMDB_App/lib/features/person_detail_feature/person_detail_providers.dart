import 'package:get_it/get_it.dart';
import 'package:tmdb_app/features/person_detail_feature/data/person_detail_api_service.dart';
import 'package:tmdb_app/features/person_detail_feature/presentation/cubits/person_detail_cubit.dart';
import 'package:tmdb_app/features/person_detail_feature/presentation/use_cases/person_detail_use_case.dart';
import 'package:tmdb_app/network/dio_manager.dart';

class PersonDetailProviders {
  static void register(GetIt getIt) {
    getIt
      ..registerFactory<PersonDetailApiService>(
        () => PersonDetailApiService(getIt<DioManager>().dio),
      )
      ..registerFactory<PersonDetailUseCase>(
        () => PersonDetailUseCase(getIt()),
      )
      ..registerFactory<PersonDetailCubit>(
        () => PersonDetailCubit(getIt()),
      );
  }
}
