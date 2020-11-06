import 'package:bounty_hub_client/data/repositories/campaigns_repository.dart';
import 'package:bounty_hub_client/data/repositories/login_repository.dart';
import 'package:bounty_hub_client/data/repositories/profile_repository.dart';
import 'package:bounty_hub_client/data/repositories/tasks_repository.dart';
import 'package:bounty_hub_client/data/repositories/user_repository.dart';
import 'package:bounty_hub_client/utils/localization/bloc/locale_bloc.dart';
import 'package:bounty_hub_client/ui/pages/profile/cubit/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app.dart';
import 'bloc/auth/authentication_event.dart';
import 'bloc/auth/authorization_bloc.dart';
import 'bloc/authentication_event.dart';
import 'bloc/authorization_bloc.dart';
import 'data/repositories/profile_local_repository.dart';
import 'network/server_api.dart';

void main() {
  final RestClient client = RestClient();

  runApp(MultiRepositoryProvider(
      providers: [
        // provide repositories here
        RepositoryProvider<UserRepository>(
            create: (context) => UserRepository()),
        RepositoryProvider<CampaignRepository>(
            create: (context) => CampaignRepository(client)),
        RepositoryProvider<LoginRepository>(
            create: (context) => LoginRepository(client)),
        RepositoryProvider<TaskRepository>(
            create: (context) => TaskRepository(client)),
        RepositoryProvider<ProfileRepository>(
            create: (context) => ProfileRepository(client)),
        RepositoryProvider<ProfileLocalRepository>(
            create: (context) => ProfileLocalRepository()),
      ],
      child: MultiBlocProvider(providers: [
        BlocProvider(
            create: (context) =>
                AuthenticationBloc(UserRepository())..add(AppStarted())),
        BlocProvider(
            create: (context) => ProfileCubit(
                ProfileRepository(client), ProfileLocalRepository())),
        BlocProvider(create: (context) => LocaleBloc()),

        // provide App blocs here
      ], child: App())));
  appConfig();
}

void appConfig() {
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
}