import 'package:flutter_starter/data/models/entity/user/user.dart';

abstract class ProfileDataSource {
  Future<User> getUser();
  Future<bool> putUser(User user);
}