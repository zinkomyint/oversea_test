import 'dart:io';

import 'package:borderlessWorking/repositories/apis.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'apis.dart';

class AuthRepository {
  static String mainUrl = Apis.mailURL;
  var loginUrl = mainUrl + Apis.login;
  final FlutterSecureStorage storage = new FlutterSecureStorage();
  final Dio _dio = Dio();

  Future<bool> hasToken() async {
    var value = await storage.read(key: 'token');
    if (value != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<String> getToken() async {
    var token = await storage.read(key: 'token');
    if (token != null) {
      return token;
    }
  }

  Future<void> addHeaderToken() async {
    var token = await storage.read(key: 'token');
    _dio.options.headers["Demo-Header"] = "Oversea";
    _dio.options.headers["content-cype"] = "application/json";
    _dio.options.headers[HttpHeaders.authorizationHeader] = "Bearer $token";
  }

  Future<void> persistToken(String token) async {
    await storage.write(key: 'token', value: token);
  }

  Future<void> deleteToken() async {
    storage.delete(key: 'token');
    storage.deleteAll();
  }

  Future<String> login(String email, String password) async {
    Response response = await _dio.post(loginUrl, data: {
      "email": email,
      "password": password,
    });
    return response.data["access_token"];
  }
}
