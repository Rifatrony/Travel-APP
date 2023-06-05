class AppConstants{
  static const String baseUrl = 'http://192.168.0.198:5050/api';
  static const String loginUrl = '$baseUrl/auth/login';
  static const String registrationUrl = '$baseUrl/auth/registration';
  static const String profileUrl = '$baseUrl/auth/profile';

  static const String memberUrl = '$baseUrl/member/all';
  static const String addMemberUrl = '$baseUrl/member/add';
  static const String deleteMemberUrl = '$baseUrl/member/delete';
  static const String addMoneyUrl = '$baseUrl/member/add-money';
  static const String withdrawMoneyUrl = '$baseUrl/member/withdraw-money';
  
  static const String tourUrl = '$baseUrl/tour/all';
  static const String costUrl = '$baseUrl/cost/all';
  static const String addCostUrl = '$baseUrl/cost/add';

}