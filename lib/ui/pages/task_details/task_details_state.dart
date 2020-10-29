import 'package:bounty_hub_client/data/models/entity/campaign/campaign.dart';
import 'package:bounty_hub_client/data/models/entity/task/task.dart';
import 'package:equatable/equatable.dart';

enum TaskDetailsStatus{ loading, success, failure }

class TaskDetailsState extends Equatable {

  const TaskDetailsState({
    this.status = TaskDetailsStatus.loading,
    this.task,
    this.campaign,
  });

  final TaskDetailsStatus status;
  final Task task;
  final Campaign campaign;

  TaskDetailsState copyWith({
    TaskDetailsStatus status,
    Task task,
    Campaign campaign,
  }) {
    return TaskDetailsState(
      status: status ?? this.status,
      task: task ?? this.task,
      campaign: campaign ?? this.campaign,
    );
  }

  @override
  List<Object> get props => [status, task, campaign];
}