import 'package:bounty_hub_client/data/repositories/campaigns_repository.dart';
import 'package:bounty_hub_client/data/repositories/login_repository.dart';
import 'package:bounty_hub_client/data/repositories/user_repository.dart';
import 'package:bounty_hub_client/ui/pages/campaigns/campaigns_cubit.dart';
import 'package:bounty_hub_client/ui/pages/splash/splash_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app.dart';
import 'bloc/authentication_event.dart';
import 'bloc/authorization_bloc.dart';
import 'network/server_api.dart';
import 'ui/pages/login/login_cubit.dart';

void main() {
  final RestClient client = RestClient();
  final UserRepository userRepository = UserRepository();
  final CampaignRepository campaignRepository = CampaignRepository(client);
  final LoginRepository loginRepository = LoginRepository(client);

  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (context) => SplashCubit()),
    BlocProvider(create: (context) => LoginCubit(loginRepository, userRepository)),
    BlocProvider(create: (context) => CampaignCubit(campaignRepository)),
    BlocProvider(create: (context) => AuthenticationBloc(userRepository)..add(AppStarted())),
    // provide other blocs & cubits here
  ], child: App()));
  appConfig();
}

void appConfig() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitDown,DeviceOrientation.portraitUp]);
}