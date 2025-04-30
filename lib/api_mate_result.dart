/// Wrapper class that simplifies Dio/Retrofit API calls.
///
/// Automatically wraps responses into [ApiMateResult] types and handles logging.
sealed class ApiMateResult<T> {}

class ApiMateSuccess<T> extends ApiMateResult<T> {
  final T data;
  ApiMateSuccess(this.data);
}

class ApiMateFailure<T> extends ApiMateResult<T> {
  final String errorMessage;
  ApiMateFailure(this.errorMessage);
}
