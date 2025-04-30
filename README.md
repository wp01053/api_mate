# ApiMate

Tired of writing repetitive `try-catch`, status code checks, and logging for every API call?

**ApiMate** is the simplest way to wrap Dio + Retrofit with clean success/failure handling, global config, and beautiful logging — all in **one line**.

---

### 🍯 From this 👇

```dart
try {
  final response = await dio.get('/user');
  if (response.statusCode == 200) {
    // success
  } else {
    // handle error
  }
} catch (e) {
  // error
}
```

### ✨ To this 👇

```dart
final result = await ApiMate(() => client.getUser()).call();

switch (result) {
  case ApiMateSuccess(): print(result.data);
  case ApiMateFailure(): print(result.errorMessage);
}
```

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
  api_mate: ^0.2.3
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

