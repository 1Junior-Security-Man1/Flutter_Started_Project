// TODO hardcode solution. Block does not respond to the change of the enum values
//  like ui/pages/authorization/cubit/authorization_state.dart:3 - like AuthorizationStatus enum.
int generateSignature() {
  return DateTime.now().millisecondsSinceEpoch;
}