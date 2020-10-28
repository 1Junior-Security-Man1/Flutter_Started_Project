import 'package:enum_to_string/enum_to_string.dart';

enum SocialNetworkType {
  FACEBOOK, //+
  VK,
  DISCORD,
  TWITTER, //+
  REDDIT,
  BITCOIN_TALK,
  YOUTUBE, //+
  SLACK, //+
  MEDIUM, //+
  TELEGRAM,
  INSTAGRAM, //+
  OTHER,
  LINKEDIN,
}

SocialNetworkType fromString(String value) {
  return EnumToString.fromString(SocialNetworkType.values, value);
}