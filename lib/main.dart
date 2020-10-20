import 'package:bounty_hub_client/data/repositories/authentication_repository.dart';
import 'package:bounty_hub_client/data/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app.dart';
import 'bloc/authentication_event.dart';
import 'bloc/authorization_bloc.dart';
import 'network/server_api.dart';

void main() {
  final RestClient restClient = RestClient();
  final userRepository = UserRepository();
  final loginRepository = LoginRepository(restClient);

  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (context) => AuthenticationBloc(userRepository)..add(AppStarted())),
  ], child: MyApp(userRepository: userRepository, loginRepository: loginRepository)));
}