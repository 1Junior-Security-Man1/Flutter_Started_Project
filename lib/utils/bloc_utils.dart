import 'package:bounty_hub_client/data/remote_app_data.dart';
import 'package:bounty_hub_client/data/enums/app_types.dart';
import 'package:bounty_hub_client/utils/locator.dart';

// TODO hardcode solution. Block does not respond to the change of the enum values like ui/pages/authorization/cubit/authorization_state.dart:3 - like AuthorizationStatus etc.
int generateSignature() {
  return DateTime.now().millisecondsSinceEpoch;
}

// Method gets the value of the application mode from firebase remote config,
// this is needed for hide some UI components, for approval in the Apple Store Connect
bool isDefaultMode() {
  return locator<RemoteAppData>().appType == AppType.DEFAULT;
}