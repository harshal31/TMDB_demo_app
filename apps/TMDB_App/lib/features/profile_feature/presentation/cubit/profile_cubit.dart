import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:tmdb_app/constants/api_key.dart';
import 'package:tmdb_app/constants/hive_key.dart';
import 'package:tmdb_app/data_storage/hive_manager.dart';
import 'package:tmdb_app/features/profile_feature/data/model/account_detail_data.dart';
import 'package:tmdb_app/features/profile_feature/presentation/use_cases/account_media_use_case.dart';
import 'package:tmdb_app/features/profile_feature/presentation/use_cases/profile_use_case.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileUseCase profileUseCase;
  final AccountMediaUseCase accountMediaUseCase;

  ProfileCubit(this.profileUseCase, this.accountMediaUseCase) : super(ProfileState.initial());

  void fetchProfileDetail(Future<String> accountId, Future<String> sesId) async {
    emit(
      state.copyWith(
        profileStatus: ProfileLoading(),
      ),
    );

    final actId = await accountId;
    final sessionId = await sesId;
    final result = await profileUseCase.fetchProfileDetail(actId);
    final accountInfo = await accountMediaUseCase.initialFetchAccountMedia(
      actId,
      [
        ApiKey.favorite,
        ApiKey.rated,
        ApiKey.watchList,
      ],
      sessionId,
    );

    result.fold(
      (l) {
        emit(
          state.copyWith(profileStatus: ProfileError(l.errorMessage)),
        );
      },
      (pro) {
        if ((pro.id?.toString() ?? "").isNotEmpty) {
          GetIt.instance.get<HiveManager>().putString(HiveKey.accountId, pro.id?.toString() ?? "");
        }

        accountInfo.fold((l) {
          emit(
            state.copyWith(profileStatus: ProfileError(l.errorMessage)),
          );
        }, (r) {
          final accountDetailData = AccountDetailData(
            favorites: r.first,
            rated: r[1],
            watchList: r.last,
          );
          emit(
            state.copyWith(
              profileStatus: ProfileSuccess(),
              profileDetailModel: pro,
              accountDetailData: accountDetailData,
            ),
          );
        });
      },
    );
  }
}
