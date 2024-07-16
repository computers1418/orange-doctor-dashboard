class InvitationModel {
  String? id;
  BrandId? brandId;
  SpecializationId? specializationId;
  String? createdAt;
  String? link;
  String? updatedAt;

  InvitationModel({
    this.id,
    this.brandId,
    this.specializationId,
    this.createdAt,
    this.link,
    this.updatedAt,
  });

  factory InvitationModel.fromJson(Map<String, dynamic> json) {
    return InvitationModel(
      id: json['_id'],
      brandId:
          json['brandId'] == null ? null : BrandId.fromJson(json['brandId']),
      specializationId: json['specializationId'] == null
          ? null
          : SpecializationId.fromJson(json['specializationId']),
      createdAt: json['createdAt'],
      link: json['link'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'brandId': brandId!.toJson(),
      'specializationId': specializationId!.toJson(),
      'createdAt': createdAt,
      'link': link,
      'updatedAt': updatedAt,
    };
  }
}

class BrandId {
  String? id;
  String? name;

  BrandId({
    this.id,
    this.name,
  });

  factory BrandId.fromJson(Map<String, dynamic> json) {
    return BrandId(
      id: json['_id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
    };
  }
}

class SpecializationId {
  String? id;
  String? name;

  SpecializationId({
    this.id,
    this.name,
  });

  factory SpecializationId.fromJson(Map<String, dynamic> json) {
    return SpecializationId(
      id: json['_id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
    };
  }
}
