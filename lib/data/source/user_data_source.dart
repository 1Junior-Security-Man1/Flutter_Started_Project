import 'package:flutter_starter/data/models/api/response/token_response.dart';

abstract class UserDataSource {
  Future<String> getAccessToken();

  TokenResponse saveAccessToken(TokenResponse response);

  void removeAccessData();
}
