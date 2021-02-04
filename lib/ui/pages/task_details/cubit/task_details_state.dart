import 'package:bounty_hub_client/data/models/entity/campaign/campaign.dart';
import 'package:bounty_hub_client/data/models/entity/task/task.dart';
import 'package:bounty_hub_client/data/models/entity/user_task/user_task.dart';
import 'package:equatable/equatable.dart';

enum TaskDetailsStatus{ loading, success, failure }
enum UserTaskStatus{ loading, failure, fetch_success, fetch_failure, leave_success, take_success, confirm_success, reconfirm, reconfirm_complete}

class TaskDetailsState extends Equatable {

  const TaskDetailsState({
    this.status = TaskDetailsStatus.loading,
    this.userTaskStatus = UserTaskStatus.loading,
    this.task,
    this.campaign,
    this.userTask,
    this.errorMessage,
    this.link,
    this.showTimer = false,
    this.refresh = false,
    this.signature,
  });

  final TaskDetailsStatus status;
  final UserTaskStatus userTaskStatus;
  final Task task;
  final UserTask userTask;
  final Campaign campaign;
  final String errorMessage;
  final String link;
  final bool showTimer;
  final bool refresh;
  final int signature;

  TaskDetailsState copyWith({
    TaskDetailsStatus status,
    UserTaskStatus userTaskStatus,
    Task task,
    Campaign campaign,
    UserTask userTask,
    String errorMessage,
    String link,
    bool showTimer,
    bool refresh,
    int signature,
  }) {
    return TaskDetailsState(
      signature: signature ?? this.signature,
      showTimer: showTimer ?? this.showTimer,
      link: link ?? this.link,
      status: status ?? this.status,
      userTaskStatus: userTaskStatus ?? this.userTaskStatus,
      task: task ?? this.task,
      campaign: campaign ?? this.campaign,
      userTask: userTask ?? this.userTask,
      errorMessage: errorMessage ?? this.errorMessage,
      refresh: refresh ?? this.refresh,
    );
  }

  @override
  List<Object> get props => [signature, showTimer, link, status, refresh, task, userTask, campaign, userTaskStatus, errorMessage];
}