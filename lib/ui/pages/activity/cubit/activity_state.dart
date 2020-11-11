part of 'activity_cubit.dart';

@immutable
class ActivityState {
  final List<Activity> activities;

  ActivityState({this.activities = const []});

  ActivityState copyWith({activities}) {
    return ActivityState(activities: activities ?? this.activities);
  }
}
