import 'package:bounty_hub_client/data/models/api/response/token_response.dart';

abstract class UserDataSource {

  Future<String> getAccessToken();

  void setEmail(String email);

  void setConfirmCode(String confirmCode);

  String getEmail();

  String getConfirmCode();

  void saveAccessToken(TokenResponse response);
}