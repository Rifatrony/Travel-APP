import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_app/data/api/network_api_services.dart';
import 'package:travel_app/model/tour.dart';
import 'package:travel_app/utils/app_constants.dart';

class TourRepo {
  final apiServices = NetworkApiServices();

  Future<TourModel> getMyAllTour() async {
    dynamic response = await apiServices.getApi(AppConstants.tourUrl);
    return TourModel.fromJson(response);
  }

  Future<dynamic> addNewTour(dynamic data) async {
    dynamic response = await apiServices.postApi(data, AppConstants.addTourUrl);
    return response;
  }

  Future<bool> saveTour(String id, String name) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString("id", id);
    sp.setString("tourName", name);
    return true;
  }

  Future<bool> removeTourFromSP() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.remove("id");
    sp.remove("tourName");
    return true;
  }

  Future<dynamic> deleteTour(String url) async {
    dynamic response = await apiServices.deleteApi(url);
    return response;
  }
}