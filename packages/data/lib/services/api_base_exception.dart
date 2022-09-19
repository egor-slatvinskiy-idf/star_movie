enum ApiBaseExceptionType {
  network,
  sessionExpired,
  other,
}

class ApiBaseException implements Exception {
  final ApiBaseExceptionType type;

  ApiBaseException(
    this.type,
  );
}
