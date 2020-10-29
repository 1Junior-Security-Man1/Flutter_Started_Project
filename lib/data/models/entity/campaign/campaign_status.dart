class CampaignStatus {
  String id;
  String campaignStatusType;
  String comment;

  CampaignStatus.fromJson(dynamic json) {
    id = json["id"];
    campaignStatusType = json["campaignStatusType"];
    comment = json["comment"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["campaignStatusType"] = campaignStatusType;
    map["comment"] = comment;
    return map;
  }
}