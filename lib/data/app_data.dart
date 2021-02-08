import 'package:bounty_hub_client/data/models/api/response/token_response.dart';
import 'package:bounty_hub_client/network/constants.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AppData {
  AppData._privateConstructor();

  static final AppData _instance = AppData._privateConstructor();

  static AppData get instance => _instance;

  final _storage = FlutterSecureStorage();

  void saveAccessToken(TokenResponse data) {
    _storage.write(key: 'ACCESS_TOKEN', value: data.accessToken);
    _storage.write(key: 'USER_ID', value: data.userId);
  }

  void saveGuestMode(bool guest) {
    _storage.write(key: 'GUEST_MODE', value: (guest ? 'true' : 'false'));
  }

  Future<bool> isGuestMode() async {
    return await _storage.read(key: 'GUEST_MODE') == 'true';
  }

  void saveToken(String token) {
    _storage.write(key: 'ACCESS_TOKEN', value: token);
  }

  Future<String> getAccessToken() async {
    return _storage.read(key: 'ACCESS_TOKEN');
  }

  Future<String> getUserId() async{
    return _storage.read(key: 'USER_ID');
  }

  void clearAccessData() {
    _storage.write(key: 'ACCESS_TOKEN', value: '');
    _storage.write(key: 'USER_ID', value: '');
  }

  void saveTrxEquivalent(double value) {
    _storage.write(key: 'TRX_TO_USD', value: value?.toString());
  }

  Future<double> getTrxEquivalent() async {
    String value = await _storage.read(key: 'TRX_TO_USD');
    return value != null && value.isNotEmpty ? double.parse(value) : Constants.equivalentTrxToUsd;
  }
}
