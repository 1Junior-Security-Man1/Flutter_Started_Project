import 'package:bounty_hub_client/utils/flavors.dart';
import 'package:bounty_hub_client/utils/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app.dart';
import 'network/server_api.dart';

void main() {
  Flavor flavor = ProdFlavour();
  final RestClient client = RestClient();

  runApp(MultiRepositoryProvider(
      providers: getRepositories(client),
      child: MultiBlocProvider(
          providers: getProviders(client), child: App(flavor))));
  appConfig();
}

void appConfig() {
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
}
