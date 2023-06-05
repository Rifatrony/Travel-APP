// To parse this JSON data, do
//
//     final costModel = costModelFromJson(jsonString);

import 'dart:convert';

CostModel costModelFromJson(String str) => CostModel.fromJson(json.decode(str));

String costModelToJson(CostModel data) => json.encode(data.toJson());

class CostModel {
    int? code;
    bool? success;
    String? message;
    List<Cost>? cost;

    CostModel({
        this.code,
        this.success,
        this.message,
        this.cost,
    });

    factory CostModel.fromJson(Map<String, dynamic> json) => CostModel(
        code: json["code"],
        success: json["success"],
        message: json["message"],
        cost: json["cost"] == null ? [] : List<Cost>.from(json["cost"]!.map((x) => Cost.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "success": success,
        "message": message,
        "cost": cost == null ? [] : List<dynamic>.from(cost!.map((x) => x.toJson())),
    };
}

class Cost {
    String? id;
    String? reason;
    int? amount;
    String? date;
    String? tourId;
    String? addedBy;

    Cost({
        this.id,
        this.reason,
        this.amount,
        this.date,
        this.tourId,
        this.addedBy,
    });

    factory Cost.fromJson(Map<String, dynamic> json) => Cost(
        id: json["id"],
        reason: json["reason"],
        amount: json["amount"],
        date: json["date"],
        tourId: json["tour_id"],
        addedBy: json["added_by"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "reason": reason,
        "amount": amount,
        "date": date,
        "tour_id": tourId,
        "added_by": addedBy,
    };
}
