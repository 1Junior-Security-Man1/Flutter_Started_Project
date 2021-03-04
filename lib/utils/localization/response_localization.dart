import 'package:bounty_hub_client/data/enums/response_error_types.dart';
import 'package:bounty_hub_client/utils/localization/localization.res.dart';

/// The backend does not have error classification, so that it
/// would be possible to identify the error type and return a localized translation
/// this methods is used.
String getLocalizedMessage(String responseMessage) {
  return getErrorMessage(getServerErrorType(responseMessage));
}

ServerErrorType getServerErrorType(String responseMessage) {
  if(responseMessage == null) {
    return ServerErrorType.UNKNOWN;
  }

  if(responseMessage.contains('You must connect one of these social networks')) {
    return ServerErrorType.NO_SOCIAL_NETWORKS_ADDED_ERROR;
   } else {
    return ServerErrorType.UNKNOWN;
  }
}

String getErrorMessage(ServerErrorType errorType) {
  switch(errorType) {
    case ServerErrorType.NO_SOCIAL_NETWORKS_ADDED_ERROR:
      return AppStrings.serverErrorNoSocialNetworksAdded;
      default:
        return AppStrings.defaultErrorMessage;
  }
}
