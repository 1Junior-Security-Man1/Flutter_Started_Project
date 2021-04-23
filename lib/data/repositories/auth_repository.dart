import 'package:flutter_starter/data/models/api/request/auth_request.dart';
import 'package:flutter_starter/data/models/api/response/basic_token.dart';
import 'package:flutter_starter/data/models/api/response/token_response.dart';
import 'package:flutter_starter/data/source/login_data_source.dart';
import 'package:flutter_starter/network/constants.dart';
import 'package:flutter_starter/network/server_api.dart';

class AuthRepository extends AuthDataSource {

  final RestClient client;

  AuthRepository(this.client);

  @override
  Future<void> authenticate(String email, String password) {
    return Future.delayed(const Duration(milliseconds: 2000));
  }

  @override
  Future<TokenResponse> confirmCode(String email, String code) {
    return client.confirmCode(email, code, 'password');
  }

  @override
  Future<BasicToken> getBasicToken() {
    return client.getBasicToken();
  }
}