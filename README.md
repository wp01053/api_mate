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

## 📃 License

MIT License

Copyright (c) 2025 jyjung

Permission is hereby granted, free of charge, to any person obtaining a copy  
of this software and associated documentation files (the "Software"), to deal  
in the Software without restriction, including without limitation the rights  
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell  
copies of the Software, and to permit persons to whom the Software is  
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all  
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR  
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,  
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE  
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER  
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,  
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE  
SOFTWARE.
