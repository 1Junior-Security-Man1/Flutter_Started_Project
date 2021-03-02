import 'package:bounty_hub_client/data/enums/app_types.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

class RemoteAppData {

  final RemoteConfig _remoteConfig;
  final defaults = <String, dynamic>{};

  static RemoteAppData _instance;
  static Future<RemoteAppData> getInstance() async {
    if (_instance == null) {
      _instance = RemoteAppData(
        remoteConfig: await RemoteConfig.instance,
      );
    }

    return _instance;
  }

  RemoteAppData({RemoteConfig remoteConfig}) : _remoteConfig = remoteConfig;

  AppType get appType => EnumToString.fromString(AppType.values, _remoteConfig.getString('APP_MODE')) ?? AppType.DEFAULT;

  Future init() async {
    await _remoteConfig.setDefaults(defaults);
    await _fetchAndActivate();
  }

  Future _fetchAndActivate() async {
    await _remoteConfig.fetch(expiration: Duration(seconds: 0));
    await _remoteConfig.activateFetched();
  }
}
