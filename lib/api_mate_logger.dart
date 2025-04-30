// lib/api_mate/api_mate_logger.dart

import 'dart:convert';

/// Console color codes for highlighting logs.
class ConsoleStyle {
  static const reset = '\x1B[0m';
  static const green = '\x1B[32m';
  static const red = '\x1B[31m';
  static const yellow = '\x1B[33m';
  static const blue = '\x1B[34m';
  static const gray = '\x1B[90m';
}

/// Logger for ApiMate that pretty-prints API request, response, and error.
class ApiMateLogger {
  static bool useEmoji = false;
  static bool useColor = true;

  /// Logs the request path.
  static void logRequest(String path) {
    final now = DateTime.now();
    final tag = useEmoji ? "🛰️ Request" : "Request";
    final prefix = useColor ? ConsoleStyle.blue : '';
    final reset = useColor ? ConsoleStyle.reset : '';

    print("\n========== $prefix[$tag] [$now]$reset ==========");
    print("Path: $path");
    print("===============================================\n");
  }

  /// Logs the response status and data.
  static void logResponse(int? statusCode, dynamic data) {
    final now = DateTime.now();
    final tag = useEmoji ? "📦 Response" : "Response";
    final prefix = useColor ? ConsoleStyle.green : '';
    final reset = useColor ? ConsoleStyle.reset : '';

    print("\n========== $prefix[$tag] [$now]$reset ==========");
    print("Status Code: $statusCode");
    print("Body:\n${_prettyPrintJson(data)}");
    print("===============================================\n");
  }

  /// Logs the error message.
  static void logError(dynamic error) {
    final now = DateTime.now();
    final tag = useEmoji ? "❌ Error" : "Error";
    final prefix = useColor ? ConsoleStyle.red : '';
    final reset = useColor ? ConsoleStyle.reset : '';

    print("\n========== $prefix[$tag] [$now]$reset ==========");
    print("Error: $error");
    print("===============================================\n");
  }

  /// Formats the input into pretty JSON if possible, else returns string.
  static String _prettyPrintJson(dynamic input) {
    try {
      if (input is String) {
        final jsonObject = jsonDecode(input);
        const encoder = JsonEncoder.withIndent('  ');
        return encoder.convert(jsonObject);
      } else if (input is Map || input is List) {
        const encoder = JsonEncoder.withIndent('  ');
        return encoder.convert(input);
      }
      return input.toString();
    } catch (e) {
      return input.toString();
    }
  }
}
