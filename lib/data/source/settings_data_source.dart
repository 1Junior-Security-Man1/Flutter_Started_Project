import 'package:flutter_starter/data/enums/app_types.dart';

abstract class SettingsDataSource {
  AppType getAppMode();
}