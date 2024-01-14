import "package:fpdart/fpdart.dart";
import "package:get_it/get_it.dart";
import "package:tmdb_app/constants/api_key.dart";
import "package:tmdb_app/constants/hive_key.dart";
import "package:tmdb_app/data_storage/hive_manager.dart";
import "package:tmdb_app/features/authentication_feature/data/authentication_api_service.dart";
import "package:tmdb_app/features/authentication_feature/data/model/new_session.dart";
import "package:tmdb_app/network/error_response.dart";
import "package:tmdb_app/network/safe_api_call.dart";

class SessionUseCase {
  final AuthenticationApiService _authenticationApiService;

  SessionUseCase(this._authenticationApiService);

  Future<Either<ErrorResponse, NewSession>> createNewSession({
    required String token,
  }) async {
    final map = {ApiKey.request_token: token};
    final getToken = await apiCall(() => _authenticationApiService.createNewSession(map));

    return getToken.fold((l) => left(l), (r) {
      GetIt.instance.get<HiveManager>().putString(HiveKey.sessionId, r.sessionId);
      return right(r);
    });
  }
}
