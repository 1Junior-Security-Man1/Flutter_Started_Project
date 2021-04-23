import 'package:flutter_starter/data/app_data.dart';
import 'package:flutter_starter/data/enums/social_networks_types.dart';
import 'package:flutter_starter/data/models/api/request/set_social.dart';
import 'package:flutter_starter/data/models/entity/user/social.dart';
import 'package:flutter_starter/data/models/entity/user/user.dart';
import 'package:flutter_starter/data/source/profile_data_source.dart';
import 'package:flutter_starter/network/server_api.dart';

class ProfileRepository extends ProfileDataSource {
  final RestClient client;

  ProfileRepository(this.client);

  @override
  Future<User> getUser() async {
    return client.getUser(userId: await AppData.instance.getUserId());
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
     await client.putUser(user.id, user);
     return true;
  }

  @override
  void removeUserData() {
    // TODO: implement removeUser
  }
}
