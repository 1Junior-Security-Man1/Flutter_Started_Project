import 'package:bounty_hub_client/data/models/entity/user_task/user_task.dart';
import 'package:equatable/equatable.dart';

enum MyTasksStatus{ initial, success, failure }

class MyTasksState extends Equatable {

  const MyTasksState({
    this.status = MyTasksStatus.initial,
    this.tasks = const <UserTask>[],
    this.hasReachedMax = false,
  });

  final MyTasksStatus status;
  final List<UserTask> tasks;
  final bool hasReachedMax;

  MyTasksState copyWith({
    MyTasksStatus status,
    List<UserTask> tasks,
    bool hasReachedMax
  }) {
    return MyTasksState(
      status: status ?? this.status,
      tasks: tasks ?? this.tasks,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [status, tasks, hasReachedMax];
}