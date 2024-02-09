import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:tmdb_app/constants/hive_key.dart';
import 'package:tmdb_app/data_storage/hive_manager.dart';
import 'package:tmdb_app/features/profile_feature/presentation/use_cases/profile_use_case.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileUseCase profileUseCase;

  ProfileCubit(this.profileUseCase) : super(ProfileState.initial());

  void fetchProfileDetail(Future<String> accountId) async {
    emit(
      state.copyWith(
        profileStatus: ProfileLoading(),
      ),
    );
    final result = await profileUseCase.fetchProfileDetail(await accountId);

    result.fold((l) {
      emit(
        state.copyWith(profileStatus: ProfileError(l.errorMessage)),
      );
    }, (r) {
      GetIt.instance.get<HiveManager>().putString(HiveKey.accountId, r.id?.toString() ?? "");
      emit(
        state.copyWith(profileStatus: ProfileSuccess(), profileDetailModel: r),
      );
    });
  }
}
