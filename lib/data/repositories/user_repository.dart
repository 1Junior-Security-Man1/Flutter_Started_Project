import 'package:bounty_hub_client/data/app_data.dart';
import 'package:bounty_hub_client/data/models/api/response/token_response.dart';
import 'package:bounty_hub_client/data/source/user_data_source.dart';

class UserRepository extends UserDataSource {

  UserRepository._internal();
  static UserRepository _instance = UserRepository._internal();
  factory UserRepository() => _instance;

  String _email;
  String _confirmCode;

  @override
  Future<String> getAccessToken() {
    return AppData.instance.getAccessToken();
  }

  @override
  TokenResponse saveAccessToken(TokenResponse response) {
    AppData.instance.saveAccessToken(response);
    return response;
  }

  @override
  void setEmail(String email) {
    this._email = email;
  }

  @override
  String getEmail() {
    return this._email;
  }

  @override
  void setConfirmCode(String confirmCode) {
    this._confirmCode = confirmCode;
  }

  @override
  String getConfirmCode() {
    return this._confirmCode;
  }
}