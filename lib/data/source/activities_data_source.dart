import 'package:bounty_hub_client/data/models/entity/activity/notification.dart';

abstract class ActivitiesDataSource {

  Future<List<Activity>> getActivities(int page);

  Future<bool> putActivities(List<Activity> notification);

  Future<int> getUnreadActivitiesCount();

  Future<void> readActivity(String id);
}