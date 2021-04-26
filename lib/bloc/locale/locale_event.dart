import 'package:flutter/material.dart';

abstract class LocaleEvent {}

class ChangeLocaleEvent extends LocaleEvent {
  String languageCode;
  String countryCode;

  ChangeLocaleEvent({@required this.languageCode, @required this.countryCode});
}

class LoadSavedLocale extends LocaleEvent {}
