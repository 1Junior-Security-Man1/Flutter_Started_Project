import 'package:flutter_starter/data/models/api/response/token_response.dart';
import 'package:flutter_starter/data/models/api/response/basic_token.dart';

abstract class AuthDataSource {

  Future<void> authenticate(String email, String secret);

  Future<TokenResponse> confirmCode(String email, String code);

  Future<BasicToken> getBasicToken();
}