import 'package:get/get.dart';
import 'package:travel_app/data/repository/auth_repo.dart';
import 'package:travel_app/screen/tour_screen.dart';

class  AuthController extends GetxController implements GetxService{
  final isLoaded = false.obs;
  final authRepo = AuthRepo();

  Future<void> login(dynamic data) async {
    isLoaded.value = true;
    authRepo.login(data).then((value) {
      
      if(value['message'] == "Login Successful"){
        Get.snackbar("Login Successful", "Welcome back");
        Get.to(const TourScreen());
        authRepo.saveUser(value['access_token']);
        isLoaded.value = false;
      }
      
      else if(value['code'] == 404){
        Get.snackbar(value['code'], "User not found");
        isLoaded.value = false;
      }

      else {
        Get.snackbar(value['code'], value['message']);
        isLoaded.value = false;
      }
    });
  }
  
}