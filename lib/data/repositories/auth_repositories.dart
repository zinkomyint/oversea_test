import 'dart:io';

import 'package:borderlessWorking/data/api/apiServices.dart';
import 'package:borderlessWorking/data/api/apis.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthRepository {
  final ApiService _apiService = ApiService();
  final FlutterSecureStorage storage = new FlutterSecureStorage();

  Future<bool> hasToken() => _apiService.hasToken();

  Future<void> persistToken(String token) => _apiService.persistToken(token);

  Future<void> deleteToken() => _apiService.deleteToken();

  Future<String> login(String email, String password) =>
      _apiService.login(email, password);
}
