import 'package:google_mobile_ads/google_mobile_ads.dart';

abstract class Flavor{
  const Flavor();

  String get baseUrl => '';

  String get oneSignalKey => '';

  bool get isProxyEnabled => false;

  bool get showBugBtn => false;

  String get bannerAndroidUnitId => '';

  String get bannerIOSUnitId => '';
}

// Production environment flavour
class ProdFlavour extends Flavor {
  const ProdFlavour();

  @override
  String get baseUrl => 'https://api.bountyhub.io/api';

  @override
  String get bannerAndroidUnitId => 'ca-app-pub-7813571864928265/8473016033';

  @override
  String get bannerIOSUnitId => '';
}

class DevFlavour extends Flavor  {
  const DevFlavour();

  @override
  String get baseUrl => 'https://api.bountyhub.io/api';

  @override
  String get bannerAndroidUnitId => BannerAd.testAdUnitId;

  @override
  String get bannerIOSUnitId => BannerAd.testAdUnitId;
}


