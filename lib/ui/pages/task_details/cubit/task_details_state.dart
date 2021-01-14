import 'package:bounty_hub_client/data/models/entity/campaign/campaign.dart';
import 'package:bounty_hub_client/data/models/entity/task/task.dart';
import 'package:bounty_hub_client/data/models/entity/user_task/user_task.dart';
import 'package:equatable/equatable.dart';

enum TaskDetailsStatus{ loading, fetch_success, fetch_failure }
enum UserTaskStatus{ loading, fetch_success, fetch_failure, take_success, take_failure,  confirm_success, confirm_failure}

class TaskDetailsState extends Equatable {

  const TaskDetailsState({
    this.status = TaskDetailsStatus.loading,
    this.userTaskStatus = UserTaskStatus.loading,
    this.task,
    this.campaign,
    this.userTask,
    this.errorMessage,
    this.link,
  });

  final TaskDetailsStatus status;
  final UserTaskStatus userTaskStatus;
  final Task task;
  final UserTask userTask;
  final Campaign campaign;
  final String errorMessage;
  final String link;

  TaskDetailsState copyWith({
    TaskDetailsStatus status,
    UserTaskStatus userTaskStatus,
    Task task,
    Campaign campaign,
    UserTask userTask,
    String errorMessage,
    String link,
  }) {
    return TaskDetailsState(
      link: link ?? this.link,
      status: status ?? this.status,
      userTaskStatus: userTaskStatus ?? this.userTaskStatus,
      task: task ?? this.task,
      campaign: campaign ?? this.campaign,
      userTask: userTask ?? this.userTask,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [link, status, task, campaign, userTaskStatus, errorMessage];
}