import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Apis {
  static const mailURL = "http://192.168.100.27:8000/api/v1";
  static const login = '/auth/login';
  static const contact = '/contact_list';
  static String token = '';
}

Dio getDio() {
  Dio dio = Dio();
  dio.options.headers["Demo-Header"] = "Oversea";
  dio.options.headers["content-type"] = "application/json";
  dio.options.headers[HttpHeaders.authorizationHeader] = "Bearer " + Apis.token;
  dio.interceptors
      .addAll([LogInterceptor(requestBody: true, responseBody: true)]);
  return dio;
}
