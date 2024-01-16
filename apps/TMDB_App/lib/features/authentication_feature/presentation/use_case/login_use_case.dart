import "package:equatable/equatable.dart";
import "package:flutter/foundation.dart";
import "package:fpdart/fpdart.dart";
import "package:get_it/get_it.dart";
import "package:tmdb_app/constants/api_key.dart";
import "package:tmdb_app/constants/hive_key.dart";
import "package:tmdb_app/data_storage/hive_manager.dart";
import "package:tmdb_app/features/authentication_feature/data/authentication_api_service.dart";
import "package:tmdb_app/features/authentication_feature/data/model/new_request_token.dart";
import "package:tmdb_app/network/error_response.dart";
import "package:tmdb_app/network/safe_api_call.dart";

class LoginUseCase {
  final AuthenticationApiService _authenticationApiService;

  LoginUseCase(this._authenticationApiService);

  Future<Either<ErrorResponse, NewRequestToken>> validateWithLogin({
    required String userName,
    required String password,
  }) async {
    final getToken = await apiCall(() => _authenticationApiService.requestNewToken());
    return getToken.fold((l) => left(l), (r) async {
      final loginBody = {
        ApiKey.username: userName,
        ApiKey.password: password,
        ApiKey.requestToken: r.requestToken,
      };
      final getLoginToken = await apiCall(
        () => _authenticationApiService.validateWithLogin(loginBody),
      );
      return getLoginToken.fold((l) => left(l), (r) {
        GetIt.instance.get<HiveManager>().putString(HiveKey.requestToken, r.requestToken);
        return right(r);
      });
    });
  }
}

class LoginState with EquatableMixin {
  final LoginStatus? status;
  final bool shouldObscure;

  LoginState({this.status, this.shouldObscure = true});

  LoginState copyWith({
    LoginStatus? status,
    bool? shouldVisiblePassword,
  }) {
    return LoginState(
      status: status ?? this.status,
      shouldObscure: shouldVisiblePassword ?? this.shouldObscure,
    );
  }

  factory LoginState.initial() {
    return LoginState(status: None());
  }

  @override
  List<Object?> get props => [status, shouldObscure];
}

sealed class LoginStatus with EquatableMixin {
  @override
  List<Object?> get props => [];
}

class None extends LoginStatus {
  final String uniqueKey = UniqueKey().toString();

  @override
  List<Object?> get props => [uniqueKey];
}

class LoginLoading extends LoginStatus {}

class LoginSuccess extends LoginStatus {
  final String message;

  LoginSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class LoginFailed extends LoginStatus {
  final String message;

  LoginFailed(this.message);

  @override
  List<Object?> get props => [message];
}
