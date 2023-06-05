import 'package:travel_app/data/api/network_api_services.dart';
import 'package:travel_app/model/cost.dart';

class CostRepo{
  final apiServices = NetworkApiServices();
  Future<CostModel> getCost(String url) async {
    dynamic response = await apiServices.getApi(url);
    return CostModel.fromJson(response);
  }

  Future<dynamic> addCost(dynamic data, String url) async {
    dynamic response = await apiServices.postApi(data, url);
    return response;
  }

  

}