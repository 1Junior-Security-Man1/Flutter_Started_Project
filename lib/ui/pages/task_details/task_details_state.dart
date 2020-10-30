import 'package:bounty_hub_client/data/models/entity/campaign/campaign.dart';
import 'package:bounty_hub_client/data/models/entity/task/task.dart';
import 'package:bounty_hub_client/data/models/entity/user_task/user_task.dart';
import 'package:equatable/equatable.dart';

enum TaskDetailsStatus{ loading, success, failure }
enum UserTaskStatus{ loading, success, failure, take_success, take_failure }

class TaskDetailsState extends Equatable {

  const TaskDetailsState({
    this.status = TaskDetailsStatus.loading,
    this.userTaskStatus = UserTaskStatus.loading,
    this.task,
    this.campaign,
    this.userTask,
    this.errorMessage,
  });

  final TaskDetailsStatus status;
  final UserTaskStatus userTaskStatus;
  final Task task;
  final UserTask userTask;
  final Campaign campaign;
  final String errorMessage;

  TaskDetailsState copyWith({
    TaskDetailsStatus status,
    UserTaskStatus userTaskStatus,
    Task task,
    Campaign campaign,
    UserTask userTask,
    String errorMessage,
  }) {
    return TaskDetailsState(
      status: status ?? this.status,
      userTaskStatus: userTaskStatus ?? this.userTaskStatus,
      task: task ?? this.task,
      campaign: campaign ?? this.campaign,
      userTask: userTask ?? this.userTask,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [status, task, campaign, userTaskStatus, errorMessage];
}