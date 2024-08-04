// To parse this JSON data, do
//
//     final listInvitationModel = listInvitationModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ListInvitationModel listInvitationModelFromJson(String str) =>
    ListInvitationModel.fromJson(json.decode(str));

String listInvitationModelToJson(ListInvitationModel data) =>
    json.encode(data.toJson());


// class ListInvitationModel {
//   final String type;
//   final bool isDeleted;
//   final int sendCount;
//   final String id;
//   final String onboardingCode;
//   final String invitationUrl;
//   final String expressCode;
//   final String email;
//   final String phone;
//   final String name;
//   final String specialization;
//   final String brand;
//   final String brandId;
//   final String specializationId;
//   final String city;
//   final DateTime createdAt;
//   final DateTime updatedAt;
//   final int v;
//   final String datumId;
//   final String otp;
//
//   ListInvitationModel({
//     required this.type,
//     required this.isDeleted,
//     required this.sendCount,
//     required this.id,
//     required this.onboardingCode,
//     required this.invitationUrl,
//     required this.expressCode,
//     required this.email,
//     required this.phone,
//     required this.name,
//     required this.specialization,
//     required this.brand,
//     required this.brandId,
//     required this.specializationId,
//     required this.city,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.v,
//     required this.datumId,
//     required this.otp,
//   });
//
//   factory ListInvitationModel.fromJson(Map<String, dynamic> json) {
//     String? dateString = json["createdAt"] as String?;
//     String? updateDateString = json["updatedAt"] as String?;
//
//     // Try parsing the date string
//     DateTime date;
//     try {
//       // Parse the date only if it's not null or empty
//       if (dateString != null && dateString.isNotEmpty) {
//         date = DateTime.parse(dateString);
//       } else {
//         // Provide a default date if parsing fails or the string is empty
//         date = DateTime.now(); // Or a specific default date
//       }
//     } catch (e) {
//       // Handle parsing errors
//       date = DateTime.now(); // Or a specific default date
//     }
//
//     DateTime updateDate;
//     try {
//       // Parse the date only if it's not null or empty
//       if (updateDateString != null && updateDateString.isNotEmpty) {
//         updateDate = DateTime.parse(updateDateString);
//       } else {
//         // Provide a default date if parsing fails or the string is empty
//         updateDate = DateTime.now(); // Or a specific default date
//       }
//     } catch (e) {
//       // Handle parsing errors
//       updateDate = DateTime.now(); // Or a specific default date
//     }
//
//     return ListInvitationModel(
//       type: json["type"] ?? "",
//       isDeleted: json["isDeleted"] ?? false,
//       sendCount: json["sendCount"] ?? 0,
//       id: json["_id"] ?? "",
//       onboardingCode: json["onboardingCode"] ?? "",
//       invitationUrl: json["invitationUrl"] ?? "",
//       expressCode: json["expressCode"] ?? "",
//       email: json["email"] ?? "",
//       phone: json["phone"] ?? "",
//       name: json["name"] ?? "",
//       specialization: json["specialization"] ?? "",
//       brand: json["brand"] ?? "",
//       brandId: json["brandId"] ?? "",
//       specializationId: json["specializationId"] ?? "",
//       city: json["city"] ?? "",
//       createdAt: date,
//       updatedAt: updateDate,
//       v: json["__v"] ?? 0,
//       datumId: json["id"] ?? "",
//       otp: json["otp"] ?? "",
//     );
//   }
//
//   Map<String, dynamic> toJson() => {
//         "type": type,
//         "isDeleted": isDeleted,
//         "sendCount": sendCount,
//         "_id": id,
//         "onboardingCode": onboardingCode,
//         "invitationUrl": invitationUrl,
//         "expressCode": expressCode,
//         "email": email,
//         "phone": phone,
//         "name": name,
//         "specialization": specialization,
//         "brand": brand,
//         "brandId": brandId,
//         "specializationId": specializationId,
//         "city": city,
//         "createdAt": createdAt.toIso8601String(),
//         "updatedAt": updatedAt.toIso8601String(),
//         "__v": v,
//         "id": datumId,
//         "otp": otp,
//       };
// }

class ListInvitationModel {
  String id;
  String brandName;
  dynamic specializationName;
  String doctorName;
  String email;
  String phone;
  String city;
  DateTime timeSent;
  DateTime timeUpdated;

  ListInvitationModel({
    required this.id,
    required this.brandName,
    required this.specializationName,
    required this.doctorName,
    required this.email,
    required this.phone,
    required this.city,
    required this.timeSent,
    required this.timeUpdated,
  });

  factory ListInvitationModel.fromJson(Map<String, dynamic> json) => ListInvitationModel(
    id: json["id"],
    brandName: json["brandName"] ?? "",
    specializationName: json["specializationName"] ?? "",
    doctorName: json["doctorName"] ?? "",
    email: json["email"] ?? "",
    phone: json["phone"] ?? "",
    city: json["city"] ?? "",
    timeSent: DateTime.parse(json["timeSent"]),
    timeUpdated: DateTime.parse(json["timeUpdated"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "brandName": brandName,
    "specializationName": specializationName,
    "doctorName": doctorName,
    "email": email,
    "phone": phone,
    "city": city,
    "timeSent": timeSent.toIso8601String(),
    "timeUpdated": timeUpdated.toIso8601String(),
  };
}