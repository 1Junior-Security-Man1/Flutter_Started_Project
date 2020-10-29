import 'package:bounty_hub_client/data/models/entity/task/task.dart';

class TasksResponse {
  List<Task> _content;

  List<Task> get content => _content;

  TasksResponse({
    List<Task> content,
  }){
    _content = content;
}

  TasksResponse.fromJson(dynamic json) {
    if (json["content"] != null) {
      _content = [];
      json["content"].forEach((v) {
        _content.add(Task.fromJson(v));
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