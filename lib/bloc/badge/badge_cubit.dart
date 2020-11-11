import 'package:bloc/bloc.dart';
import 'package:bounty_hub_client/data/repositories/activities_repository.dart';

part 'badge_state.dart';

class BadgeCubit extends Cubit<BadgeState> {
  ActivitiesRepository activitiesRepository;

  BadgeCubit(this.activitiesRepository) : super(BadgeState(unreadCount: 0));

  void getCount() async {
    var count = await activitiesRepository.getUnreadActivitiesCount();
    emit(state.copyWith(unreadCount: count));
  }

  void readNotification(String id) async {
    await activitiesRepository.readNotification(id);
    emit(state.copyWith(unreadCount: state.unreadCount - 1));
  }
}
