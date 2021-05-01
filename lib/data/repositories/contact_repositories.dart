import 'package:borderlessWorking/data/api/apiServices.dart';
import 'package:borderlessWorking/data/api/apis.dart';
import 'package:borderlessWorking/data/model/contact.dart';
import 'package:dio/dio.dart';

class ContactRepository {
  final ApiService _apiService = ApiService();

  Future<List<ContactModel>> getContactList() => _apiService.getContactLists();
}

class NetworkError extends Error {}
