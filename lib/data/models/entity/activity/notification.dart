import 'notification_extra.dart';

class Activity {
  String id;
  String userId;
  String entityName;
  String entityId;
  bool read;
  bool receive;
  String content;
  String action;
  Extra extra;
  int created;
  int updated;

  Activity({this.id, this.userId, this.entityName, this.entityId, this.read, this.receive, this.content, this.action, this.extra, this.created, this.updated});

  Activity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    entityName = json['entityName'];
    entityId = json['entityId'];
    read = json['read'];
    receive = json['receive'];
    content = json['content'];
    action = json['action'];
    extra = json['extra'] != null ? new Extra.fromJson(json['extra']) : null;
    created = json['created'];
    updated = json['updated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['entityName'] = this.entityName;
    data['entityId'] = this.entityId;
    data['read'] = this.read;
    data['receive'] = this.receive;
    data['content'] = this.content;
    data['action'] = this.action;
    if (this.extra != null) {
      data['extra'] = this.extra.toJson();
    }
    data['created'] = this.created;
    data['updated'] = this.updated;
    return data;
  }
}

