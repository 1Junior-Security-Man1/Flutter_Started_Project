
import 'preferences_local_repository.dart';

class LocaleRepository {

  static LocaleRepository _instance;

  LocaleRepository._internal();

  factory LocaleRepository() {
    _instance ??= LocaleRepository._internal();
    return _instance;
  }

  String get locale => PreferencesLocalProvider().locale;

  set locale(String value) => PreferencesLocalProvider().locale = value;

  String get language => (locale??('de_DE')).split('_')[0];

  String get country => (locale??('de_DE')).split('_')[1];

  void setLanguage({String languageCode, String countryCode}) =>
      locale = '${languageCode}_$countryCode';

}
