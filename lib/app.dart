import 'package:flutter_starter/bloc/auth/authorization_state.dart';
import 'package:flutter_starter/ui/pages/authorization/authorization_page.dart';
import 'package:flutter_starter/ui/pages/main/main_page.dart';
import 'package:flutter_starter/ui/pages/splash/splash_page.dart';
import 'package:flutter_starter/utils/ui/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'bloc/auth/authorization_bloc.dart';
import 'utils/flavors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

Flavor? _currentFlavour;
Flavor get currentFlavour => _currentFlavour!;

class App extends StatefulWidget {
  App(Flavor flavour) : super() {
    _currentFlavour = flavour;
  }

  @override
  AppState createState() => AppState();
  static final GlobalKey<NavigatorState> globalNavigatorKey = GlobalKey<NavigatorState>();
}

class AppState extends State<App> {
  static BuildContext? _context;
  static String? buildVersion;

  @override
  void initState() {
    getApplicationSupportDirectory().then((value) => Hive.init(value.path));
    super.initState();
    _context = context;
  }

  Future _initialize() async {
    await Firebase.initializeApp();
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  }

  static BuildContext getContext() {
    return _context!;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialize(),
      builder: (context, snapshot) {
        return BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
              return MaterialApp(
                  navigatorKey: App.globalNavigatorKey,
                  title: 'Flutter app',
                  theme: ThemeData(
                    fontFamily: 'Montserrat',
                    primaryColor: AppColors.primaryColor,
                    colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.lightBlue).copyWith(secondary: AppColors.accentColor),
                  ),
                  home: navigateToHomeWidget(state));
          },
        );
      },
    );
  }

  Widget navigateToHomeWidget(AuthenticationState state) {
    switch (state.status) {
      case AuthenticationStatus.loading:
        return SplashPage();
      case AuthenticationStatus.authenticated:
        return MainPage();
      case AuthenticationStatus.unauthenticated:
        return AuthorizationPage();
      default:
        return AuthorizationPage();
    }
  }
}