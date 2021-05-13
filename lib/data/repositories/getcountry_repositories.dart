import 'package:borderlessWorking/data/api/apiServices.dart';
import 'package:borderlessWorking/data/api/apis.dart';
import 'package:borderlessWorking/data/model/getcity.dart';
import 'package:borderlessWorking/data/model/getcountry.dart';
import 'package:borderlessWorking/screens/countr2.dart';
import 'package:dio/dio.dart';

class GetcountryRepository {
  String idProvince;
  final ApiService _apiService = ApiService();
  Future<List<Getcountry>> getcountry() => _apiService.getcountry();
  Future<List<Getcity>> getcity(idProvince) => _apiService.getcity(idProvince);
  Future<List<Getcity>> getallcity() => _apiService.getcity(idProvince);
}

class NetworkError extends Error {}
