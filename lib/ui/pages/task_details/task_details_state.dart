import 'package:bounty_hub_client/data/models/entity/task.dart';
import 'package:equatable/equatable.dart';

enum TaskDetailsStatus{ loading, success, failure }

class TaskDetailsState extends Equatable {

  const TaskDetailsState({
    this.status = TaskDetailsStatus.loading,
    this.task,
  });

  final TaskDetailsStatus status;
  final Task task;

  TaskDetailsState copyWith({
    TaskDetailsStatus status,
    Task task,
  }) {
    return TaskDetailsState(
      status: status ?? this.status,
      task: task ?? this.task,
    );
  }

  @override
  List<Object> get props => [status, task];
}