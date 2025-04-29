class ApiMateException implements Exception {
  final String message;
  ApiMateException(this.message);

  @override
  String toString() => 'ApiMateException: $message';
}
