import 'package:bounty_hub_client/data/models/entity/campaign/campaign.dart';
import 'package:equatable/equatable.dart';

class TasksState extends Equatable {
  const TasksState({
    this.currentTab = 0,
    this.campaing = const [],
  });

  final int currentTab;
  final List<Campaign> campaing;

  TasksState copyWith({
    int currentTab,
    List<Campaign> campaing,
  }) {
    return TasksState(
        currentTab: currentTab ?? this.currentTab,
        campaing: campaing ?? this.campaing);
  }

  @override
  List<Object> get props => [currentTab];
}
