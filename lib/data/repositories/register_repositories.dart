import 'package:borderlessWorking/data/api/apiServices.dart';
import 'package:borderlessWorking/data/model/register.dart';

class RegisterRepository {
  final ApiService _apiService = ApiService();

  Future<Map<String,dynamic>> register(
    String jobseeker_name, 
    String jobseeker_furigana_name,
    String dob,
    String country_name,
    String phone, 
    String email, 
    String password) =>
      _apiService.register(
        jobseeker_name, 
        jobseeker_furigana_name,
        dob,
        country_name,
        phone, 
        email,
        password);
}

class NetworkError extends Error {}
