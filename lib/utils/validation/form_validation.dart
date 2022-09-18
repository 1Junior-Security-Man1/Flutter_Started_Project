class FormValidation {
  static bool email(String value) {
    return value.contains('@');
  }

  static dynamic email1(String value) {
    if (value.contains('@')) {
      return null;
    }else {
      return "You didn't put @";
    }
  }
}