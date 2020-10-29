import 'package:bounty_hub_client/data/models/api/response/tasks_response.dart';
import 'package:bounty_hub_client/data/models/entity/task.dart';
import 'package:bounty_hub_client/data/source/task_data_source.dart';
import 'package:bounty_hub_client/network/server_api.dart';

class TaskRepository extends TaskDataSource {

  final RestClient client;

  TaskRepository(this.client);

  @override
  Future<TasksResponse> getTasks(String userId, int page) {
    return client.getTasks(userId, page, 10, 'APPROVED', 'rewardAmount,desc', true, 'PUBLIC');
  }

  @override
  Future<Task> getTask(String taskId) {
    return client.getTask(taskId);
  }
}