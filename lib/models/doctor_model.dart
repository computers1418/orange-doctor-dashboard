class DoctorModel {
  DoctorModel({
    required this.personalInfo,
    required this.expertiseField,
    required this.address,
    required this.createdAt,
    required this.isDeleted,
    required this.id,
    required this.cityId,
    required this.brandId,
    required this.specializationId,
    required this.availability,
    required this.problem,
    required this.test,
    required this.review,
    required this.guidelines,
    required this.updatedAt,
    required this.firstName,
    required this.lastName,
    required this.V,
  });

  late final PersonalInfo personalInfo;
  late final ExpertiseField expertiseField;
  late final Address address;
  late final DateTime createdAt;
  late final bool isDeleted;
  late final String id;
  late final String cityId;
  late final String brandId;
  late final String specializationId;
  late final List<dynamic> availability;
  late final List<dynamic> problem;
  late final List<dynamic> test;
  late final List<dynamic> review;
  late final List<dynamic> guidelines;
  late final DateTime updatedAt;
  late final String firstName;
  late final String lastName;
  late final int V;

  DoctorModel.fromJson(Map<String, dynamic> json) {
    personalInfo = PersonalInfo.fromJson(json['personalInfo']);
    expertiseField = ExpertiseField.fromJson(json['expertiseField']);
    address = Address.fromJson(json['address']);
    createdAt = DateTime.parse(json["createdAt"]);

    isDeleted = json['isDeleted'];
    id = json['_id'];
    cityId = json['cityId'] ?? "";
    brandId = json['brandId'] ?? "";
    specializationId = json['specializationId'] ?? "";
    availability = List.castFrom<dynamic, dynamic>(json['availability']);
    problem = List.castFrom<dynamic, dynamic>(json['problem']);
    test = List.castFrom<dynamic, dynamic>(json['test']);
    review = List.castFrom<dynamic, dynamic>(json['review']);
    guidelines = List.castFrom<dynamic, dynamic>(json['guidelines']);
    updatedAt = DateTime.parse(json["updatedAt"]);
    firstName = json['firstName'];
    lastName = json['lastName'];
    V = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['personalInfo'] = personalInfo.toJson();
    _data['expertiseField'] = expertiseField.toJson();
    _data['address'] = address.toJson();
    // _data['createdAt'] = createdAt;
    _data['createdAt'] = createdAt.toIso8601String();
    _data['isDeleted'] = isDeleted;
    _data['_id'] = id;
    _data['cityId'] = cityId;
    _data['brandId'] = brandId;
    _data['specializationId'] = specializationId;
    _data['availability'] = availability;
    _data['problem'] = problem;
    _data['test'] = test;
    _data['review'] = review;
    _data['guidelines'] = guidelines;
    // _data['updatedAt'] = updatedAt;
    _data['updatedAt'] = updatedAt.toIso8601String();
    _data['firstName'] = firstName;
    _data['lastName'] = lastName;
    _data['__v'] = V;
    return _data;
  }
}

class PersonalInfo {
  PersonalInfo({
    required this.name,
    required this.email,
    required this.phone,
  });

  late final String name;
  late final String email;
  late final String phone;

  PersonalInfo.fromJson(Map<String, dynamic> json) {
    name = json['name'] ?? "";
    email = json['email'] ?? "";
    phone = json['phone'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['email'] = email;
    _data['phone'] = phone;
    return _data;
  }
}

class ExpertiseField {
  ExpertiseField({
    required this.degree,
    required this.specialization,
    required this.bio,
    required this.educationBrief,
    required this.specializationBrief,
    required this.experienceBrief,
    required this.achievementBrief,
    required this.membershipBrief,
  });

  late final String degree;
  late final String specialization;
  late final String bio;
  late final String educationBrief;
  late final String specializationBrief;
  late final String experienceBrief;
  late final String achievementBrief;
  late final String membershipBrief;

  ExpertiseField.fromJson(Map<String, dynamic> json) {
    degree = json['degree'] ?? "";
    specialization = json['specialization'] ?? "";
    bio = json['bio'] ?? "";
    educationBrief = json['educationBrief'] ?? "";
    specializationBrief = json['specializationBrief'];
    experienceBrief = json['experienceBrief'] ?? "";
    achievementBrief = json['achievementBrief'] ?? "";
    membershipBrief = json['membershipBrief'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['degree'] = degree;
    _data['specialization'] = specialization;
    _data['bio'] = bio;
    _data['educationBrief'] = educationBrief;
    _data['specializationBrief'] = specializationBrief;
    _data['experienceBrief'] = experienceBrief;
    _data['achievementBrief'] = achievementBrief;
    _data['membershipBrief'] = membershipBrief;
    return _data;
  }
}

class Address {
  Address({
    required this.addressLine1,
    required this.addressLine2,
    required this.addressLine3,
    required this.city,
    required this.state,
    required this.country,
    this.zipCode,
    required this.identityProof,
  });

  late final String addressLine1;
  late final String addressLine2;
  late final String addressLine3;
  late final String city;
  late final String state;
  late final String country;
  late final Null zipCode;
  late final String identityProof;

  Address.fromJson(Map<String, dynamic> json) {
    addressLine1 = json['addressLine1'] ?? "";
    addressLine2 = json['addressLine2'] ?? "";
    addressLine3 = json['addressLine3'] ?? "";
    city = json['city'] ?? "";
    state = json['state'] ?? "";
    country = json['country'] ?? "";
    zipCode = null;
    identityProof = json['identityProof'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['addressLine1'] = addressLine1;
    _data['addressLine2'] = addressLine2;
    _data['addressLine3'] = addressLine3;
    _data['city'] = city;
    _data['state'] = state;
    _data['country'] = country;
    _data['zipCode'] = zipCode;
    _data['identityProof'] = identityProof;
    return _data;
  }
}
