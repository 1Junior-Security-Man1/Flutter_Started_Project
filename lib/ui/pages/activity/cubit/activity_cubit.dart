import 'package:bloc/bloc.dart';
import 'package:bounty_hub_client/data/models/entity/activity/notification.dart';
import 'package:bounty_hub_client/data/repositories/activities_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';

part 'activity_state.dart';

class ActivityCubit extends Cubit<ActivityState> {

  final log = Logger();
  final ActivitiesRepository _activitiesRepository;
  int page = 1;
  bool fetching = false;

  ActivityCubit(this._activitiesRepository) : super(ActivityState());

  void fetchActivities() async {
    if (state.hasReachedMax) {
      emit(state);
      return;
    }

    if (state.status == ActivityStatus.initial && !fetching) {
      final activities = await _fetchActivities(0);
      emit(state.copyWith(
        status: ActivityStatus.success,
        activities: activities,
        hasReachedMax: false,
      ));
      return;
    }

    if(fetching) return;
    final activities = await _fetchActivities(page);
    if(activities == null || activities.isEmpty) {
      emit(state.copyWith(hasReachedMax: true));
    } else {
      emit(state.copyWith(
        status: ActivityStatus.success,
        activities: List.of(state.activities)..addAll(activities),
        hasReachedMax: false,
      ));
      page++;
    }
  }

  Future<List<Activity>> _fetchActivities(int page) async {
    fetching = true;
    return _activitiesRepository.getActivities(page)
        .whenComplete(() => fetching = false)
        .catchError((Object obj) {
      log.e(obj);
      fetching = false;
      emit(state.copyWith(status: ActivityStatus.failure));
    });
  }
}
