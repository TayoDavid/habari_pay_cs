enum ApiResponseType {
  success,
  failed,
  badRequest,
  unauthorized,
  invalidKey;

  String get value {
    switch (this) {
      case ApiResponseType.success:
        return "Successful";
      case ApiResponseType.failed:
        return "Failed";
      case ApiResponseType.badRequest:
        return "Bad Request";
      case ApiResponseType.unauthorized:
        return "Unauthorized Request";
      case ApiResponseType.invalidKey:
        return "Invalid API Key";
    }
  }
}
