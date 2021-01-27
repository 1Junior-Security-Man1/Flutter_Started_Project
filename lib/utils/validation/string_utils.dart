String checkNullString(String value, {String defaultValue = ''}) {
  return value == null ? defaultValue : value;
}

int checkNullInt(int value, {int defaultValue = 0}) {
  return value == null ? defaultValue : value;
}

double checkNullDouble(double value, {double defaultValue = 0.0}) {
  return value == null ? defaultValue : value;
}

List<String> getLanguageCode(String language) {
  if(language != null && language.isNotEmpty && language.contains('_')) {
    return language.split('_');
  } else {
    return ["en", "US"];
  }
}