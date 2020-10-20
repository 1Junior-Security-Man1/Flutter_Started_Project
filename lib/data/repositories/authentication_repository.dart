import 'package:bounty_hub_client/data/models/api/request/auth_request.dart';
import 'package:bounty_hub_client/network/server_api.dart';

class AuthenticationRepository {

  final RestClient restClient;

  AuthenticationRepository(this.restClient);

  void authenticate(String email) {
    restClient.getAuthenticateCode(AuthRequest('','','',email,''));
  }
}