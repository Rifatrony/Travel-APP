import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_app/data/repository/auth_repo.dart';
import 'package:travel_app/screen/login_screen.dart';
import 'package:travel_app/screen/tour_screen.dart';

class AuthController extends GetxController implements GetxService {
  RxBool isLoading = false.obs;
  final isRegLoaded = false.obs;
  RxBool isPasswordHidden = true.obs;
  final authRepo = AuthRepo();

  var phoneController = TextEditingController();
  var passwordController = TextEditingController();

  Future<void> login() async {
    if (phoneController.text.toString().isEmpty) {
      Get.snackbar("Warning", "Phone is required");
    } else if (passwordController.text.toString().isEmpty) {
      Get.snackbar("Warning", "Password is required");
    } else if (passwordController.text.toString().length < 6) {
      Get.snackbar("Warning", "Minimum Password is 6");
    } else {
      try {
        isLoading(true);
        Map data = {
          "phone": phoneController.text.toString().trim(),
          "password": passwordController.text.toString().trim(),
        };
        authRepo.login(data).then((value) {
          if (value['message'] == "Authentication Failed: Incorrect Phone number") {
            Get.snackbar("Success", "Authentication Failed: Incorrect Phone number");
            isLoading.value = false;
            update();
          }

          else if (value['message'] == "Authentication Failed: Incorrect password.") {
            Get.snackbar("Success", "Authentication Failed: Incorrect password.");
            isLoading.value = false;
            update();
          }
          else if (value['message'] == "Login Successful") {
            // Get.offAllNamed(RouteName.CUSTOMER_DASHBOARD_SCREEN);
            isLoading(false);
            isLoading.value = true;
            Get.snackbar("Success", "Login Successful");
            Get.offAll(const TourScreen());
            authRepo.saveUser(value['access_token']);
            update();

          } 
          else {
            // Login error
            isLoading.value = false;
            update();
          }
        });
      } catch (e) {
        // print e
        isLoading(false);
        update();
        print("Catch error ==============> $e");
      }
    }

    // isLoaded.value = true;
    // authRepo.login(data).then((value) {
    //   if (value['message'] == "Authentication Failed: Incorrect password.") {
    //     Get.snackbar(
    //         value['Warning'], "Authentication Failed: Incorrect password.");
    //     isLoaded.value = false;
    //   } else if (value['message'] == "Phone not found") {
    //     Get.snackbar(value['Warning'], "Phone not found");
    //     isLoaded.value = false;
    //   } else if (value['message'] == "Login Successful") {
    //     Get.snackbar("Successful", "Login Successful");
    //     Get.to(const TourScreen());
    //     authRepo.saveUser(value['access_token']);
    //     isLoaded.value = false;
    //   } else if (value['code'] == 404) {
    //     Get.snackbar(value['code'], "User not found");
    //     isLoaded.value = false;
    //   } else {
    //     Get.snackbar(value['code'], value['message']);
    //     isLoaded.value = false;
    //   }
    // });
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
          update();
        } else {
          Get.snackbar("Error", "This phone is already used");
          isRegLoaded.value = false;
          update();
        }
      } else {
        Get.snackbar(value['code'], value['message']);
        isRegLoaded.value = false;
        update();
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
