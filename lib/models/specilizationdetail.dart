class SpecializationDetails {
  String? sId;
  String? name;
  List<Icons>? icons;
  String? createdAt;
  String? updatedAt;

  SpecializationDetails(
      {this.sId, this.name, this.icons, this.createdAt, this.updatedAt});

  SpecializationDetails.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    if (json['icons'] != null) {
      icons = <Icons>[];
      json['icons'].forEach((v) {
        icons!.add(new Icons.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    if (this.icons != null) {
      data['icons'] = this.icons!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class Icons {
  String? sId;
  String? path;
  String? url;

  Icons({this.sId, this.path, this.url});

  Icons.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    path = json['path'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['path'] = this.path;
    data['url'] = this.url;
    return data;
  }
}