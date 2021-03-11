import 'package:bounty_hub_client/data/enums/app_types.dart';

abstract class SettingsDataSource {
  AppType getAppMode();
}