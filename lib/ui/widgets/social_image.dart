import 'package:flutter_starter/data/enums/social_networks_types.dart';
import 'package:flutter/material.dart';

Image buildSocialImage(SocialNetworkType socialNetworkType) {
  switch (socialNetworkType) {
    case SocialNetworkType.FACEBOOK:
      return Image.asset('assets/images/facebook.png');
    case SocialNetworkType.VK:
      return Image.asset('assets/images/vk.png');
    case SocialNetworkType.TWITTER:
      return Image.asset('assets/images/twitter.png');
    case SocialNetworkType.MEDIUM:
      return Image.asset('assets/images/medium.png');
    case SocialNetworkType.TELEGRAM:
      return Image.asset('assets/images/telegram.png');
    case SocialNetworkType.INSTAGRAM:
      return Image.asset('assets/images/instagram.png');
    case SocialNetworkType.LINKEDIN:
      return Image.asset('assets/images/linkedin.png');
    case SocialNetworkType.YOUTUBE:
      return Image.asset('assets/images/youtube.png');
    case SocialNetworkType.TIKTOK:
      return Image.asset('assets/images/tiktok.png');
    default:
      return Image.asset('assets/images/other.png');
  }
}