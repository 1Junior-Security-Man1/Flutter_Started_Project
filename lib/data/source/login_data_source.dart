import 'package:bounty_hub_client/data/models/api/response/token_response.dart';

abstract class LoginDataSource {

  Future<void> authenticate(String email, String secret);

  Future<TokenResponse> confirmCode(String email, String code);
}