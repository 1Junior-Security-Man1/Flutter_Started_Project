import 'package:bounty_hub_client/data/enums/social_networks_types.dart';
import 'package:bounty_hub_client/data/models/api/request/set_social.dart';
import 'package:bounty_hub_client/data/models/entity/user/social.dart';
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
  Future<List<Socials>> getMySocialAccounts() {
    return client.getMySocialAccounts();
  }

  @override
  Future<void> removeSocial(String id) {
    return client.removeSocial(id);
  }

  @override
  Future<void> setSocial(SocialNetworkType socialType, String profileUrl) {
    var request = SetSocialRequest(
        accountUrl: profileUrl,
        socialNetwork: socialNetworkTypeEnumMap[socialType]);
    return client.setSocial(request);
  }

  @override
  Future<bool> putUser(User user) async {
    return true;
  }
}
