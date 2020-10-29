import 'package:bounty_hub_client/data/models/entity/task/task.dart';
import 'package:equatable/equatable.dart';

enum TasksStatus{ initial, success, failure }

class TasksState extends Equatable {

  const TasksState({
    this.status = TasksStatus.initial,
    this.tasks = const <Task>[],
    this.hasReachedMax = false,
  });

  final TasksStatus status;
  final List<Task> tasks;
  final bool hasReachedMax;

  TasksState copyWith({
    TasksStatus status,
    List<Task> tasks,
    bool hasReachedMax
  }) {
    return TasksState(
      status: status ?? this.status,
      tasks: tasks ?? this.tasks,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [status, tasks, hasReachedMax];
}