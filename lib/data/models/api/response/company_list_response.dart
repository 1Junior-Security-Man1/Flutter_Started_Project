import 'package:bounty_hub_client/data/models/entity/campaign/campaign.dart';

class CompanyListResponse {
  List<Campaign> content;
  int totalPages;
  int totalElements;
  bool last;
  int numberOfElements;
  List<dynamic> sort;
  bool first;
  int size;
  int number;

  CompanyListResponse(
    {this.content,
      this.totalPages,
      this.totalElements,
      this.last,
      this.numberOfElements,
      this.sort,
      this.first,
      this.size,
      this.number});

  CompanyListResponse.fromJson(Map<String, dynamic> json) {
    if (json['content'] != null) {
      content = new List<Campaign>();
      json['content'].forEach((v) {
        content.add(new Campaign.fromJson(v));
      });
    }
    totalPages = json['totalPages'];
    totalElements = json['totalElements'];
    last = json['last'];
    numberOfElements = json['numberOfElements'];
    sort = json['sort'];
    first = json['first'];
    size = json['size'];
    number = json['number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.content != null) {
      data['content'] = this.content.map((v) => v.toJson()).toList();
    }
    data['totalPages'] = this.totalPages;
    data['totalElements'] = this.totalElements;
    data['last'] = this.last;
    data['numberOfElements'] = this.numberOfElements;
    data['sort'] = this.sort;
    data['first'] = this.first;
    data['size'] = this.size;
    data['number'] = this.number;
    return data;
  }
}

