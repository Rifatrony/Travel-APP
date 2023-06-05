
import 'dart:convert';

LoginResponseModel loginResponseModelFromJson(String str) => LoginResponseModel.fromJson(json.decode(str));

String loginResponseModelToJson(LoginResponseModel data) => json.encode(data.toJson());

class LoginResponseModel {
    String? accessToken;
    String? message;

    LoginResponseModel({
        this.accessToken,
        this.message,
    });

    factory LoginResponseModel.fromJson(Map<String, dynamic> json) => LoginResponseModel(
        accessToken: json["access_token"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "access_token": accessToken,
        "message": message,
    };
}
