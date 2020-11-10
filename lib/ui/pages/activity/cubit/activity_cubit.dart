import 'package:bloc/bloc.dart';
import 'package:bounty_hub_client/data/models/entity/activity/notification.dart';
import 'package:bounty_hub_client/data/source/activities_data_source.dart';
import 'package:meta/meta.dart';

part 'activity_state.dart';

class ActivityCubit extends Cubit<ActivityState> {
  ActivityCubit(this.apiRepository) : super(ActivityState());

  int currentPage = 0;
  bool isLastPage = false;

  final ActivitiesDataSource apiRepository;

  void loadActivities() async {
    if(isLastPage) return;
    var newActivities = await apiRepository.getActivities(currentPage);
    currentPage++;
    var allActivities = List.of(state.activities);
    allActivities.addAll(newActivities);
    emit(state.copyWith(activities: allActivities));
    if(newActivities.length<20){
      isLastPage = true;
    }
  }
}
