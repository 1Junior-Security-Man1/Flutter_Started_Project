import 'package:bounty_hub_client/utils/flavors.dart';
import 'package:bounty_hub_client/utils/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'app.dart';
import 'network/server_api.dart';

void main() {
  Flavor flavor = DevFlavour();
  final RestClient client = RestClient(baseUrl: flavor.baseUrl);

  WidgetsFlutterBinding.ensureInitialized();
  runZonedGuarded(() {
    runApp(MultiRepositoryProvider(
        providers: getRepositories(client),
        child: MultiBlocProvider(providers: getProviders(client), child: App(flavor))));
  }, (error, stackTrace) {
    print('runZonedGuarded: Caught error in my root zone.');
    FirebaseCrashlytics.instance.recordError(error, stackTrace);
  });
  appConfig();
}

void appConfig() {
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
}
