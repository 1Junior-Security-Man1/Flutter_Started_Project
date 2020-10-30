class UserTaskPayload {
  String socialNetworkType;
  String link;
  String description;
  String productName;

  UserTaskPayload.fromJson(dynamic json) {
    socialNetworkType = json["socialNetworkType"];
    link = json["link"];
    description = json["description"];
    productName = json["productName"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["socialNetworkType"] = socialNetworkType;
    map["link"] = link;
    map["description"] = description;
    map["productName"] = productName;
    return map;
  }
}