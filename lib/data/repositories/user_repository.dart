import 'dart:io';

import 'package:bounty_hub_client/data/app_data.dart';
import 'package:bounty_hub_client/data/models/api/response/image_response.dart';
import 'package:bounty_hub_client/data/models/api/response/token_response.dart';
import 'package:bounty_hub_client/data/source/user_data_source.dart';
import 'package:bounty_hub_client/network/server_api.dart';

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
  Future<ImageResponse> uploadImage(File image) async {
    if(image != null && image.existsSync()) {
      return client.uploadImage(image);
    }
    return Future.value(ImageResponse());
  }

  @override
  void clearAccessToken() {
    AppData.instance.clearAccessToken();
  }

  @override
  void saveGuestMode(bool value) {
    AppData.instance.saveGuestMode(value);
  }
}