class ResendInvitationModel {
  final String type;
  final bool fromApk;
  final bool isDeleted;
  final int sendCount;
  final int sendApkCount;
  final bool isValid;
  final String id;
  final String onboardingCode;
  final String invitationUrl;
  final String expressCode;
  final String specialization;
  final String brand;
  final String name;
  final String brandId;
  final String specializationId;
  // final DateTime onboardingCodeExpiration;
  // final DateTime expressCodeExpiration;
  final String city;
  final String email;
  final String phone;
  final DateTime createdAt;
  final DateTime updatedAt;

  ResendInvitationModel({
    required this.type,
    required this.fromApk,
    required this.isDeleted,
    required this.sendCount,
    required this.sendApkCount,
    required this.isValid,
    required this.id,
    required this.onboardingCode,
    required this.invitationUrl,
    required this.expressCode,
    required this.specialization,
    required this.brand,
    required this.name,
    required this.brandId,
    required this.specializationId,
    // required this.onboardingCodeExpiration,
    // required this.expressCodeExpiration,
    required this.city,
    required this.email,
    required this.phone,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ResendInvitationModel.fromJson(Map<String, dynamic> json) {
    return ResendInvitationModel(
      type: json["type"],
      fromApk: json["fromApk"],
      isDeleted: json["isDeleted"],
      sendCount: json["sendCount"],
      sendApkCount: json["sendApkCount"],
      isValid: json["isValid"],
      id: json["_id"],
      onboardingCode: json["onboardingCode"],
      invitationUrl: json["invitationUrl"],
      expressCode: json["expressCode"],
      specialization: json["specialization"],
      brand: json["brand"],
      name: json["name"],
      brandId: json["brandId"],
      specializationId: json["specializationId"],
      // onboardingCodeExpiration:
      //     DateTime.parse(json["onboardingCodeExpiration"]),
      // expressCodeExpiration: DateTime.parse(json["expressCodeExpiration"]),
      city: json["city"],
      email: json["email"],
      phone: json["phone"],
      createdAt: DateTime.parse(json["createdAt"]),
      updatedAt: DateTime.parse(json["updatedAt"]),
    );
  }
}
