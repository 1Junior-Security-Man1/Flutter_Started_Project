import 'package:google_mobile_ads/google_mobile_ads.dart';

abstract class Flavor{
  const Flavor();

  String get baseUrl => '';

  String get oneSignalKey => '';

  bool get isProxyEnabled => false;

  bool get showBugBtn => false;

  String get bannerAndroidUnitId => '';

  String get bannerIOSUnitId => '';

  String get interstitialBannerAndroidUnitId => '';

  String get interstitialBannerIOSUnitId => '';

  int get interstitialBannerShowingPeriod => 0; // show banner every 2nd view
}

// Production environment flavour
class ProdFlavour extends Flavor {
  const ProdFlavour();

  @override
  String get baseUrl => 'https://api.bountyhub.io/api';

  @override
  String get bannerAndroidUnitId => 'ca-app-pub-7813571864928265/8473016033';

  @override
  String get interstitialBannerAndroidUnitId => 'ca-app-pub-7813571864928265/7086910030';

  @override
  String get interstitialBannerIOSUnitId => '';

  @override
  String get bannerIOSUnitId => '';

  @override
  int get interstitialBannerShowingPeriod => 2;
}

class DevFlavour extends Flavor  {
  const DevFlavour();

  @override
  String get baseUrl => 'https://api.bountyhub.io/api';

  @override
  String get bannerAndroidUnitId => BannerAd.testAdUnitId;

  @override
  String get bannerIOSUnitId => BannerAd.testAdUnitId;

  @override
  String get interstitialBannerAndroidUnitId => InterstitialAd.testAdUnitId;

  @override
  String get interstitialBannerIOSUnitId => InterstitialAd.testAdUnitId;

  @override
  int get interstitialBannerShowingPeriod => 2;
}


