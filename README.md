# ApiMate

A lightweight, elegant API call wrapper for Dio + Retrofit in Flutter.
It wraps responses into a consistent sealed result, provides pretty logging, global configuration, and now supports **automatic retry**.

---

## 🚀 What's New in v0.3.0

- ✅ **Automatic retry** support (configurable globally and per-request)
- 🕓 `retryCount` and `retryDelay` in `ApiMateConfig`
- 🎯 Clean fallback logic for `DioException`-based retry types

---

## 📦 Installation

```yaml
dependencies:
  api_mate: ^0.3.0
```

---

## ✨ Features

- ✅ Supports both `Future<T>` and `Future<HttpResponse<T>>`
- 📦 Sealed result: `ApiMateSuccess`, `ApiMateFailure`
- 🪵 Pretty logging for requests, responses, and errors
- 🌐 Global config via `ApiMateConfig`
- 🔁 Automatic retry on timeout or connection errors
- 🔧 Per-request override of logging or retry settings

---

## 🧩 Usage

### Minimal Example

```dart
final result = await ApiMate(() => client.getUser()).call();

switch (result) {
  case ApiMateSuccess():
    print(result.data);
    break;
  case ApiMateFailure():
    print(result.errorMessage);
    break;
}
```

### Retry Example

```dart
final result = await ApiMate(
  () => client.getUser(),
  retry: 2,
  retryDelay: Duration(seconds: 1),
).call();
```

### Global Retry Setting

```dart
void main() {
  ApiMateConfig.retryCount = 3;
  ApiMateConfig.retryDelay = Duration(seconds: 2);
  runApp(MyApp());
}
```

---

## 📁 Folder Structure

```
lib/
  api_mate/
    api_mate.dart              // Main class with retry logic
    api_mate_config.dart       // Global settings
    api_mate_logger.dart       // Pretty logger
    api_mate_result.dart       // Sealed result class
    api_mate_exception.dart    // Exception wrapper
```

---
