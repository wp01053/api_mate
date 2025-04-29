# ApiMate

A lightweight, elegant API call wrapper for Dio + Retrofit in Flutter.  
It standardizes response handling using a sealed class result (`ApiMateResult`)  
and supports pretty logging + global config with minimal boilerplate.

---

## 🚀 Features

- ✅ Supports both `Future<T>` and `Future<HttpResponse<T>>`
- 📦 Sealed result type: `ApiMateSuccess`, `ApiMateFailure`
- 🪵 Pretty console logger for request/response/error
- 🌐 Global config with `ApiMateConfig.enableLogging`
- 🧼 Clean structure without callbacks or magic

---

## 🔧 Installation

```yaml
dependencies:
  api_mate: ^0.2.2
```

---

## 🛠️ Usage

### 1. Optional: Disable logging globally

```dart
void main() {
  ApiMateConfig.enableLogging = false; // disable logs globally
  runApp(MyApp());
}
```

---

### 2. Make an API call

```dart
final request = ApiMate(() => client.getPost(1));
final result = await request.call();

switch (result) {
  case ApiMateSuccess<Post>():
    print('✅ Success: ${result.data.title}');
    break;
  case ApiMateFailure():
    print('❌ Error: ${result.errorMessage}');
    break;
}
```

---

### 3. Override logging per request (optional)

```dart
final request = ApiMate(
  () => client.getPost(1),
  enableLogging: true, // force enable for this call
);
await request.call();
```

---

## 📁 Folder Structure

```
lib/
  api_mate/
    api_mate.dart
    api_mate_config.dart
    api_mate_logger.dart
    api_mate_result.dart
    api_mate_exception.dart
```

---

