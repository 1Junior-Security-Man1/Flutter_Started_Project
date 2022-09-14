@deprecated
String checkNullString(String value, {String defaultValue = ''}) {
  return value.isEmpty ? defaultValue : value;
}

@deprecated
int checkNullInt(int? value, {int defaultValue = 0}) {
  return value ?? defaultValue;
}

@deprecated
double checkNullDouble(double? value, {double defaultValue = 0.0}) {
  return value ?? defaultValue;
}

String parseUrl(String url, String key) {
  if(url.isNotEmpty) {
    var uri = Uri.parse(url);
    return uri.queryParameters[key]!;
  } else {
    return '';
  }
}