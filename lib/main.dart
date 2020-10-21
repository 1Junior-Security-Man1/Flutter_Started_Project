import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app.dart';
import 'bloc/authentication_event.dart';
import 'bloc/authorization_bloc.dart';
import 'network/server_api.dart';
import 'ui/pages/login/login_cubit.dart';

void main() {

  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (context) => AuthenticationBloc()..add(AppStarted())),
    BlocProvider(create: (context) => LoginCubit()),
  ], child: MyApp()));
}