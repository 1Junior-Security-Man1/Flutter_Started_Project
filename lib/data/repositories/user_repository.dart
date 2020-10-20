import 'package:bounty_hub_client/data/models/api/response/token_response.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserRepository {

  final _storage = FlutterSecureStorage();

  Future<TokenResponse> getAccessToken() async {
    return null;
  }
}