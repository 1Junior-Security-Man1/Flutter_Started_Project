import 'package:bounty_hub_client/data/models/entity/campaign/campaign.dart';

class CompanyListResponse {
  List<Campaign> content;

  CompanyListResponse(
    {
      this.content,
    });

  CompanyListResponse.fromJson(Map<String, dynamic> json) {
    if (json['content'] != null) {
      content = new List<Campaign>();
      json['content'].forEach((v) {
        content.add(new Campaign.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.content != null) {
      data['content'] = this.content.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

