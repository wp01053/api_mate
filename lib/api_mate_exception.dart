/// Exception thrown by ApiMate on API failure.
///
/// Wraps the error message into a standard exception type.
class ApiMateException implements Exception {
  final String message;
  ApiMateException(this.message);

  @override
  String toString() => 'ApiMateException: $message';
}
