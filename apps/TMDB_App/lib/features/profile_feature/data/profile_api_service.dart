import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:tmdb_app/constants/api_key.dart';
import 'package:tmdb_app/routes/route_param.dart';
import 'package:tmdb_app/constants/endpoint.dart';
import 'package:tmdb_app/features/profile_feature/data/model/profile_detail_model.dart';

part 'profile_api_service.g.dart';

@RestApi()
abstract class ProfileApiService {
  factory ProfileApiService(Dio dio) = _ProfileApiService;

  @GET(Endpoint.accountDetail)
  Future<HttpResponse<ProfileDetailModel>> getProfileDetail(
    @Path(ApiKey.accountId) int accountId,
  );

  @GET(Endpoint.accountDetailWithoutAccountId)
  Future<HttpResponse<ProfileDetailModel>> getProfileDetailWithAccountAndSessionId();
}
