import 'package:bounty_hub_client/data/models/entity/user/user.dart';
import 'package:bounty_hub_client/data/source/profile_data_source.dart';
import 'package:bounty_hub_client/network/server_api.dart';

class ProfileRepository extends ProfileDataSource {
  final RestClient client;

  ProfileRepository(this.client);

  @override
  Future<User> getUser() {
    return client.getUser();
  }

  @override
  Future<bool> putUser(User user) {
    // TODO: implement putUser
    throw UnimplementedError();
  }
}
