@deprecated
String checkNullString(String value, {String defaultValue = ''}) {
  return value == null ? defaultValue : value;
}

@deprecated
int checkNullInt(int value, {int defaultValue = 0}) {
  return value == null ? defaultValue : value;
}

@deprecated
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

String parseUrl(String url, String key) {
  if(url != null && url.isNotEmpty) {
    var uri = Uri.parse(url);
    return uri.queryParameters[key];
  } else {
    return '';
  }
}