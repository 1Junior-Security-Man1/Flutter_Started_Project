import 'package:bounty_hub_client/data/remote_app_data.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

Future setupLocator() async  {
  locator.registerSingleton(await RemoteAppData.getInstance());
}