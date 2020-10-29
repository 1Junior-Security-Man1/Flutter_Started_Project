import 'package:bounty_hub_client/data/repositories/campaigns_repository.dart';
import 'package:bounty_hub_client/data/repositories/login_repository.dart';
import 'package:bounty_hub_client/data/repositories/tasks_repository.dart';
import 'package:bounty_hub_client/data/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app.dart';
import 'bloc/authentication_event.dart';
import 'bloc/authorization_bloc.dart';
import 'network/server_api.dart';

void main() {
  final RestClient client = RestClient();

  runApp(MultiRepositoryProvider(providers: [
    // provide repositories here
    RepositoryProvider<UserRepository>(create: (context) => UserRepository()),
    RepositoryProvider<CampaignRepository>(create: (context) => CampaignRepository(client)),
    RepositoryProvider<LoginRepository>(create: (context) => LoginRepository(client)),
    RepositoryProvider<TaskRepository>(create: (context) => TaskRepository(client)),

  ], child: MultiBlocProvider(providers: [
    BlocProvider(create: (context) => AuthenticationBloc(UserRepository())..add(AppStarted())),
    // provide App blocs here
  ], child: App())));
  appConfig();
}

void appConfig() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitDown,DeviceOrientation.portraitUp]);
}