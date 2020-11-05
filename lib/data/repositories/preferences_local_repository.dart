import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class PreferencesLocalProvider {
  static const _language_code_key = 'language_code_key';


  SharedPreferences prefs;

  static PreferencesLocalProvider _instance;

  factory PreferencesLocalProvider() {
    _instance ??= PreferencesLocalProvider._internal();
    return _instance;
  }

  PreferencesLocalProvider._internal();

  Future<void> initPref() async {
    prefs ??= await SharedPreferences.getInstance();
  }

  // LANGUAGE_CODE
  String get locale => prefs.getString(_language_code_key) ;

  set locale(String locale) => prefs.setString(_language_code_key, locale);
}
