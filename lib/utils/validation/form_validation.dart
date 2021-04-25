import 'package:flutter_starter/utils/localization/localization.res.dart';

class FormValidation {
  static String email(String value) {
    if (!value.contains('@')) {
      return AppStrings.invalidEmail;
    } else {
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
