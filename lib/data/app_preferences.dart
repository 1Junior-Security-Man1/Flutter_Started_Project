import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  SharedPreferences? prefs;
  static AppPreferences? _instance;

  factory AppPreferences() {
    _instance ??= AppPreferences._internal();
    return _instance!;
  }

  AppPreferences._internal();
  Future<AppPreferences> init() async {
    prefs ??= await SharedPreferences.getInstance();
    return _instance!;
  }

  String get locale => prefs!.getString('LANGUAGE_CODE')!;
  set locale(String locale) => prefs!.setString('LANGUAGE_CODE', locale);
}