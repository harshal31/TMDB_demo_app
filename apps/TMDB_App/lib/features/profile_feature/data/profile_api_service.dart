import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:tmdb_app/constants/api_key.dart';
import 'package:tmdb_app/constants/endpoint.dart';
import 'package:tmdb_app/features/home_feature/data/model/latest_results.dart';
import 'package:tmdb_app/features/profile_feature/data/model/profile_detail_model.dart';

part 'profile_api_service.g.dart';

@RestApi()
abstract class ProfileApiService {
  factory ProfileApiService(Dio dio) = _ProfileApiService;

  @GET(Endpoint.accountDetail)
  Future<HttpResponse<ProfileDetailModel>> getProfileDetail(
    @Path(ApiKey.accountId) int accountId,
  );

  @GET(Endpoint.accountMediaWithoutAccountId)
  Future<HttpResponse<LatestResults>> getAccountMediaWithoutAccountId(
    @Path(ApiKey.accountType) String accountType,
    @Path(ApiKey.mediaType) String mediaType,
    @Query(ApiKey.sessionId) String sessionId,
    @Query(ApiKey.page) int page,
    @Query(ApiKey.language) String language,
    @Query(ApiKey.sort_by) String sortBy,
  );

  @GET(Endpoint.accountMediaWithAccountId)
  Future<HttpResponse<LatestResults>> getAccountMediaWithAccountId(
    @Path(ApiKey.accountId) int accountId,
    @Path(ApiKey.accountType) String accountType,
    @Path(ApiKey.mediaType) String mediaType,
    @Query(ApiKey.sessionId) String sessionId,
    @Query(ApiKey.page) int page,
    @Query(ApiKey.language) String language,
    @Query(ApiKey.sort_by) String sortBy,
  );

  @GET(Endpoint.accountDetailWithoutAccountId)
  Future<HttpResponse<ProfileDetailModel>> getProfileDetailWithAccountAndSessionId();
}
