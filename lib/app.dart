import 'package:bounty_hub_client/bloc/auth/authentication_event.dart';
import 'package:bounty_hub_client/bloc/auth/authorization_state.dart';
import 'package:bounty_hub_client/bloc/locale/locale_bloc.dart';
import 'package:bounty_hub_client/bloc/locale/locale_event.dart';
import 'package:bounty_hub_client/data/remote_app_data.dart';
import 'package:bounty_hub_client/ui/pages/authorization/authorization_page.dart';
import 'package:bounty_hub_client/ui/pages/main/main_page.dart';
import 'package:bounty_hub_client/ui/pages/splash/splash_page.dart';
import 'package:bounty_hub_client/ui/pages/welcome/weclome_page.dart';
import 'package:bounty_hub_client/utils/locator.dart';
import 'package:bounty_hub_client/utils/ui/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart' as intl;
import 'package:package_info/package_info.dart';
import 'package:path_provider/path_provider.dart';
import 'bloc/auth/authorization_bloc.dart';
import 'data/repositories/preferences_local_repository.dart';
import 'utils/flavors.dart';
import 'utils/localization/localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:advertising_id/advertising_id.dart';

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

  RemoteAppData _remoteAppData = locator<RemoteAppData>();

  static BuildContext _context;

  static String buildVersion;

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
  }

  Future<void> _initialize() async {
    await Firebase.initializeApp();
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
    await _remoteAppData.initialize();
    await MobileAds.instance.initialize();
    await PackageInfo.fromPlatform().then((packageInfo) => buildVersion = packageInfo.version);
    print('Deice AdvertisingId for AdMob testing ' + await AdvertisingId.id);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialize(),
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
                    home: navigateToHomeWidget(context, state)
                );
              },
            );
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
        return hasDeepLinkData(state) ? AuthorizationPage(email: state.deepLinkEmail, confirmCode: state.deepLinkConfirmCode) : WelcomePage();
      case AuthenticationStatus.selectAuthentication:
        return getAuthenticatedRoute(state.authenticationType);
      default: {
        return WelcomePage();
      }
    }
  }

  bool hasDeepLinkData(AuthenticationState state) {
    return state.deepLinkConfirmCode != null
        && state.deepLinkConfirmCode.isNotEmpty
        && state.deepLinkEmail != null
        && state.deepLinkEmail.isNotEmpty;
  }

  Widget getAuthenticatedRoute(AuthenticationType type) {
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
