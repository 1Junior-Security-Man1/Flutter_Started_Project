import 'package:flutter_starter/data/enums/social_networks_types.dart';
import 'package:flutter_starter/data/models/entity/user/social.dart';
import 'package:flutter_starter/data/models/entity/user/user.dart';
import 'package:flutter_starter/data/source/profile_data_source.dart';
import 'package:hive/hive.dart';

class ProfileLocalRepository extends ProfileDataSource {
  var userKey = 'key';

  @override
  Future<User> getUser() async {
    Box box;
    if (!Hive.isBoxOpen(userKey)) {
      box = await Hive.openBox(userKey);
    } else {
      box = Hive.box(userKey);
    }
    return User.fromJson(Map.from(box.get(userKey) ?? {}));
  }

  @override
  Future<bool> putUser(User user) async {
    try {
      var box = await Hive.openBox(userKey);
      await box.put(userKey, user.toJson());
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  @override
  Future<List<Socials>> getMySocialAccounts() {
    throw UnimplementedError();
  }

  void clear() {
    Hive.deleteBoxFromDisk(userKey);
  }

  @override
  Future<void> removeSocial(String id) async {}

  @override
  Future<void> setSocial(SocialNetworkType socialType, String profileUrl) async {}

  @override
  void removeUserData() async {
    try {
      var box = await Hive.openBox(userKey);
      await box.put(userKey, Map<String, dynamic>());
    } catch (e) {
      print(e);
    }
  }
}
