import 'dart:io';

import 'package:bounty_hub_client/app.dart';

class AdHelper {

  static int interstitialAdShowsCount = 0;

  ///  Calculates the current item position in the list in which to show native ad
  static bool isNativeAdNeedShow(int itemPosition, int step) {
    return (itemPosition + 1) % step == 0;
  }

  ///  Calculates the frequency of Interstitial ads showing. Shows ads with
  ///  a specified frequency of interstitialBannerShowingPeriod value
  static bool isInterstitialAdNeedShow() {
    if(AdHelper.interstitialAdShowsCount < currentFlavour.interstitialBannerShowingPeriod - 1) {
      interstitialAdShowsCount += 1;
      return false;
    } else {
      interstitialAdShowsCount = 0;
      return true;
    }
  }

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

  static String get nativeAdUnitId {
    if (Platform.isAndroid) {
      return  currentFlavour.tasksNativeAdAndroidUnitId;
    } else if (Platform.isIOS) {
      return currentFlavour.tasksNativeAdIOSUnitId;
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }
}