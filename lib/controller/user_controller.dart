import 'package:get/get.dart';
import 'package:travel_app/data/repository/user_repo.dart';
import 'package:travel_app/model/user.dart';

class UserController extends GetxController{
  final userRepo = UserRepo();
  final user = UserModel().obs;
  final loading = false.obs;

  void setLoading(bool value){
    loading.value = value;
  }

  void setData(UserModel value){
    user.value = value;
  }

  @override
  void onInit() {
    super.onInit();
    getUser();
  }

  Future<void> getUser() async {
    setLoading(true);
    try {
      userRepo.getUser().then((value) {
      setData(value);
      setLoading(false);
    });
    } catch (e) {
      setLoading(false);
      Get.snackbar("Error", e.toString());
    }
  }
}