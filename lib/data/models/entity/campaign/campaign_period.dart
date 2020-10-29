class CampaignPeriod {
  String id;
  int start;
  int end;
  dynamic timeZone;

  CampaignPeriod.fromJson(dynamic json) {
    id = json["id"];
    start = json["start"];
    end = json["end"];
    timeZone = json["timeZone"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["start"] = start;
    map["end"] = end;
    map["timeZone"] = timeZone;
    return map;
  }
}