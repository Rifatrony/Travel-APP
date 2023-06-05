import 'package:travel_app/data/api/network_api_services.dart';
import 'package:travel_app/model/member.dart';

class MemberRepo{
  final apiServices = NetworkApiServices();
  Future<MemberModel> getMember(String url) async {
    dynamic response = await apiServices.getApi(url);
    return MemberModel.fromJson(response);
  }

  Future<dynamic> addMember(dynamic data, String url) async {
    dynamic response = await apiServices.postApi(data, url);
    return response;
  }

  Future<dynamic> addMemberMoney(dynamic data, String url) async {
    dynamic response = await apiServices.putApi(data, url);
    return response;
  }

  Future<dynamic> withdrawMemberMoney(dynamic data, String url) async {
    dynamic response = await apiServices.putApi(data, url);
    return response;
  }

  Future<dynamic> deleteMember(String url) async {
    dynamic response = await apiServices.deleteApi(url);
    return response;
  }
}