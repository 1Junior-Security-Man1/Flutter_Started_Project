part of 'badge_cubit.dart';

class BadgeState {
  final int unreadCount;

  BadgeState({this.unreadCount});

  BadgeState copyWith({int unreadCount}) {
    return BadgeState(unreadCount: unreadCount ?? this.unreadCount);
  }
}
