import 'package:bounty_hub_client/data/models/api/response/confirm_task_response.dart';
import 'package:bounty_hub_client/data/models/api/response/tasks_response.dart';
import 'package:bounty_hub_client/data/models/api/response/user_tasks_response.dart';
import 'package:bounty_hub_client/data/models/entity/task/task.dart';
import 'package:bounty_hub_client/data/models/entity/user_task/user_task.dart';
import 'package:bounty_hub_client/data/repositories/user_repository.dart';
import 'package:bounty_hub_client/data/source/task_data_source.dart';
import 'package:bounty_hub_client/network/constants.dart';
import 'package:bounty_hub_client/network/server_api.dart';

class TaskRepository extends TaskDataSource {

  final RestClient client;

  final UserRepository userRepository;

  TaskRepository(this.client, this.userRepository);

  @override
  Future<TasksResponse> getTasks(String campaignId, String socialMediaType, String userId, int page) {
    if(socialMediaType == null) socialMediaType = '';
    if(campaignId == null) campaignId = '';
    return client.getTasks(campaignId, socialMediaType, userId, page, 10, 'APPROVED', 'rewardAmount,desc', true, 'PUBLIC');
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
  Future<UserTasksResponse> getUserTasks(String campaignId, String socialMediaType, String userId, int page) {
    if(socialMediaType == null) socialMediaType = '';
    if(campaignId == null) campaignId = '';
    return client.getUserTasks(campaignId, socialMediaType, userId, page, 10);
  }

  @override
  Future<UserTask> takeTask(String userId, String taskId) {
    return client.takeTask(userId, taskId);
  }

  @override
  Future<String> confirmSocialParserTask(String userId, String userTaskId, String redirectUrl, String comment, String imageId) {
    return client.confirmSocialParserTask(userId, userTaskId, redirectUrl, comment, imageId);
  }

  @override
  Future<ConfirmTaskResponse> confirmAutoCheckTask(String userId, String userTaskId, String redirectUrl, String comment) {
    return client.confirmAutoCheckTask(userId, userTaskId, redirectUrl, comment);
  }

  @override
  Future<String> leaveTask(String userId, String userTaskId) {
    return client.leaveTask(userId, userTaskId);
  }

  @override
  Future<UserTask> retryTask(String userTaskId) {
    return client.retryTask(userTaskId);
  }
}