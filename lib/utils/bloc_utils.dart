import 'dart:io';

import 'package:bounty_hub_client/app.dart';
import 'package:bounty_hub_client/data/remote_app_data.dart';
import 'package:bounty_hub_client/data/enums/app_types.dart';
import 'package:bounty_hub_client/utils/locator.dart';

// TODO hardcode solution. Block does not respond to the change of the enum values like ui/pages/authorization/cubit/authorization_state.dart:3 - like AuthorizationStatus etc.
int generateSignature() {
  return DateTime.now().millisecondsSinceEpoch;
}

// Method gets the values application mode and build version from firebase remote config,
// this is needed for hide some UI components, for approval in the Apple Store Connect
bool isNoCryptoMode() {
  return Platform.isIOS && locator<RemoteAppData>().appType == AppType.NON_CRYPTO && locator<RemoteAppData>().buildVersion == AppState.buildVersion;
}

/* Current store version: 1.0.12

1.0.12 в стор
включаем NON_CRYPTO и 1.0.12
получаем апрув
включаем DEFAULT и 1.0.12
выпускаем релиз

1.0.13 в стор
включаем NON_CRYPTO и 1.0.13
получаем апрув
включаем DEFAULT и 1.0.13
выпускаем релиз

При этом версия 1.0.12 не переключится на NO CRYPTO из за разности версий с remote config*/
