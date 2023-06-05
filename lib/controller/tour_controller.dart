import 'package:get/get.dart';
import 'package:travel_app/data/repository/tour_repository.dart';
import 'package:travel_app/model/tour.dart';

class TourController extends GetxController{
  final tourRepo = TourRepo();
  final tour = TourModel().obs;
  final loading = true.obs;

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

  Future<bool> saveTour(String id, String name) async {
    return tourRepo.saveTour(id, name);
  }

  Future<bool> removeTour() async {
    return tourRepo.removeTour();
  }

  
}
