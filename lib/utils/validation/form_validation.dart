class FormValidation {

  static String validateEmail(String value) {
    if (!value.contains('@'))
      return 'Invalid E-mail';
    else
      return null;
  }
}