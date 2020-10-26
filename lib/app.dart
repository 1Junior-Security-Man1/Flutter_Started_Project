import 'package:bounty_hub_client/bloc/authorization_bloc.dart';
import 'package:bounty_hub_client/bloc/authorization_state.dart';
import 'package:bounty_hub_client/ui/pages/splash/view/splash_page.dart';
import 'package:bounty_hub_client/utils/localization/app_localizations.dart';
import 'package:bounty_hub_client/utils/ui/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class App extends StatefulWidget {

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BountyHub',
      theme: ThemeData(
        fontFamily: 'Montserrat',
        primarySwatch: Colors.lightBlue,
        primaryColor: AppColors.primaryColor,
        accentColor: AppColors.accentColor,
      ),
      supportedLocales: [
        Locale('en', 'US'),
      ],
      localizationsDelegates: [
        Strings.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale.languageCode &&
              supportedLocale.countryCode == locale.countryCode) {
            return supportedLocale;
          }
        }
        return supportedLocales.first;
      },
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          return SplashPage(state is Authenticated);
        },
      ),
    );
  }
}