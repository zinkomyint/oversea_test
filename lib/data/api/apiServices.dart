import 'dart:io';

import 'package:borderlessWorking/data/api/apis.dart';
import 'package:borderlessWorking/data/api/httpHelper.dart';
import 'package:borderlessWorking/data/model/contact.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'apis.dart';

class ApiService {
  static String mainUrl = Apis.mailURL;
  var loginUrl = mainUrl + Apis.login;
  var contactUrl = mainUrl + Apis.contact;
  final FlutterSecureStorage storage = new FlutterSecureStorage();
  // Dio dio = Dio();
  final _dio = getDio();
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

  Future<void> persistToken(String token) async {
    await storage.write(key: 'token', value: token);
  }

  Future<void> deleteToken() async {
    storage.delete(key: 'token');
    storage.deleteAll();
  }

  //login
  Future<String> login(String email, String password) async {
    Response response = await _dio.post(loginUrl, data: {
      "email": email,
      "password": password,
    });
    return response.data["access_token"];
  }

  //getContact
  Future<ContactModel> getContactList() async {
    try {
      Response response = await _dio.get(contactUrl);
      return ContactModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return ContactModel.withError("Data not found / Connection issue");
    }
  }
}
