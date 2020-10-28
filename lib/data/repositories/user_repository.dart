import 'package:bounty_hub_client/data/app_data.dart';
import 'package:bounty_hub_client/data/models/api/response/token_response.dart';
import 'package:bounty_hub_client/data/source/user_data_source.dart';

class UserRepository extends UserDataSource {

  @override
  Future<String> getAccessToken() {
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
}