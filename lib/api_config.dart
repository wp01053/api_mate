/// Global configuration for ApiMate.
///
/// This class allows developers to enable or disable logging
/// for all ApiMate API calls project-wide.
class ApiMateConfig {
  static bool enableLogging = true;

  /// Number of retries on network error
  static int retryCount = 0;

  /// Delay between each retry
  static Duration retryDelay = Duration.zero;
}
