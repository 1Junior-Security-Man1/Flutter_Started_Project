import 'package:flutter_starter/bloc/auth/authentication_event.dart';
import 'package:flutter_starter/bloc/auth/authorization_state.dart';
import 'package:flutter_starter/ui/pages/authorization/authorization_page.dart';
import 'package:flutter_starter/ui/pages/main/main_page.dart';
import 'package:flutter_starter/ui/pages/splash/splash_page.dart';
import 'package:flutter_starter/utils/ui/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'bloc/auth/authorization_bloc.dart';
import 'utils/flavors.dart';
import 'utils/localization/localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

Flavor _currentFlavour;

Flavor get currentFlavour => _currentFlavour;

class App extends StatefulWidget {
  App(
    Flavor flavour,
  )   : assert(flavour != null),
        super() {
    _currentFlavour = flavour;
  }

  @override
  AppState createState() => AppState();

  static final GlobalKey<NavigatorState> globalNavigatorKey =
      GlobalKey<NavigatorState>();
}

class AppState extends State<App> {
  static BuildContext _context;

  static String buildVersion;

  @override
  void initState() {
    getApplicationSupportDirectory().then((value) => Hive.init(value.path));
    super.initState();
    _context = context;
  }

  Future<void> _initialize() async {
    await Firebase.initializeApp();
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
    await MobileAds.instance.initialize();
  }

  static BuildContext getContext() {
    return _context;
  }

  final List<LocalizationsDelegate<dynamic>> localizationsDelegates = const [
    AppLocalizationsDelegate(),
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  Locale _localeResolutionCallback(Locale deviceLocale,
      Iterable<Locale> supportedLocales, BuildContext context) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == deviceLocale.languageCode &&
          supportedLocale.countryCode == deviceLocale.countryCode) {
        return supportedLocale;
      }
    }
    return supportedLocales.first;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialize(),
      builder: (context, snapshot) {
        return BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            return MaterialApp(
                debugShowCheckedModeBanner: false,
                navigatorKey: App.globalNavigatorKey,
                title: 'BountyHub',
                theme: ThemeData(
                  fontFamily: 'Montserrat',
                  primarySwatch: Colors.lightBlue,
                  primaryColor: AppColors.primaryColor,
                  accentColor: AppColors.accentColor,
                ),
                localeResolutionCallback: (deviceLocale, supportedLocales) =>
                    _localeResolutionCallback(
                        deviceLocale, supportedLocales, context),
                localizationsDelegates: localizationsDelegates,
                supportedLocales: AppLocalizations.languages.keys.toList(),
                home: navigateToHomeWidget(context, state));
          },
        );
      },
    );
  }

  Widget navigateToHomeWidget(BuildContext context, AuthenticationState state) {
    switch (state.status) {
      case AuthenticationStatus.loading:
        return SplashPage();
      case AuthenticationStatus.authenticated:
        return MainPage();
      case AuthenticationStatus.unauthenticated:
        return AuthorizationPage();
      case AuthenticationStatus.selectAuthentication:
        return getAuthenticatedRoute(state.authenticationType);
      default:
        {
          return AuthorizationPage();
        }
    }
  }

  Widget getAuthenticatedRoute(AuthenticationType type) {
    switch (type) {
      case AuthenticationType.credentials:
        return AuthorizationPage();
      case AuthenticationType.guest:
        return MainPage();
      default:
        {
          return AuthorizationPage();
        }
    }
  }
}
