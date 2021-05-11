import 'dart:io';

import 'package:borderlessWorking/data/api/apis.dart';
import 'package:borderlessWorking/data/model/contact.dart';
import 'package:borderlessWorking/data/model/getcity.dart';
import 'package:borderlessWorking/data/model/getcountry.dart';
import 'package:borderlessWorking/data/model/register.dart';
import 'package:borderlessWorking/screens/country.dart';
import 'package:borderlessWorking/screens/register/dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:retrofit/dio.dart';
import 'apis.dart';
import 'package:dio/dio.dart';

class ApiService {
  static String mainUrl = Apis.mailURL;
  var loginUrl = mainUrl + Apis.login;
  var contactUrl = mainUrl + Apis.contact;
  var registerUrl = mainUrl + Apis.register;
  var getcountryUrl = mainUrl + Apis.country_list;
  var getcityUrl = mainUrl + Apis.city_list;
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
  Future<List<ContactModel>> getContactLists() async {
    List<ContactModel> _dataList = [];
    Response response = await _dio.get(contactUrl);
    var body = (response.data);
    try {
      if (response.statusCode == 200) {
        for (var item in body['contacts']) {
          ContactModel data = new ContactModel.fromJson(item);
          _dataList.add(data);
        }
        return _dataList;
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      //  return ContactModel.withError('asdfasdfasdfasdf');

    }
  }
   //String name,birthday, furigana,mobile,email,password;
  //register
  // Future<Register> register2(String name,String birthday,String furigana,String mobile,String email, String password) async {
  //   Response response = await _dio.post(registerUrl, data: {
  //     "name": name,
  //     "birthday": birthday,
  //     "furigana": furigana,
  //     "mobile": mobile,
  //     "email": email,
  //     "password": password,

  //   });
  //   return response.data;
  // }

  //  Future<Register> register1(String name,String birthday,String furigana,String mobile,String email, String password) async {
  //    try{
  //     Response response = await _dio.post(registerUrl, data: {
  //     "name": name,
  //     "birthday": birthday,
  //     "furigana": furigana,
  //     "mobile": mobile,
  //     "email": email,
  //     "password": password,

  //   });
  //   if(response.statusCode == HttpStatus.ok)
  //   {
  //     return Register.fromJson(response.data);
  //   }
  //   else{
  //     throw SocketException('No Internet');
  //   }
  //    }
  //    catch(error, stacktrace){
  //        print("Exception occured: $error stackTrace: $stacktrace");
  //       //  return Register.withError("$error");
  //    }
    //final_code//

    //Register
     Future<Map<String,dynamic>> register(
      String jobseeker_name,
      String jobseeker_furigana_name,
      String dob,
      String phone,
      String email,
      String password,
     ) async {
    Response response = await _dio.post(registerUrl, data: {
      "name": jobseeker_name,
      "jobseeker_furigana_name": jobseeker_furigana_name,
      "dob": dob,
      "phone": phone,
      "email": email,
      "password": password,
 
    });
    return response.data;
  }
  //Register
  
  //Getcountry 
  Future<List<Getcountry>> getcountry() async {
    List<Getcountry> _countrylist = [];
    Response response = await _dio.get(getcountryUrl);
    var body = (response.data);
    try {
      if (response.statusCode == 200) {
     
          for (var item in body) {
          Getcountry data = new Getcountry.fromJson(item);
          _countrylist.add(data);
        }
        return _countrylist;
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      }
  }
  //Getcountry

  //citylist 
   Future<List<Getcity>> getcity(cname) async {
    List<Getcity> _countrylist = [];
    Response response = await _dio.get(getcityUrl);
    var body = (response.data);
    try {
      if (response.statusCode == 200) {
     
          for (var item in body) {
          Getcity data = new Getcity.fromJson(item);
          _countrylist.add(data);
        }
        return _countrylist;
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      }
  }
  //citylist

  }


  

  

