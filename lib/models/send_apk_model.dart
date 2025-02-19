// To parse this JSON data, do
//
//     final sendApkModel = sendApkModelFromJson(jsonString);

import 'dart:convert';

SendApkModel sendApkModelFromJson(String str) =>
    SendApkModel.fromJson(json.decode(str));

String sendApkModelToJson(SendApkModel data) => json.encode(data.toJson());

class SendApkModel {
  String type;
  bool fromApk;
  bool isDeleted;
  int sendCount;
  int sendApkCount;
  bool isValid;
  String id;
  String invitationUrl;
  String name;
  String? email;
  String specialization;
  String specializationId;
  String brandId;
  String brand;
  String city;
  String? phone;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  String sendApkModelId;

  SendApkModel({
    required this.type,
    required this.fromApk,
    required this.isDeleted,
    required this.sendCount,
    required this.sendApkCount,
    required this.isValid,
    required this.id,
    required this.invitationUrl,
    required this.name,
    required this.email,
    required this.specialization,
    required this.specializationId,
    required this.brandId,
    required this.brand,
    required this.city,
    required this.phone,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.sendApkModelId,
  });

  factory SendApkModel.fromJson(Map<String, dynamic> json) => SendApkModel(
        type: json["type"],
        fromApk: json["fromApk"],
        isDeleted: json["isDeleted"],
        sendCount: json["sendCount"],
        sendApkCount: json["sendApkCount"],
        isValid: json["isValid"],
        id: json["_id"],
        invitationUrl: json["invitationUrl"] ?? "",
        name: json["name"] ?? "",
        email: json["email"] ?? "",
        specialization: json["specialization"] ?? "",
        specializationId: json["specializationId"] ?? "",
        brandId: json["brandId"] ?? "",
        brand: json["brand"] ?? "",
        city: json["city"] ?? "",
        phone: json["phone"] ?? "",
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        sendApkModelId: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "fromApk": fromApk,
        "isDeleted": isDeleted,
        "sendCount": sendCount,
        "sendApkCount": sendApkCount,
        "isValid": isValid,
        "_id": id,
        "invitationUrl": invitationUrl,
        "name": name,
        "email": email ?? "",
        "specialization": specialization,
        "specializationId": specializationId,
        "brandId": brandId,
        "brand": brand,
        "city": city,
        "phone": phone,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "id": sendApkModelId,
      };
}
