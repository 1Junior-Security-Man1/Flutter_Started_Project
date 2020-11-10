import 'package:bounty_hub_client/data/models/entity/activity/notification.dart';

class NotificationResponse {
  List<Activity> content;
  int totalPages;
  int totalElements;
  bool last;
  int numberOfElements;
  List<Sort> sort;
  bool first;
  int size;
  int number;

  NotificationResponse({this.content, this.totalPages, this.totalElements, this.last, this.numberOfElements, this.sort, this.first, this.size, this.number});

  NotificationResponse.fromJson(Map<String, dynamic> json) {
    if (json['content'] != null) {
      content = new List<Activity>();
      json['content'].forEach((v) { content.add(new Activity.fromJson(v)); });
    }
    totalPages = json['totalPages'];
    totalElements = json['totalElements'];
    last = json['last'];
    numberOfElements = json['numberOfElements'];
    if (json['sort'] != null) {
      sort = new List<Sort>();
      json['sort'].forEach((v) { sort.add(new Sort.fromJson(v)); });
    }
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
    if (this.sort != null) {
      data['sort'] = this.sort.map((v) => v.toJson()).toList();
    }
    data['first'] = this.first;
    data['size'] = this.size;
    data['number'] = this.number;
    return data;
  }
}



class Sort {
  String direction;
  String property;
  bool ignoreCase;
  String nullHandling;
  bool ascending;
  bool descending;

  Sort({this.direction, this.property, this.ignoreCase, this.nullHandling, this.ascending, this.descending});

  Sort.fromJson(Map<String, dynamic> json) {
    direction = json['direction'];
    property = json['property'];
    ignoreCase = json['ignoreCase'];
    nullHandling = json['nullHandling'];
    ascending = json['ascending'];
    descending = json['descending'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['direction'] = this.direction;
    data['property'] = this.property;
    data['ignoreCase'] = this.ignoreCase;
    data['nullHandling'] = this.nullHandling;
    data['ascending'] = this.ascending;
    data['descending'] = this.descending;
    return data;
  }
}