import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_app/data/repository/auth_repo.dart';
import 'package:travel_app/screen/login_screen.dart';
import 'package:travel_app/screen/tour_screen.dart';

class AuthController extends GetxController implements GetxService {
  final isLoaded = false.obs;
  final isRegLoaded = false.obs;
  final authRepo = AuthRepo();

  Future<void> login(dynamic data) async {
    isLoaded.value = true;
    authRepo.login(data).then((value) {
      if (value['message'] == "Login Successful") {
        Get.snackbar("Login Successful", "Welcome back");
        Get.to(const TourScreen());
        authRepo.saveUser(value['access_token']);
        isLoaded.value = false;
      } else if (value['code'] == 404) {
        Get.snackbar(value['code'], "User not found");
        isLoaded.value = false;
      } else {
        Get.snackbar(value['code'], value['message']);
        isLoaded.value = false;
      }
    });
  }

  Future<void> registration(dynamic data) async {
    isRegLoaded.value = true;
    authRepo.registration(data).then((value) {
      if (value['code'] == 200) {
        if (value['success'] == true) {
          Get.snackbar(
              "Registration Successful", "Thanks for creating new account");
          Get.to(const LoginScreen());
          // authRepo.saveUser(value['access_token']);
          isRegLoaded.value = false;
        } else {
          Get.snackbar("Error", "This phone is already used");
          isRegLoaded.value = false;
        }
      } else {
        Get.snackbar(value['code'], value['message']);
        isRegLoaded.value = false;
      }
    });
  }

  removeUser() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.clear();
    return true;
  }

  getAccessToken() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String? accessToken = sp.getString("access_token");
    return accessToken;
  }
}
