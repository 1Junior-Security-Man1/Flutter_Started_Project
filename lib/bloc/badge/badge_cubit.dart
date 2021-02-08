import 'package:bloc/bloc.dart';
import 'package:bounty_hub_client/data/repositories/activities_repository.dart';

part 'badge_state.dart';

class ActivityBadgeCubit extends Cubit<ActivityBadgeState> {
  ActivitiesRepository activitiesRepository;

  ActivityBadgeCubit(this.activitiesRepository) : super(ActivityBadgeState(unreadCount: 0));

  void getCount() async {
    var count = await activitiesRepository.getUnreadActivitiesCount();
    emit(state.copyWith(unreadCount: count));
  }

  void readNotification(String id) async {
    await activitiesRepository.readActivity(id);
    emit(state.copyWith(unreadCount: state.unreadCount - 1));
  }

  void destroy() async {
    emit(state.copyWith(unreadCount: 0));
  }
}
