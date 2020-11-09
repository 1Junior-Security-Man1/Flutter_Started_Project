import 'package:bounty_hub_client/ui/pages/login/cubit/login_state.dart';
import 'package:bounty_hub_client/utils/localization/localization.res.dart';
import 'package:flutter/material.dart';

class FormValidation {

  //todo избавиться от контекста, невозможно покрыть юнит тестами. Также хотел валидировать в кубите и менять стейт
  static String email(BuildContext context, String value) {
    if (!value.contains('@'))
      return AppStrings.invalidEmail;
    else
      return null;
  }

  static String confirmCode(BuildContext context, String value, LoginState state) {
    if ((state.status == LoginStatus.confirmCode || state.status == LoginStatus.confirmCodeError) && value.length != 5)
      return AppStrings.invalidCode;
    else
      return null;
  }
}