import 'package:bounty_hub_client/ui/pages/login/view/login_page.dart';
import 'package:bounty_hub_client/ui/pages/splash/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/authorization_bloc.dart';
import 'bloc/authorization_state.dart';
import 'data/repositories/user_repository.dart';

class MyApp extends StatefulWidget {

  final UserRepository _userRepository;

  MyApp({Key key, UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  UserRepository get userRepository => widget._userRepository;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BountyHub',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        primaryColor: Color(0xff39b2f0),
        accentColor: Colors.grey[800],
      ),
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is Uninitialized) {
            return SplashPage();
          } else if (state is Unauthenticated) {
            return LoginPage(
              userRepository: userRepository,
            );
          } else if (state is Authenticated) {
            return SplashPage();
          } else {
            return SplashPage();
          }
        },
      ),
    );
  }
}