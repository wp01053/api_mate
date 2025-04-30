import 'dart:convert';

/// Logger for ApiMate that pretty-prints API request, response, and error.
class ApiMateLogger {
  static void logRequest(String path) {
    final now = DateTime.now();
    print("\n========== 🛰️ [ApiMate Request] [$now] ==========");
    print("Path: $path");
    print("===============================================\n");
  }

  static void logResponse(int? statusCode, dynamic data) {
    final now = DateTime.now();
    print("\n========== 📦 [ApiMate Response] [$now] ==========");
    print("Status Code: $statusCode");
    print("Body:\n${_prettyPrintJson(data)}");
    print("===============================================\n");
  }

  static void logError(dynamic error) {
    final now = DateTime.now();
    print("\n========== ❌ [ApiMate Error] [$now] ==========");
    print("Error: $error");
    print("===============================================\n");
  }

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
