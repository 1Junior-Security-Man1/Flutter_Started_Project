import 'package:equatable/equatable.dart';

class TasksState extends Equatable {

  const TasksState({
    this.currentTab = 0,
  });

  final int currentTab;

  TasksState copyWith({
    int currentTab,
  }) {
    return TasksState(
      currentTab: currentTab ?? this.currentTab,
    );
  }

  @override
  List<Object> get props => [currentTab];
}