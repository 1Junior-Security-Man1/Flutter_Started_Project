import 'package:flutter_starter/ui/pages/authorization/cubit/authorization_state.dart';
import 'package:flutter_starter/utils/localization/localization.res.dart';
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

  static String isEmpty(String value) {
    if (value == null || value.isEmpty)
      return AppStrings.requiredField;
    else
      return null;
  }
}