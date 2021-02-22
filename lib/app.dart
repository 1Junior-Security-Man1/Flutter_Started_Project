import 'package:bounty_hub_client/bloc/auth/authentication_event.dart';
import 'package:bounty_hub_client/bloc/auth/authorization_state.dart';
import 'package:bounty_hub_client/bloc/locale/locale_bloc.dart';
import 'package:bounty_hub_client/bloc/locale/locale_event.dart';
import 'package:bounty_hub_client/ui/pages/authorization/authorization_page.dart';
import 'package:bounty_hub_client/ui/pages/main/main_page.dart';
import 'package:bounty_hub_client/ui/pages/splash/splash_page.dart';
import 'package:bounty_hub_client/ui/pages/welcome/weclome_page.dart';
import 'package:bounty_hub_client/utils/ui/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart' as intl;
import 'package:path_provider/path_provider.dart';
import 'bloc/auth/authorization_bloc.dart';
import 'data/repositories/preferences_local_repository.dart';
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

  static final GlobalKey<NavigatorState> globalNavigatorKey = GlobalKey<NavigatorState>();
}

class AppState extends State<App> {

  Future<void> _initializeFlutterFireFuture;
  static BuildContext _context;

  final List<LocalizationsDelegate<dynamic>> localizationsDelegates = const [
    AppLocalizationsDelegate(),
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  final List<String> _supportedDateFormat = AppLocalizations.languages.keys
      .toList()
      .map((locale) => locale.languageCode)
      .toList();

  @override
  void initState() {
    getApplicationSupportDirectory().then((value) => Hive.init(value.path));
    super.initState();
    _context = context;
    _initializeFlutterFireFuture = _initializeFlutterFire();
  }

  Future<void> _initializeFlutterFire() async {
    await Firebase.initializeApp();
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeFlutterFireFuture,
      builder: (context, snapshot) {
        return BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            return BlocBuilder<LocaleBloc, Locale>(
              builder: (context, locale) {
                intl.Intl.defaultLocale = locale.languageCode;
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                    navigatorKey: App.globalNavigatorKey,
                    title: 'BountyHub',
                    theme: ThemeData(
                      fontFamily: 'Montserrat',
                      primarySwatch: Colors.lightBlue,
                      primaryColor: AppColors.primaryColor,
                      accentColor: AppColors.accentColor,
                      canvasColor: Colors.transparent,
                    ),
                    localeResolutionCallback: (deviceLocale,
                        supportedLocales) =>
                        _localeResolutionCallback(
                            deviceLocale, supportedLocales, locale, context),
                    locale: locale,
                    localizationsDelegates: localizationsDelegates,
                    supportedLocales: AppLocalizations.languages.keys.toList(),
                    home: navigateToHomeRoute(context, state.authenticationType, state.status)
                );
              },
            );
          },
        );
      },
    );
  }

  Widget navigateToHomeRoute(BuildContext context, AuthenticationType authenticationType, AuthenticationStatus status) {
    switch (status) {
      case AuthenticationStatus.loading:
        return SplashPage();
      case AuthenticationStatus.authenticated:
        return MainPage();
      case AuthenticationStatus.unauthenticated:
        return WelcomePage();
      case AuthenticationStatus.selectAuthentication:
        return getAuthenticationDirection(authenticationType);
      default: {
        return WelcomePage();
      }
    }
  }

  Widget getAuthenticationDirection(AuthenticationType type) {
    switch (type) {
      case AuthenticationType.credentials:
        return AuthorizationPage();
      case AuthenticationType.guest:
        return MainPage();
      default: {
        return WelcomePage();
      }
    }
  }

  static BuildContext getContext() {
    return _context;
  }

  Locale _localeResolutionCallback(
      Locale deviceLocale,
      Iterable<Locale> supportedLocales,
      Locale snapshot,
      BuildContext context) {
    PreferencesLocalProvider().initPref().then((_) {
      if (PreferencesLocalProvider().locale == null) {
        if (AppLocalizations.languages.keys.contains(Locale.fromSubtags(languageCode: deviceLocale.languageCode.toUpperCase()))) {

          BlocProvider.of<LocaleBloc>(context).add(ChangeLocaleEvent(
              languageCode: deviceLocale.languageCode,
              countryCode: deviceLocale.countryCode));
        }
      }
    });

    var locale = deviceLocale;
    if (snapshot != null) {
      locale = snapshot;
    } else {
      locale = deviceLocale;
    }

    if (_supportedDateFormat.contains(locale.languageCode)) {
      intl.Intl.defaultLocale = locale.languageCode;
    } else {
      intl.Intl.defaultLocale = _supportedDateFormat[0];
    }

    return locale;
  }
}
