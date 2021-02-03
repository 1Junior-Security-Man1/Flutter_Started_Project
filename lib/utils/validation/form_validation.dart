import 'package:bounty_hub_client/ui/pages/authorization/cubit/authorization_state.dart';
import 'package:bounty_hub_client/utils/localization/localization.res.dart';
import 'package:flutter/material.dart';

class FormValidation {

  //todo избавиться от контекста, невозможно покрыть юнит тестами. Также хотел валидировать в кубите и менять стейт
  static String email(BuildContext context, String value) {
    if (!value.contains('@')) {
      return AppStrings.invalidEmail;
    }else {
      return null;
    }
  }

  static String confirmCode(BuildContext context, String value, AuthorizationState state) {
    if ((state.status == AuthorizationStatus.confirmCode || state.status == AuthorizationStatus.confirmCodeError) && value.length != 5)
      return AppStrings.invalidCode;
    else
      return null;
  }

  static String isEmpty(String value) {
    if (value == null || value.isEmpty)
      return AppStrings.requiredField;
    else
      return null;
  }
}