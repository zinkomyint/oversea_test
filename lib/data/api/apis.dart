import 'dart:io';
import 'package:borderlessWorking/screens/countr2.dart';
import 'package:borderlessWorking/screens/country.dart';
import 'package:dio/dio.dart';
import 'package:dio_flutter_transformer/dio_flutter_transformer.dart';
import 'package:dio_http_cache/dio_http_cache.dart';

class Apis {
  // static const tester = '';
  static String token = '';
  static const mailURL = "http://192.168.99.207:8000/api/v1";
  static const login = '/auth/login';
  static const contact = '/contact_list';
  static const register = '/jobseeker/register/';
  static const country_list = '/jobseeker/country-list/';
  static const city_list = '/jobseeker/city-list/';
  static const mailunique = '/jobseeker/mail-unity/';
}

Dio getDio() {
  Dio dio = Dio();
  dio.transformer = FlutterTransformer();
  dio.options.headers["Demo-Header"] = "Oversea";
  dio.options.headers["content-type"] = "application/json";
  dio.options.headers[HttpHeaders.authorizationHeader] = "Bearer " + Apis.token;
  dio.interceptors
      .addAll([LogInterceptor(requestBody: true, responseBody: true)]);
  dio.interceptors
      .add(DioCacheManager(CacheConfig(baseUrl: Apis.mailURL)).interceptor);
  return dio;
}
