import 'package:travel_app/data/api/network_api_services.dart';
import 'package:travel_app/model/user.dart';
import 'package:travel_app/utils/app_constants.dart';

class UserRepo{
  final apiServices = NetworkApiServices();
  Future<UserModel> getUser() async {
    dynamic response = await apiServices.getApi(AppConstants.profileUrl);
    return UserModel.fromJson(response);
  }
}