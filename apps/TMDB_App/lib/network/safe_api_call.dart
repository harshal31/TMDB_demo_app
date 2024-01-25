import "dart:io";

import "package:common_widgets/logger/log_manager.dart";
import "package:dio/dio.dart";
import "package:fpdart/fpdart.dart";
import "package:retrofit/dio.dart";
import "package:tmdb_app/network/error_response.dart";

Future<Either<ErrorResponse, T>> apiCall<T>(Future<HttpResponse<T>> Function() call) async {
  try {
    final networkCall = await call();
    final statusCode = (networkCall.response.statusCode ?? 0);
    if (statusCode >= 200 && statusCode <= 205) {
      return right(networkCall.data);
    } else {
      return left(ErrorResponse.fromJson(networkCall.response.data));
    }
  } on SocketException catch (e) {
    return left(ErrorResponse.initial(errorCode: -1, errorMsg: e.message));
  } on DioException catch (e) {
    return left(ErrorResponse.fromJson(e.response?.data));
  } catch (e, s) {
    Log.e("Error occurred", error: e, stackTrace: s);
    return left(ErrorResponse.initial(errorCode: -1, errorMsg: "Something Went Wrong"));
  }
}
