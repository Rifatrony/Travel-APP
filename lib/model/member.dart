// To parse this JSON data, do
//
//     final memberModel = memberModelFromJson(jsonString);

import 'dart:convert';

MemberModel memberModelFromJson(String str) => MemberModel.fromJson(json.decode(str));

String memberModelToJson(MemberModel data) => json.encode(data.toJson());

class MemberModel {
    int? code;
    bool? success;
    String? message;
    List<Member>? members;

    MemberModel({
        this.code,
        this.success,
        this.message,
        this.members,
    });

    factory MemberModel.fromJson(Map<String, dynamic> json) => MemberModel(
        code: json["code"],
        success: json["success"],
        message: json["message"],
        members: json["members"] == null ? [] : List<Member>.from(json["members"]!.map((x) => Member.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "success": success,
        "message": message,
        "members": members == null ? [] : List<dynamic>.from(members!.map((x) => x.toJson())),
    };
}

class Member {
    AddedBy? addedBy;
    String? id;
    String? name;
    String? tourName;
    int? phone;
    int? givenAmount;

    Member({
        this.addedBy,
        this.id,
        this.name,
        this.tourName,
        this.phone,
        this.givenAmount,
    });

    factory Member.fromJson(Map<String, dynamic> json) => Member(
        addedBy: json["added_by"] == null ? null : AddedBy.fromJson(json["added_by"]),
        id: json["id"],
        name: json["name"],
        tourName: json["tour_name"],
        phone: json["phone"],
        givenAmount: json["given_amount"],
    );

    Map<String, dynamic> toJson() => {
        "added_by": addedBy?.toJson(),
        "id": id,
        "name": name,
        "tour_name": tourName,
        "phone": phone,
        "given_amount": givenAmount,
    };
}

class AddedBy {
    String? userId;
    String? userName;

    AddedBy({
        this.userId,
        this.userName,
    });

    factory AddedBy.fromJson(Map<String, dynamic> json) => AddedBy(
        userId: json["user_id"],
        userName: json["user_name"],
    );

    Map<String, dynamic> toJson() => {
        "user_id": userId,
        "user_name": userName,
    };
}
