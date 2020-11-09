import 'package:bounty_hub_client/data/models/entity/task/task.dart';
import 'package:equatable/equatable.dart';

enum TasksListStatus{ initial, success, failure }

class TasksListState extends Equatable {

  const TasksListState({
    this.status = TasksListStatus.initial,
    this.tasks = const <Task>[],
    this.hasReachedMax = false,
  });

  final TasksListStatus status;
  final List<Task> tasks;
  final bool hasReachedMax;

  TasksListState copyWith({
    TasksListStatus status,
    List<Task> tasks,
    bool hasReachedMax
  }) {
    return TasksListState(
      status: status ?? this.status,
      tasks: tasks ?? this.tasks,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [status, tasks, hasReachedMax];
}