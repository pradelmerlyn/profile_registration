import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ApiClient {
  static final Dio dio = Dio(BaseOptions(
    baseUrl: 'https://us-central1-bootcamp-dev-8f3ed.cloudfunctions.net',
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
  ))
    ..interceptors.addAll([
      LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: false,
        responseBody: true,
        error: true,
        logPrint: (object) => debugPrint('📡 $object'),
      ),
    ]);
}
