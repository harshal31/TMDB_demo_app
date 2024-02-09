import 'package:equatable/equatable.dart';
import 'package:fpdart/src/either.dart';
import 'package:tmdb_app/features/profile_feature/data/model/profile_detail_model.dart';
import 'package:tmdb_app/features/profile_feature/data/profile_api_service.dart';
import 'package:tmdb_app/network/error_response.dart';
import 'package:tmdb_app/network/safe_api_call.dart';

class ProfileUseCase {
  final ProfileApiService _profileApiService;

  ProfileUseCase(this._profileApiService);

  Future<Either<ErrorResponse, ProfileDetailModel>> fetchProfileDetail(String accountId) async {
    final result = await apiCall(() => accountId.isNotEmpty
        ? _profileApiService.getProfileDetail(int.parse(accountId))
        : _profileApiService.getProfileDetailWithAccountAndSessionId());

    return result;
  }
}

class ProfileState with EquatableMixin {
  final ProfileStatus profileStatus;
  final ProfileDetailModel? profileDetailModel;

  ProfileState(this.profileStatus, this.profileDetailModel);

  factory ProfileState.initial() {
    return ProfileState(ProfileNone(), null);
  }

  ProfileState copyWith({
    ProfileStatus? profileStatus,
    ProfileDetailModel? profileDetailModel,
  }) {
    return ProfileState(
      profileStatus ?? this.profileStatus,
      profileDetailModel ?? this.profileDetailModel,
    );
  }

  @override
  List<Object?> get props => [
        profileStatus,
        profileDetailModel,
      ];
}

sealed class ProfileStatus with EquatableMixin {
  @override
  List<Object?> get props => [];
}

class ProfileNone extends ProfileStatus {}

class ProfileLoading extends ProfileStatus {}

class ProfileSuccess extends ProfileStatus {}

class ProfileError extends ProfileStatus {
  final String error;

  ProfileError(this.error);

  @override
  List<Object?> get props => [error];
}
