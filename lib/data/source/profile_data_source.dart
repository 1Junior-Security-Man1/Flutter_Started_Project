
import 'package:flutter_starter/data/enums/social_networks_types.dart';
import 'package:flutter_starter/data/models/entity/user/social.dart';
import 'package:flutter_starter/data/models/entity/user/user.dart';

abstract class ProfileDataSource {

  Future<User> getUser();

  Future<bool> putUser(User user);

  void removeUserData();

  Future<List<Socials>> getMySocialAccounts();

  Future<void> setSocial(SocialNetworkType socialType, String profileUrl);

  Future<void> removeSocial(String id);
}