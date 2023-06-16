import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_app/data/api/network_api_services.dart';
import 'package:travel_app/utils/app_constants.dart';

class AuthRepo{
  
  final apiServices = NetworkApiServices();

  Future<dynamic> login(dynamic data) async {
    dynamic response = await apiServices.loginApi(data, AppConstants.loginUrl);
    return response;
  }

  Future<dynamic> registration(dynamic data) async {
    dynamic response = await apiServices.loginApi(data, AppConstants.registrationUrl);
    return response;
  }

  Future<bool> saveUser(String token) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString("access_token", token);
    return true;
  }

  Future<String?> getAccessToken() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String? accessToken = sp.getString("access_token");
    return accessToken;
  }

  Future<bool> removeUser() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.clear();
    return true;
  }

}