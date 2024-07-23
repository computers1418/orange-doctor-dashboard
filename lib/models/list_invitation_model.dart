// To parse this JSON data, do
//
//     final listInvitationModel = listInvitationModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ListInvitationModel listInvitationModelFromJson(String str) => ListInvitationModel.fromJson(json.decode(str));

String listInvitationModelToJson(ListInvitationModel data) => json.encode(data.toJson());

// class ListInvitationModel {
//   final List<Datum> data;
//   final int status;
//   final String type;
//   final String message;
//
//   ListInvitationModel({
//     required this.data,
//     required this.status,
//     required this.type,
//     required this.message,
//   });
//
//   factory ListInvitationModel.fromJson(Map<String, dynamic> json) => ListInvitationModel(
//     data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
//     status: json["status"],
//     type: json["type"],
//     message: json["message"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "data": List<dynamic>.from(data.map((x) => x.toJson())),
//     "status": status,
//     "type": type,
//     "message": message,
//   };
// }

class ListInvitationModel {
  final String type;
  final bool isDeleted;
  final int sendCount;
  final String id;
  final String onboardingCode;
  final String invitationUrl;
  final String expressCode;
  final String email;
  final String phone;
  final String name;
  final String specialization;
  final String brand;
  final String brandId;
  final String specializationId;
  final String city;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;
  final String datumId;
  final String otp;

  ListInvitationModel({
    required this.type,
    required this.isDeleted,
    required this.sendCount,
    required this.id,
    required this.onboardingCode,
    required this.invitationUrl,
    required this.expressCode,
    required this.email,
    required this.phone,
    required this.name,
    required this.specialization,
    required this.brand,
    required this.brandId,
    required this.specializationId,
    required this.city,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.datumId,
    required this.otp,
  });

  factory ListInvitationModel.fromJson(Map<String, dynamic> json) => ListInvitationModel(
    type: json["type"] ?? "",
    isDeleted: json["isDeleted"] ?? "",
    sendCount: json["sendCount"] ?? "",
    id: json["_id"] ?? "",
    onboardingCode: json["onboardingCode"] ?? "",
    invitationUrl: json["invitationUrl"] ?? "",
    expressCode: json["expressCode"] ?? "",
    email: json["email"] ?? "",
    phone: json["phone"] ?? "",
    name: json["name"] ?? "",
    specialization: json["specialization"] ?? "",
    brand: json["brand"] ?? "",
    brandId: json["brandId"] ?? "",
    specializationId: json["specializationId"] ?? "",
    city: json["city"] ?? "",
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"] ?? "",
    datumId: json["id"] ?? "",
    otp: json["otp"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "isDeleted": isDeleted,
    "sendCount": sendCount,
    "_id": id,
    "onboardingCode": onboardingCode,
    "invitationUrl": invitationUrl,
    "expressCode": expressCode,
    "email": email,
    "phone": phone,
    "name": name,
    "specialization": specialization,
    "brand": brand,
    "brandId": brandId,
    "specializationId": specializationId,
    "city": city,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "__v": v,
    "id": datumId,
    "otp": otp,
  };
}
//
// enum City {
//   MADURAI,
//   SURAT
// }
//
// final cityValues = EnumValues({
//   "Madurai": City.MADURAI,
//   "Surat": City.SURAT
// });
//
// enum Type {
//   DOCTOR
// }
//
// final typeValues = EnumValues({
//   "DOCTOR": Type.DOCTOR
// });
//
// class EnumValues<T> {
//   Map<String, T> map;
//   late Map<T, String> reverseMap;
//
//   EnumValues(this.map);
//
//   Map<T, String> get reverse {
//     reverseMap = map.map((k, v) => MapEntry(v, k));
//     return reverseMap;
//   }
// }
