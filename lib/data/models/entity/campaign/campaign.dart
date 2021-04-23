import 'package:flutter_starter/data/models/entity/campaign/campaign_period.dart';
import 'package:flutter_starter/data/models/entity/campaign/campaign_socials.dart';

class Campaign {
  String id;
  String name;
  String directoryName;
  String ownerId;
  String campaignType;
  bool customReward;
  CampaignPeriod campaignPeriod;
  String referralCode;
  double referralReward;
  double masterReward;
  String coverId;
  String description;
  String website;
  int position;
  int countSubscribers;
  int countItems;
  int countVoucherItems;
  List<CampaignSocials> socials;
  String campaignStatus;

  Campaign.fromJson(dynamic json) {
    id = json["id"];
    name = json["name"];
    directoryName = json["directoryName"];
    ownerId = json["ownerId"];
    campaignType = json["campaignType"];
    customReward = json["customReward"];
    referralCode = json["referralCode"];
    referralReward = json["referralReward"];
    masterReward = json["masterReward"];
    coverId = json["coverId"];
    description = json["description"];
    website = json["website"];
    position = json["position"];
    countSubscribers = json["countSubscribers"];
    countItems = json["countItems"];
    countVoucherItems = json["countVoucherItems"];
    campaignStatus = json["campaignStatus"];

    campaignPeriod = json["campaignPeriod"] != null ? CampaignPeriod.fromJson(json["campaignPeriod"]) : null;
    if (json["socials"] != null) {
      socials = [];
      json["socials"].forEach((v) {
        socials.add(CampaignSocials.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["name"] = name;
    map["directoryName"] = directoryName;
    map["ownerId"] = ownerId;
    map["campaignType"] = campaignType;
    map["customReward"] = customReward;
    map["referralCode"] = referralCode;
    map["referralReward"] = referralReward;
    map["masterReward"] = masterReward;
    map["coverId"] = coverId;
    map["description"] = description;
    map["website"] = website;
    map["position"] = position;
    map["campaignStatus"] = campaignStatus;

    if (campaignPeriod != null) {
      map["campaignPeriod"] = campaignPeriod.toJson();
    }
    if (socials != null) {
      map["socials"] = socials.map((v) => v.toJson()).toList();
    }
    return map;
  }
}