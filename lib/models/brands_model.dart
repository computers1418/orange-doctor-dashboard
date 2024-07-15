class BrandsModel {
  String id;
  String name;
  String createdAt;
  String updatedAt;

  BrandsModel({
    required this.id,
    required this.name,
    this.createdAt = "",
    this.updatedAt = "",
  });

  factory BrandsModel.fromJson(Map<String, dynamic> json) {
    return BrandsModel(
      id: json['_id'],
      name: json['name'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
