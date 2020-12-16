part of 'activity_cubit.dart';

enum ActivityStatus{ initial, success, failure }

class ActivityState extends Equatable {
  const ActivityState({
    this.status = ActivityStatus.initial,
    this.activities = const <Activity>[],
    this.hasReachedMax = false,
  });

  final List<Activity> activities;
  final bool hasReachedMax;
  final ActivityStatus status;

  ActivityState copyWith({
    ActivityStatus status,
    List<Activity> activities,
    bool hasReachedMax
  }) {
    return ActivityState(
      status: status ?? this.status,
      activities: activities ?? this.activities,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [status, activities, hasReachedMax];
}
