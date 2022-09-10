import 'package:flutter_starter/utils/flavors.dart';
import 'package:flutter_starter/utils/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'app.dart';
import 'network/server_api.dart';

Future main() async {
  Flavor flavor = ProdFlavour();
  final RestClient client = RestClient(baseUrl: flavor.baseUrl);

  WidgetsFlutterBinding.ensureInitialized();
  runZonedGuarded(() {
    runApp(MultiRepositoryProvider(
        providers: getRepositories(client),
        child: MultiBlocProvider(providers: getProviders(client), child: App(flavor))));
  }, (error, stackTrace) {
    FirebaseCrashlytics.instance.recordError(error, stackTrace);
  });
  appConfig();
}

void appConfig() {
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
}