import 'dart:io';

import 'package:bounty_hub_client/app.dart';

class AdHelper {

  static final nativeAdStep = 4;

  static int interstitialAdShowsCount = 0;

  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return  currentFlavour.bannerAndroidUnitId;
    } else if (Platform.isIOS) {
      return currentFlavour.bannerIOSUnitId;
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return  currentFlavour.interstitialBannerAndroidUnitId;
    } else if (Platform.isIOS) {
      return currentFlavour.interstitialBannerIOSUnitId;
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static String get tasksNativeAdUnitId {
    if (Platform.isAndroid) {
      return  currentFlavour.tasksNativeAdAndroidUnitId;
    } else if (Platform.isIOS) {
      return currentFlavour.tasksNativeAdIOSUnitId;
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }
}