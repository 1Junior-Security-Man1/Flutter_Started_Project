// import 'package:flutter/foundation.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
// import 'package:flutter_sheet_localization/flutter_sheet_localization.dart';
// import 'package:flutter_starter/bloc/locale/locale_bloc.dart';
// import 'package:flutter_starter/bloc/locale/locale_event.dart';
// import 'package:flutter_starter/data/app_preferences.dart';
// import 'package:intl/intl.dart' as intl;
//
// part 'localization.g.dart';
//
// @SheetLocalization('1bwmAHBjxtnrPIZ9pRTC7ooTUnkiceK_lapKXILvcDyE', '0')
// class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
//   const AppLocalizationsDelegate();
//
//   @override
//   bool isSupported(Locale locale) => true;
//
//   @override
//   Future<AppLocalizations> load(Locale locale) {
//     return SynchronousFuture<AppLocalizations>(AppLocalizations(
//         Locale.fromSubtags(languageCode: locale.languageCode.toUpperCase())));
//   }
//
//   @override
//   bool shouldReload(AppLocalizationsDelegate old) => true;
// }
//
// final List<LocalizationsDelegate<dynamic>> localizationsDelegates = const [
//   AppLocalizationsDelegate(),
//   GlobalMaterialLocalizations.delegate,
//   GlobalCupertinoLocalizations.delegate,
//   GlobalWidgetsLocalizations.delegate,
// ];
//
// Locale localeResolutionCallback(Locale deviceLocale, Iterable<Locale> supportedLocales, Locale snapshot, BuildContext context) {
//   AppPreferences().init().then((prefs) {
//     if (prefs.locale == null) {
//       if (AppLocalizations.languages.keys.contains(Locale.fromSubtags(
//           languageCode: deviceLocale.languageCode.toUpperCase()))) {
//         BlocProvider.of<LocaleBloc>(context).add(ChangeLocaleEvent(
//             languageCode: deviceLocale.languageCode,
//             countryCode: deviceLocale.countryCode));
//       }
//     }
//   });
//
//   var locale = deviceLocale;
//   if (snapshot != null) {
//     locale = snapshot;
//   } else {
//     locale = deviceLocale;
//   }
//
//   final List<String> _supportedLanguages = AppLocalizations.languages.keys
//       .toList()
//       .map((locale) => locale.languageCode)
//       .toList();
//
//   if (_supportedLanguages.contains(locale.languageCode)) {
//     intl.Intl.defaultLocale = locale.languageCode;
//   } else {
//     intl.Intl.defaultLocale = _supportedLanguages[0];
//   }
//
//   return locale;
// }
//
