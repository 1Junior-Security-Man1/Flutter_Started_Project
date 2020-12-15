part of 'badge_cubit.dart';

class ActivityBadgeState {
  final int unreadCount;

  ActivityBadgeState({this.unreadCount});

  ActivityBadgeState copyWith({int unreadCount}) {
    return ActivityBadgeState(unreadCount: unreadCount ?? this.unreadCount);
  }
}
