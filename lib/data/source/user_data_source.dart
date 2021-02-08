import 'dart:io';

import 'package:bounty_hub_client/data/models/api/response/image_response.dart';
import 'package:bounty_hub_client/data/models/api/response/token_response.dart';

abstract class UserDataSource {

  Future<String> getAccessToken();

  TokenResponse saveAccessToken(TokenResponse response);

  void removeAccessData();

  Future<ImageResponse> uploadImage(File image);

  saveGuestMode(bool value);
}