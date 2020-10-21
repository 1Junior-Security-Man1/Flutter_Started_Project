import 'package:bounty_hub_client/data/repositories/login_repository.dart';
import 'package:bounty_hub_client/data/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app.dart';
import 'bloc/authentication_event.dart';
import 'bloc/authorization_bloc.dart';
import 'network/server_api.dart';
import 'ui/pages/login/login_cubit.dart';

void main() {
  final RestClient client = RestClient();

  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (context) => AuthenticationBloc(UserRepository())..add(AppStarted())),
    BlocProvider(create: (context) => LoginCubit(LoginRepository(client), UserRepository())),
    // provide other blocs & cubits here
  ], child: MyApp()));
}