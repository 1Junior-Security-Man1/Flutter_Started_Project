String checkNullString(String value, {String defaultValue = ''}) {
  return value == null ? defaultValue : value;
}

int checkNullInt(int value, {int defaultValue = 0}) {
  return value == null ? defaultValue : value;
}

double checkNullDouble(double value, {double defaultValue = 0.0}) {
  return value == null ? defaultValue : value;
}