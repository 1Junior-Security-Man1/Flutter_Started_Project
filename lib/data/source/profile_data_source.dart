
import 'package:bounty_hub_client/data/enums/social_networks_types.dart';
import 'package:bounty_hub_client/data/models/entity/user/social.dart';
import 'package:bounty_hub_client/data/models/entity/user/user.dart';

abstract class ProfileDataSource {

  Future<User> getUser();

  Future<bool> putUser(User user);

  Future<List<Socials>> getMySocialAccounts();

  Future<void> setSocial(SocialNetworkType socialType, String profileUrl);

  Future<void> removeSocial(String id);
}