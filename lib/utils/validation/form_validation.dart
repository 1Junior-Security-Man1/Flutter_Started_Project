class FormValidation {
  static String email(String value) {
    if (!value.contains('@')) {
      // return AppStrings.invalidEmail;
      return "You didn't put @";
    } else {
      return "success email";
    }
  }

  static String isEmpty(String value) {
    if (value == null || value.isEmpty)
      return 'The field is empty';
    else
      return 'success email';
  }
}
