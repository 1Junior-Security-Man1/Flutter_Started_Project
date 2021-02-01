abstract class Flavor{
  const Flavor();

  String get baseUrl => '';

  String get oneSignalKey => '';

  bool get isProxyEnabled => false;

  bool get showBugBtn => false;
}

// Production environment flavour
class ProdFlavour extends Flavor {
  const ProdFlavour();

@override
  String get baseUrl => 'https://api.bountyhub.io/api';
}

class DevFlavour extends Flavor  {
  const DevFlavour();

  @override
  String get baseUrl => 'https://api-dev.bountyhub.io/api';
}


