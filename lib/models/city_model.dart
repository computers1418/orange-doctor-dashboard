class CityModel {
  String id;
  String name;
  String brandId;
  String specializationId;
  bool isActive;
  String createdAt;
  String updatedAt;

  CityModel({
    required this.id,
    required this.name,
    required this.brandId,
    required this.specializationId,
    this.isActive = false,
    this.createdAt = "",
    this.updatedAt = "",
  });

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
      id: json['_id'],
      name: json['name'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      brandId: json['brandId'],
      specializationId: json['specializationId'],
      isActive: json['isActive'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'brandId': brandId,
      'specializationId': specializationId,
      'isActive': isActive,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
