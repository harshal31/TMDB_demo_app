import "package:dio/dio.dart";
import "package:retrofit/dio.dart";
import "package:retrofit/http.dart";
import "package:tmdb_app/constants/endpoint.dart";
import "package:tmdb_app/features/authentication_feature/data/model/new_request_token.dart";
import "package:tmdb_app/features/authentication_feature/data/model/new_session.dart";

part "authentication_api_service.g.dart";

@RestApi()
abstract class AuthenticationApiService {
  factory AuthenticationApiService(Dio dio) = _AuthenticationApiService;

  @GET(Endpoint.requestNewToken)
  Future<HttpResponse<NewRequestToken>> requestNewToken();

  @POST(Endpoint.validateWithLogin)
  Future<HttpResponse<NewRequestToken>> validateWithLogin(
    @Body() Map<String, dynamic> loginBody,
  );

  @POST(Endpoint.createNewSession)
  Future<HttpResponse<NewSession>> createNewSession(
    @Body() Map<String, dynamic> sessionBody,
  );
}
