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

  bool isSuccess = false;
  String? errorMessage;
  T? data;
  int? statusCode;

  ApiMate(
    this._apiCall, {
    this.enableLogging,
  });

  Future<ApiMateResult<T>> call() async {
    final shouldLog = enableLogging ?? ApiMateConfig.enableLogging;

    try {
      if (shouldLog) {
        ApiMateLogger.logRequest(_apiCall.toString());
      }

      final result = await _apiCall();

      if (result is HttpResponse) {
        final response = result.response;
        statusCode = response.statusCode;
        if (response.statusCode != null &&
            response.statusCode! >= 200 &&
            response.statusCode! < 300) {
          isSuccess = true;
          data = result.data;
          if (shouldLog) {
            ApiMateLogger.logResponse(response.statusCode, result.data);
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
      isSuccess = false;
      errorMessage = e.toString();
      if (shouldLog) {
        ApiMateLogger.logError(errorMessage);
      }
      return ApiMateFailure(errorMessage!);
    }
  }
}
