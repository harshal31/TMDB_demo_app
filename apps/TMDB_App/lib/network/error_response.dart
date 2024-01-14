class ErrorResponse {
  final int errorCode;
  final String errorMessage;

  ErrorResponse({
    required this.errorCode,
    required this.errorMessage,
  });

  factory ErrorResponse.initial({
    int? errorCode,
    String? errorMsg,
  }) {
    return ErrorResponse(
      errorCode: errorCode ?? 0,
      errorMessage: errorMsg ?? "",
    );
  }

  factory ErrorResponse.fromJson(Map<String, dynamic> json) {
    int errorCode = json["status_code"] as int;
    String errMsg = json["status_message"] as String;
    return ErrorResponse(
      errorCode: errorCode,
      errorMessage: errMsg,
    );
  }

  static bool isSessionExpire(int errorCode) {
    return errorCode == 3 ||
        errorCode == 7 ||
        errorCode == 10 ||
        errorCode == 14 ||
        errorCode == 16 ||
        errorCode == 17 ||
        (errorCode >= 30 && errorCode <= 33) ||
        (errorCode >= 35 && errorCode <= 39 && errorCode != 37);
  }
}
