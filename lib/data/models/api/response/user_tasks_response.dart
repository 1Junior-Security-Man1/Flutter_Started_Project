import 'package:bounty_hub_client/data/models/entity/user_task/user_task.dart';

class UserTasksResponse {
  List<UserTask> _content;

  List<UserTask> get content => _content;

  UserTasksResponse({
    List<UserTask> content,
  }){
    _content = content;
}

  UserTasksResponse.fromJson(dynamic json) {
    if (json["content"] != null) {
      _content = [];
      json["content"].forEach((v) {
        _content.add(UserTask.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_content != null) {
      map["content"] = _content.map((v) => v.toJson()).toList();
    }
    return map;
  }
}