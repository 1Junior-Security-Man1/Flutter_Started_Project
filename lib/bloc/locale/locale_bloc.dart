import 'package:bounty_hub_client/bloc/locale/locale_event.dart';
import 'package:bounty_hub_client/data/repositories/locale_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocaleBloc extends Bloc<LocaleEvent, Locale> {
  LocaleBloc() : super(const Locale('en', 'EN'));
  static Locale locale = Locale('en', 'EN');

  static Map<Locale, String> localeName = {
    Locale.fromSubtags(countryCode: 'DE', languageCode: 'de'): 'Germany',
    Locale.fromSubtags(countryCode: 'RU', languageCode: 'ru'): 'Russian',
    Locale.fromSubtags(countryCode: 'US', languageCode: 'en'): 'English',
  };

  @override
  Stream<Locale> mapEventToState(LocaleEvent event) async* {
    if (event is ChangeLocaleEvent) {
      LocaleRepository().setLanguage(
          languageCode: event.languageCode, countryCode: event.countryCode);
      var locale = Locale(event.languageCode, event.countryCode);
      LocaleBloc.locale = locale;
      try {
        //todo set language API
      } catch (e) {
        //
      }
      yield locale;
    }

    if (event is LoadSavedLocale) {
      yield _fetchLocale();
    }
  }

  Locale _fetchLocale() {
    if (LocaleRepository().language == null) {
      return const Locale('en', 'EN');
    }
    locale = Locale(
        LocaleRepository().language, LocaleRepository().language.toUpperCase());
    return locale;
  }
}
