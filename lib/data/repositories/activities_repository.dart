import 'package:flutter_starter/data/models/entity/activity/notification.dart';
import 'package:flutter_starter/data/source/activities_data_source.dart';
import 'package:flutter_starter/network/server_api.dart';

class ActivitiesRepository extends ActivitiesDataSource {
  final RestClient client;

  ActivitiesRepository(this.client);

  @override
  Future<List<Activity>> getActivities(int page) async {
    var response = (await client.getActivities(page, 20));
    return response.content;
  }

  @override
  Future<bool> putActivities(List<Activity> notification) async {
    return true;
  }

  @override
  Future<int> getUnreadActivitiesCount() async {
    return (await client.getUnreadActivitiesCount()).count;
  }

  @override
  Future<void> readActivity(String id) {
    return client.readNotification(id);
  }
}
