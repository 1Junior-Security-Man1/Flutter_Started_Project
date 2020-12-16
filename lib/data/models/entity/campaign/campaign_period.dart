class CampaignPeriod {
  String id;
  int start;
  int end;

  CampaignPeriod.fromJson(dynamic json) {
    id = json["id"];
    start = json["start"];
    end = json["end"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["start"] = start;
    map["end"] = end;
    return map;
  }
}