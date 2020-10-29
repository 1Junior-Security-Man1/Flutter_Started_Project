class Category {
  String id;
  String name;
  String socialNetworkType;

  Category.fromJson(dynamic json) {
    id = json["id"];
    name = json["name"];
    socialNetworkType = json["socialNetworkType"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["name"] = name;
    map["socialNetworkType"] = socialNetworkType;
    return map;
  }
}