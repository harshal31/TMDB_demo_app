import 'package:equatable/equatable.dart';
import 'package:fpdart/src/either.dart';
import 'package:tmdb_app/features/home_feature/data/model/latest_results.dart';
import 'package:tmdb_app/features/profile_feature/data/model/account_detail_data.dart';
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
  final AccountDetailData accountDetailData;

  ProfileState(
    this.profileStatus,
    this.profileDetailModel,
    this.accountDetailData,
  );

  factory ProfileState.initial() {
    return ProfileState(
      ProfileNone(),
      null,
      AccountDetailData.initial(),
    );
  }

  ProfileState copyWith({
    ProfileStatus? profileStatus,
    ProfileDetailModel? profileDetailModel,
    AccountDetailData? accountDetailData,
  }) {
    return ProfileState(
      profileStatus ?? this.profileStatus,
      profileDetailModel ?? this.profileDetailModel,
      accountDetailData ?? this.accountDetailData,
    );
  }

  @override
  List<Object?> get props => [
        profileStatus,
        profileDetailModel,
        accountDetailData,
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

class AccountState with EquatableMixin {
  final LatestResults? latestResults;
  final AccountStatus accountStatus;
  final int pos;

  AccountState(this.latestResults, this.accountStatus, this.pos);

  factory AccountState.initial() {
    return AccountState(null, AccountNone(), 0);
  }

  AccountState copyWith({
    LatestResults? latestResults,
    AccountStatus? accountStatus,
    int? pos,
  }) {
    return AccountState(
      latestResults ?? this.latestResults,
      accountStatus ?? this.accountStatus,
      pos ?? this.pos,
    );
  }

  @override
  List<Object?> get props => [
        latestResults,
        accountStatus,
        pos,
      ];
}

sealed class AccountStatus with EquatableMixin {
  @override
  List<Object?> get props => [];
}

class AccountNone extends AccountStatus {}

class AccountLoading extends AccountStatus {
  final String uniqueKey;

  AccountLoading(this.uniqueKey);

  @override
  List<Object?> get props => [uniqueKey];
}

class AccountError extends AccountStatus {
  final String error;

  AccountError(this.error);

  @override
  List<Object?> get props => [error];
}

class AccountDone extends AccountStatus {
  final String uniqueKey;

  AccountDone(this.uniqueKey);

  @override
  List<Object?> get props => [uniqueKey];
}
