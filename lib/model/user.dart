// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
    int? code;
    bool? success;
    String? message;
    User? user;

    UserModel({
        this.code,
        this.success,
        this.message,
        this.user,
    });

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        code: json["code"],
        success: json["success"],
        message: json["message"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "success": success,
        "message": message,
        "user": user?.toJson(),
    };
}

class User {
    String? id;
    String? name;
    int? phone;
    String? role;

    User({
        this.id,
        this.name,
        this.phone,
        this.role,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        phone: json["phone"],
        role: json["role"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "phone": phone,
        "role": role,
    };
}
