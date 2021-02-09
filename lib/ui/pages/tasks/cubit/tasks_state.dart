import 'package:bounty_hub_client/data/models/entity/campaign/campaign.dart';
import 'package:equatable/equatable.dart';

class TasksState extends Equatable {
  const TasksState({
    this.currentTab = 0,
    this.campaigns = const [],
  });

  final int currentTab;
  final List<Campaign> campaigns;

  TasksState copyWith({
    int currentTab,
    List<Campaign> campaigns,
  }) {
    return TasksState(
        currentTab: currentTab ?? this.currentTab,
        campaigns: campaigns ?? this.campaigns);
  }

  @override
  List<Object> get props => [currentTab];
}
