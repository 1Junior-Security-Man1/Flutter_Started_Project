import 'package:bounty_hub_client/data/models/api/response/token_response.dart';

abstract class UserDataSource {

  Future<String> getAccessToken();

  TokenResponse saveAccessToken(TokenResponse response);
}