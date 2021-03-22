import 'dart:io';

import 'package:bounty_hub_client/app.dart';

class AdHelper {

  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return  currentFlavour.bannerAndroidUnitId;
    } else if (Platform.isIOS) {
      return currentFlavour.bannerIOSUnitId;
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }
}