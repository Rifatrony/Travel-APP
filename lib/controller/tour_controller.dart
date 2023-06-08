import 'package:get/get.dart';
import 'package:travel_app/data/repository/tour_repository.dart';
import 'package:travel_app/model/tour.dart';
import 'package:travel_app/utils/custom_message.dart';

class TourController extends GetxController {
  final tourRepo = TourRepo();
  final tour = TourModel().obs;
  final loading = true.obs;
  final addLoading = false.obs;

  void setLoading(bool value) {
    loading.value = value;
  }

  void setData(TourModel value) {
    tour.value = value;
  }

  @override
  void onInit() {
    super.onInit();
    getMyALlTour();
  }

  Future<void> getMyALlTour() async {
    await tourRepo.getMyAllTour().then((value) {
      setData(value);
      setLoading(false);
      update();
    }).onError((error, stackTrace) {
      setLoading(false);
    });
  }

  Future<void> addNewTour(dynamic data) async {
    addLoading.value = true;
    try {
      tourRepo.addNewTour(data).then((value) {
        if (value['code'] == 200) {
          Get.snackbar("Tour Created", "Successfully Created a new tour");
          addLoading.value = false;
        }

        if (value['code'] == 500) {
          Get.snackbar("Error occure with status code 500", value['message']);
          addLoading.value = false;
        }
      });
    } catch (e) {
      Get.snackbar("Got Exception", e.toString());
      addLoading.value = false;
    }
  }

  Future<bool> saveTour(String id, String name) async {
    return tourRepo.saveTour(id, name);
  }

  Future<bool> removeTourFromSP() async {
    tourRepo.removeTourFromSP();
    return true;
  }

  Future<void> deleteTour(String url, String id) async {
    tourRepo.deleteTour(url).then((value) {
      if (value['code'] == 200) {
        Get.snackbar(
          "Deleted",
          "Tour Deleted successfully",
        );
        removeTour(id);
      }
      if (value['code'] == 404) {
        Message.snackBar(value['message'], title: "Can't delete. Status code + ${value['code']}");
      }
    }).onError((error, stackTrace) {
        Message.snackBar(error.toString(), title: "Can't delete");
    });
  }

  void removeTour(String id) {
    tour.update((model) {
      final index = model?.tour?.indexWhere((tour) => tour.id == id);
      if (index != null && index >= 0) {
        model?.tour?.removeAt(index);
      }
    });

    update();
    
  }

  
}
