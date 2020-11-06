import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_sheet_localization/flutter_sheet_localization.dart';

part 'localization.g.dart';

@SheetLocalization('1bwmAHBjxtnrPIZ9pRTC7ooTUnkiceK_lapKXILvcDyE',
    '0')
class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => true;

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(AppLocalizations(
        Locale.fromSubtags(languageCode: locale.languageCode.toUpperCase())));
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => true;
}

