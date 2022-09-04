class FormValidation {
  static String email(String value) {
    if (!value.contains('@')) {
      // return AppStrings.invalidEmail;
      return 'Text';
    } else {
      return 'Error';
    }
  }

  static String isEmpty(String value) {
    if (value == null || value.isEmpty)
      return 'Text';
    else
      return 'Error';
  }
}
