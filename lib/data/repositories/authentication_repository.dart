import 'package:bounty_hub_client/data/models/api/request/auth_request.dart';
import 'package:bounty_hub_client/network/server_api.dart';

class LoginRepository {

  final RestClient restClient;

  LoginRepository(this.restClient);

  void authenticate(String email) {
    restClient.getAuthenticateCode(AuthRequest('','','',email,''));
  }
}