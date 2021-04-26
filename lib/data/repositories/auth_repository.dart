import 'package:flutter_starter/data/source/login_data_source.dart';
import 'package:flutter_starter/network/server_api.dart';
import 'package:flutter_starter/data/app_data.dart';

class AuthRepository extends AuthDataSource {
  final RestClient client;

  AuthRepository(this.client);

  @override
  Future<void> authenticate(String email, String password) {
    return Future.delayed(const Duration(milliseconds: 2000)).then((value) =>
        AppData.instance.saveToken('access token received from backend ...'));
  }
}
