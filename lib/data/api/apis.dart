import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Apis {
  static const mailURL = "http://192.168.100.27:8000/api/v1";
  static const login = '/auth/login';
}

Dio getDio() {
  Dio dio = new Dio(new BaseOptions(
      baseUrl: Apis.mailURL,
      contentType: ContentType.json.toString(),
      responseType: ResponseType.json));
  dio.interceptors.addAll([
    // Append authorization
    InterceptorsWrapper(onRequest: (RequestOptions options) async {
      final FlutterSecureStorage storage = new FlutterSecureStorage();
      String token = await storage.read(key: 'token');
      if (token != null) {
        dio.options.headers["Demo-Header"] = "Oversea";
        dio.options.headers["content-cype"] = "application/json";
        dio.options.headers[HttpHeaders.authorizationHeader] = "Bearer $token";
      }
      return dio.options;
    }),

    // Debug request
    LogInterceptor(requestBody: true, responseBody: true)
  ]);
  return dio;
}
