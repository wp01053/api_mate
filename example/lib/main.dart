import 'package:api_mate/api_mate.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'api_client.dart'; // Retrofit client 정의된 파일

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ApiMate Example',
      home: Scaffold(
        appBar: AppBar(title: const Text('ApiMate v0.2 Retrofit Example')),
        body: Center(
          child: ElevatedButton(
            child: const Text('Call API'),

            onPressed: () async {
              final dio = Dio();
              final client = ApiClient(dio);
              final request = ApiMate(() => client.getPost(1));
              await request.call();

              if (request.isSuccess && request.data != null) {
                final post = request.data!;
                debugPrint('success: ${post.title}');
              } else {
                debugPrint('fail: ${request.errorMessage}');
              }
            },
          ),
        ),
      ),
    );
  }
}
