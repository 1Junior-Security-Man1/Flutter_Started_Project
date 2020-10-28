import 'package:bounty_hub_client/data/models/api/response/tasks_response.dart';

abstract class TaskDataSource {
  Future<TasksResponse> getTasks(int page);
}