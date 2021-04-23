import 'package:flutter_starter/data/models/entity/activity/notification.dart';

class NotificationResponse {
  List<Activity> content;

  NotificationResponse({this.content});

  NotificationResponse.fromJson(Map<String, dynamic> json) {
    if (json['content'] != null) {
      content = new List<Activity>();
      json['content'].forEach((v) { content.add(new Activity.fromJson(v)); });
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