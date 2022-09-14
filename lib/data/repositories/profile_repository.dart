import 'package:flutter_starter/data/app_data.dart';
import 'package:flutter_starter/data/models/entity/user/user.dart';
import 'package:flutter_starter/data/source/profile_data_source.dart';
import 'package:flutter_starter/network/server_api.dart';

class ProfileRepository extends ProfileDataSource {
  final RestClient client;

  ProfileRepository(this.client);

  @override
  Future<User> getUser() async {
    String? userId = await AppData.instance.getUserId();
    return client.getUser(userId!);
  }

  @override
  Future<bool> putUser(User user) async {
    await client.putUser(user.id!, user);
    return true;
  }
}