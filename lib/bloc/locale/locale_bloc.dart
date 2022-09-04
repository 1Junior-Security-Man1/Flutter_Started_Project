import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_starter/bloc/locale/locale_event.dart';
import 'package:flutter_starter/data/repositories/locale_repository.dart';

class LocaleBloc extends Bloc<LocaleEvent, Locale> {
  final LocaleRepository _localeRepository;

  LocaleBloc(this._localeRepository) : super(const Locale('en', 'EN'));

  static Locale locale = Locale('en', 'EN');

  static Map<Locale, String> localeName = {
    Locale.fromSubtags(countryCode: 'DE', languageCode: 'de'): 'Germany',
    Locale.fromSubtags(countryCode: 'RU', languageCode: 'ru'): 'Russian',
    Locale.fromSubtags(countryCode: 'US', languageCode: 'en'): 'English',
  };

  @override
  Stream<Locale> mapEventToState(LocaleEvent event) async* {
    if (event is ChangeLocaleEvent) {
      _localeRepository.setLanguage(
          languageCode: event.languageCode, countryCode: event.countryCode);
      var locale = Locale(event.languageCode!, event.countryCode);
      LocaleBloc.locale = locale;
      yield locale;
    }

    if (event is LoadSavedLocale) {
      yield _fetchLocale();
    }
  }

  Locale _fetchLocale() {
    if (_localeRepository.language == null) {
      return const Locale('en', 'EN');
    }
    locale = Locale(
        _localeRepository.language, _localeRepository.language.toUpperCase());
    return locale;
  }
}
