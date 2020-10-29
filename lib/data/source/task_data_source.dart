import 'package:bounty_hub_client/data/models/api/response/tasks_response.dart';
import 'package:bounty_hub_client/data/models/entity/task/task.dart';

abstract class TaskDataSource {
  Future<TasksResponse> getTasks(String userId, int page);

  Future<Task> getTask(String taskId);
}