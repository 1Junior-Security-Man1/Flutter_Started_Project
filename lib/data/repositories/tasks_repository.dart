import 'package:bounty_hub_client/data/models/api/response/tasks_response.dart';
import 'package:bounty_hub_client/data/models/api/response/user_tasks_response.dart';
import 'package:bounty_hub_client/data/models/entity/task/task.dart';
import 'package:bounty_hub_client/data/models/entity/user_task/user_task.dart';
import 'package:bounty_hub_client/data/source/task_data_source.dart';
import 'package:bounty_hub_client/network/server_api.dart';
import 'package:bounty_hub_client/network/constants.dart';

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

  @override
  Future<UserTask> getUserTask(String userId, String taskId) {
    return client.getUserTask(userId, taskId, Constants.baseUrl + '/task/' + taskId);
  }

  @override
  Future<UserTasksResponse> getUserTasks(String userId, int page) {
    return client.getUserTasks(userId, page, 10);
  }

  @override
  Future<UserTask> takeTask(String userId, String taskId) {
    return client.takeTask(userId, taskId);
  }
}