import 'package:bounty_hub_client/data/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app.dart';
import 'bloc/authentication_event.dart';
import 'bloc/authorization_bloc.dart';

void main() {
  //final RestClient restClient = RestClient();
  //final authenticationRepository = AuthenticationRepository(restClient);
  final userRepository = UserRepository();

  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (context) => AuthenticationBloc(userRepository)..add(AppStarted())),
  ], child: MyApp(userRepository: userRepository)));
}