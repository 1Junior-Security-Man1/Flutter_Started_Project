import 'package:flutter_starter/data/models/api/response/confirm_task_response.dart';
import 'package:flutter_starter/data/models/api/response/tasks_response.dart';
import 'package:flutter_starter/data/models/api/response/user_tasks_response.dart';
import 'package:flutter_starter/data/models/entity/task/task.dart';
import 'package:flutter_starter/data/models/entity/user_task/user_task.dart';
import 'package:flutter_starter/data/repositories/user_repository.dart';
import 'package:flutter_starter/data/source/task_data_source.dart';
import 'package:flutter_starter/network/constants.dart';
import 'package:flutter_starter/network/server_api.dart';
import 'package:flutter_starter/utils/bloc_utils.dart';

class TaskRepository extends TaskDataSource {

  final RestClient client;

  final UserRepository userRepository;

  TaskRepository(this.client, this.userRepository);

  @override
  Future<TasksResponse> getTasks(String campaignId, String socialMediaType, String userId, int page) {
    Map<String, dynamic> queries = Map<String, dynamic>();
    if(userId != null && userId.isNotEmpty) {
      queries.putIfAbsent('userId', () => userId);
    }
    queries.putIfAbsent('campaignsIds', () => campaignId ?? '');
    queries.putIfAbsent('socialType', () => socialMediaType ?? '');
    queries.putIfAbsent('page', () => page);
    queries.putIfAbsent('size', () => 20);
    queries.putIfAbsent('status', () => 'APPROVED');
    queries.putIfAbsent('sort', () => 'rewardAmount,desc');
    queries.putIfAbsent('running', () => true);
    queries.putIfAbsent('hasPermissions', () => false);
    queries.putIfAbsent('accessMode', () => 'PUBLIC');

    if(isNoSocialMode()) {
      return client.getNoSocialTasks(queries);
    } else {
      return  client.getTasks(queries);
    }
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
    return client.getUserTasks(campaignId ?? '', socialMediaType ?? '', userId, page, 10);
  }

  @override
  Future<UserTask> takeTask(String userId, String taskId) {
    return client.takeTask(userId, taskId);
  }

  @override
  Future<String> confirmSocialParserTask(String userId, String userTaskId, String redirectUrl, String comment, String imageId) {
    return client.confirmSocialParserTask(userId, userTaskId, redirectUrl, comment ?? '', imageId ?? '');
  }

  @override
  Future<ConfirmTaskResponse> confirmAutoCheckTask(String userId, String userTaskId, String redirectUrl, String comment) {
    return client.confirmAutoCheckTask(userId, userTaskId, redirectUrl ?? '', comment ?? '');
  }

  @override
  Future<String> reconfirmAutoCheckTask(String userId, String userTaskId, String redirectUrl, String comment) {
    return client.reconfirmAutoCheckTask(userId, userTaskId, redirectUrl ?? '', comment ?? '');
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