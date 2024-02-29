import 'package:fpdart/fpdart.dart';
import 'package:tmdb_app/constants/api_key.dart';
import 'package:tmdb_app/features/home_feature/data/model/latest_results.dart';
import 'package:tmdb_app/features/profile_feature/data/profile_api_service.dart';
import 'package:tmdb_app/network/error_response.dart';
import 'package:tmdb_app/network/safe_api_call.dart';
import 'package:tmdb_app/utils/either_extensions.dart';

class AccountMediaUseCase {
  final ProfileApiService _profileApiService;

  AccountMediaUseCase(this._profileApiService);

  Future<Either<ErrorResponse, List<LatestResults?>>> initialFetchAccountMedia(
    String accountId,
    List<String> accountTypes,
    String sessionId,
  ) async {
    final calls = await Future.wait(
      [
        apiCall(
          () => accountId.isNotEmpty
              ? _profileApiService.getAccountMediaWithAccountId(
                  int.parse(accountId),
                  accountTypes[0],
                  ApiKey.movies,
                  sessionId,
                  1,
                  ApiKey.defaultLanguage,
                  ApiKey.account_sorted_order,
                )
              : _profileApiService.getAccountMediaWithoutAccountId(
                  accountTypes[0],
                  ApiKey.movies,
                  sessionId,
                  1,
                  ApiKey.defaultLanguage,
                  ApiKey.account_sorted_order,
                ),
        ),
        apiCall(
          () => accountId.isNotEmpty
              ? _profileApiService.getAccountMediaWithAccountId(
                  int.parse(accountId),
                  accountTypes[1],
                  ApiKey.movies,
                  sessionId,
                  1,
                  ApiKey.defaultLanguage,
                  ApiKey.account_sorted_order,
                )
              : _profileApiService.getAccountMediaWithoutAccountId(
                  accountTypes[1],
                  ApiKey.movies,
                  sessionId,
                  1,
                  ApiKey.defaultLanguage,
                  ApiKey.account_sorted_order,
                ),
        ),
        apiCall(
          () => accountId.isNotEmpty
              ? _profileApiService.getAccountMediaWithAccountId(
                  int.parse(accountId),
                  accountTypes[2],
                  ApiKey.movies,
                  sessionId,
                  1,
                  ApiKey.defaultLanguage,
                  ApiKey.account_sorted_order,
                )
              : _profileApiService.getAccountMediaWithoutAccountId(
                  accountTypes[2],
                  ApiKey.movies,
                  sessionId,
                  1,
                  ApiKey.defaultLanguage,
                  ApiKey.account_sorted_order,
                ),
        ),
      ],
    );

    if (calls.all((e) => e.getRightOrNull == null)) {
      return left(
        ErrorResponse(errorCode: -1, errorMessage: "Not able to fetch account media details"),
      );
    }

    return right(
      calls.map((e) => e.getRightOrNull).toList(),
    );
  }

  Future<Either<ErrorResponse, LatestResults>> fetchAccountMedia(
    String accountId,
    String accountType,
    String mediaType,
    String sessionId,
  ) async {
    final result = await apiCall(
      () => accountId.isNotEmpty
          ? _profileApiService.getAccountMediaWithAccountId(
              int.parse(accountId),
              accountType,
              mediaType,
              sessionId,
              1,
              ApiKey.defaultLanguage,
              ApiKey.account_sorted_order,
            )
          : _profileApiService.getAccountMediaWithoutAccountId(
              accountType,
              mediaType,
              sessionId,
              1,
              ApiKey.defaultLanguage,
              ApiKey.account_sorted_order,
            ),
    );

    return result.fold((l) => left(l), (r) => right(r));
  }
}
