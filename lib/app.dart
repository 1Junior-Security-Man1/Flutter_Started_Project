import 'package:bounty_hub_client/bloc/auth/authorization_state.dart';
import 'package:bounty_hub_client/ui/pages/splash/splash_page.dart';
import 'package:bounty_hub_client/utils/ui/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart' as intl;
import 'package:path_provider/path_provider.dart';
import 'bloc/auth/authorization_bloc.dart';
import 'data/repositories/preferences_local_repository.dart';
import 'utils/localization/bloc/locale_bloc.dart';
import 'utils/localization/bloc/locale_event.dart';
import 'utils/localization/localization.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();

  static final GlobalKey<NavigatorState> globalNavigatorKey =
      GlobalKey<NavigatorState>();
}

class _AppState extends State<App> {
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
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleBloc, Locale>(
      builder: (context, locale) {
        intl.Intl.defaultLocale = locale.languageCode;
        return MaterialApp(
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
                  deviceLocale, supportedLocales, locale, context),
          localizationsDelegates: localizationsDelegates,
          supportedLocales: AppLocalizations.languages.keys.toList(),
          home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
              return SplashPage(state is Authenticated);
            },
          ),
        );
      },
    );
  }

  Locale _localeResolutionCallback(
      Locale deviceLocale,
      Iterable<Locale> supportedLocales,
      Locale snapshot,
      BuildContext context) {
    PreferencesLocalProvider().initPref().then((_) {
      if (PreferencesLocalProvider().locale == null) {
        print(deviceLocale);
        if (AppLocalizations.languages.keys.contains(Locale.fromSubtags(
            languageCode: deviceLocale.languageCode.toUpperCase()))) {
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
