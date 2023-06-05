// To parse this JSON data, do
//
//     final tourModel = tourModelFromJson(jsonString);

import 'dart:convert';

TourModel tourModelFromJson(String str) => TourModel.fromJson(json.decode(str));

String tourModelToJson(TourModel data) => json.encode(data.toJson());

class TourModel {
    int? code;
    bool? success;
    String? message;
    List<Tour>? tour;

    TourModel({
        this.code,
        this.success,
        this.message,
        this.tour,
    });

    factory TourModel.fromJson(Map<String, dynamic> json) => TourModel(
        code: json["code"],
        success: json["success"],
        message: json["message"],
        tour: json["tour"] == null ? [] : List<Tour>.from(json["tour"]!.map((x) => Tour.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "success": success,
        "message": message,
        "tour": tour == null ? [] : List<dynamic>.from(tour!.map((x) => x.toJson())),
    };
}

class Tour {
    String? id;
    String? name;
    String? addedBy;
    String? startDate;
    String? endDate;

    Tour({
        this.id,
        this.name,
        this.addedBy,
        this.startDate,
        this.endDate,
    });

    factory Tour.fromJson(Map<String, dynamic> json) => Tour(
        id: json["id"],
        name: json["name"],
        addedBy: json["added_by"],
        startDate: json["start_date"],
        endDate: json["end_date"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "added_by": addedBy,
        "start_date": startDate,
        "end_date": endDate,
    };
}
