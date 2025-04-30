import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'api_config.dart';
import 'api_mate_logger.dart';
import 'api_mate_result.dart';

/// Wrapper class that simplifies Dio/Retrofit API calls.
///
/// Automatically wraps responses into [ApiMateResult] types and handles logging.
class ApiMate<T> {
  final Future<T> Function() _apiCall;
  final bool? enableLogging;

  /// Optional override for retry behavior per request.
  final int? retry;
  final Duration? retryDelay;

  bool isSuccess = false;
  String? errorMessage;
  T? data;
  int? statusCode;

  ApiMate(
    this._apiCall, {
    this.enableLogging,
    this.retry,
    this.retryDelay,
  });

  Future<ApiMateResult<T>> call() async {
    final shouldLog = enableLogging ?? ApiMateConfig.enableLogging;
    final retries = retry ?? ApiMateConfig.retryCount;
    final delay = retryDelay ?? ApiMateConfig.retryDelay;

    int attempt = 0;
    while (true) {
      try {
        if (shouldLog) {
          ApiMateLogger.logRequest(_apiCall.toString());
        }

        final result = await _apiCall();

        if (result is HttpResponse) {
          final response = result.response;
          statusCode = response.statusCode;

          if (statusCode != null && statusCode! >= 200 && statusCode! < 300) {
            isSuccess = true;
            data = result.data;
            if (shouldLog) {
              ApiMateLogger.logResponse(statusCode, result.data);
            }
            return ApiMateSuccess(result.data);
          } else {
            isSuccess = false;
            errorMessage = 'HTTP ${response.statusCode} Error';
            if (shouldLog) {
              ApiMateLogger.logError(errorMessage);
            }
            return ApiMateFailure(errorMessage!);
          }
        } else {
          isSuccess = true;
          data = result;
          statusCode = 200;
          if (shouldLog) {
            ApiMateLogger.logResponse(200, result);
          }
          return ApiMateSuccess(result);
        }
      } catch (e) {
        attempt++;
        final shouldRetry = attempt <= retries && _isRetriableError(e);

        if (shouldRetry) {
          if (shouldLog) {
            ApiMateLogger.logError(
                'Retrying in ${delay.inMilliseconds}ms... ($attempt/$retries)');
          }
          await Future.delayed(delay);
          continue;
        }

        isSuccess = false;
        errorMessage = e.toString();
        if (shouldLog) {
          ApiMateLogger.logError(errorMessage);
        }
        return ApiMateFailure(errorMessage!);
      }
    }
  }

  bool _isRetriableError(Object error) {
    if (error is DioException) {
      return error.type == DioExceptionType.connectionTimeout ||
          error.type == DioExceptionType.receiveTimeout ||
          error.type == DioExceptionType.connectionError;
    }
    return false;
  }
}
