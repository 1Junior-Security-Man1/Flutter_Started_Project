import 'package:flutter_starter/data/app_preferences.dart';

class LocaleRepository {
  String get locale => AppPreferences().locale;

  set locale(String value) => AppPreferences().locale = value;

  String get language => (locale ?? ('de_DE')).split('_')[0];

  String get country => (locale ?? ('de_DE')).split('_')[1];

  void setLanguage({String languageCode, String countryCode}) =>
      locale = '${languageCode}_$countryCode';
}
