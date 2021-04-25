import 'package:flutter_starter/data/app_data.dart';
import 'package:flutter_starter/data/models/api/response/token_response.dart';
import 'package:flutter_starter/data/source/user_data_source.dart';
import 'package:flutter_starter/network/server_api.dart';

class UserRepository extends UserDataSource {

  final RestClient client;

  UserRepository(this.client);

  @override
  Future<String> getAccessToken() async{
    return AppData.instance.getAccessToken();
  }

  @override
  TokenResponse saveAccessToken(TokenResponse response) {
    AppData.instance.saveAccessToken(response);
    return response;
  }

  Future<String> getUserId() async {
    return AppData.instance.getUserId();
  }

  @override
  void removeAccessData() {
    AppData.instance.clearAccessData();
  }

  @override
  void saveGuestMode(bool value) {
    AppData.instance.saveGuestMode(value);
  }
}