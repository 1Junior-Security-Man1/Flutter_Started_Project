import 'package:bounty_hub_client/data/models/api/response/token_response.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AppData {

  AppData._privateConstructor();
  static final AppData _instance = AppData._privateConstructor();
  static AppData get instance => _instance;

  final _storage = FlutterSecureStorage();
  
  void saveAccessToken(TokenResponse data) {
    _storage.write(key: 'ACCESS_TOKEN', value: data.accessToken);
  }

  Future<String> getAccessToken() {
    return _storage.read(key: 'ACCESS_TOKEN');
  }
}