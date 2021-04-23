import 'package:flutter_starter/data/enums/response_error_types.dart';
import 'package:flutter_starter/utils/localization/localization.res.dart';

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

  if(responseMessage.contains('You must connect one of these social networks') || (responseMessage.contains('Social account for') && responseMessage.contains('not set'))) {
    return ServerErrorType.NO_SOCIAL_NETWORKS_ADDED_ERROR;
  } else if(responseMessage.contains('Please wait for the time to complete')) {
    return ServerErrorType.WAIT_TIME_TO_COMPLETE;
  } else if(responseMessage.contains('Verification code') && responseMessage.contains('not found')) {
    return ServerErrorType.VERIFICATION_CODE_NOT_FOUND;
  }  else {
    return ServerErrorType.UNKNOWN;
  }
}

String getErrorMessage(ServerErrorType errorType) {
  switch(errorType) {
    case ServerErrorType.NO_SOCIAL_NETWORKS_ADDED_ERROR:
      return AppStrings.serverErrorNoSocialNetworksAdded;
    case ServerErrorType.WAIT_TIME_TO_COMPLETE:
      return AppStrings.serverErrorWaitTimeToComplete;
    case ServerErrorType.VERIFICATION_CODE_NOT_FOUND:
      return AppStrings.serverErrorCodeNotFound;
      default:
        return AppStrings.defaultErrorMessage;
  }
}