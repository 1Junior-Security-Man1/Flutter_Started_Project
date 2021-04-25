import 'package:flutter_starter/bloc/auth/authentication_event.dart';
import 'package:flutter_starter/bloc/auth/authorization_bloc.dart';
import 'package:flutter_starter/data/repositories/auth_repository.dart';
import 'package:flutter_starter/data/repositories/profile_repository.dart';
import 'package:flutter_starter/data/repositories/user_repository.dart';
import 'package:flutter_starter/network/server_api.dart';
import 'package:flutter_starter/ui/pages/main/cubit/main_cubit.dart';
import 'package:flutter_starter/ui/pages/splash/cubit/splash_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_starter/ui/pages/authorization/cubit/authorization_cubit.dart';

getRepositories(RestClient client) {
  return [
    RepositoryProvider<UserRepository>(create: (context) => UserRepository(client)),
    RepositoryProvider<AuthRepository>(create: (context) => AuthRepository(client)),
    RepositoryProvider<ProfileRepository>(create: (context) => ProfileRepository(client)),
  ];
}

getProviders(RestClient client) {
  return [
    BlocProvider(create: (context) => AuthorizationCubit(AuthRepository(client), UserRepository(client))),
    BlocProvider(create: (context) => AuthenticationBloc(UserRepository(client))..add(AppStarted())),
    BlocProvider(create: (context) => MainCubit()),
    BlocProvider(create: (context) => SplashCubit()),
  ];
}
