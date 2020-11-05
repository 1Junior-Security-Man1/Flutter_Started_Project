import 'package:bounty_hub_client/ui/pages/login/login_state.dart';
import 'package:bounty_hub_client/utils/localization/app_localizations.dart';
import 'package:flutter/material.dart';

class FormValidation {

  //todo избавиться от контекста, невозможно покрыть юнит тестами. Также хотел валидировать в кубите и менять стейт
  static String email(BuildContext context, String value) {
    if (!value.contains('@'))
      return Strings.of(context).get('invalid_email');
    else
      return null;
  }

  static String confirmCode(BuildContext context, String value, LoginState state) {
    if ((state.status == LoginStatus.confirmCode || state.status == LoginStatus.confirmCodeError) && value.length != 5)
      return Strings.of(context).get('invalid_code');
    else
      return null;
  }
}