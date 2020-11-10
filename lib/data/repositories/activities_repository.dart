import 'package:bounty_hub_client/data/models/entity/activity/notification.dart';
import 'package:bounty_hub_client/data/source/activities_data_source.dart';
import 'package:bounty_hub_client/network/server_api.dart';

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
}
