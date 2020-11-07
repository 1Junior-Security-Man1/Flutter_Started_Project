import 'package:bounty_hub_client/data/enums/social_networks_types.dart';
import 'package:bounty_hub_client/utils/localization/localization.res.dart';
import 'package:intl/intl.dart';

import 'social_description_widget.dart';

String _getSubTitle(String name) {
  return '${AppStrings.inOrderToAuth} $name, ${AppStrings.uMastFille}';
}

String _getNeedMakeText(String name, {bool isSkill = false}) {
  return '${AppStrings.uNeedMake} ${isSkill ? AppStrings.skill : AppStrings
    .post} ${AppStrings.on} $name, ${AppStrings.withThisHashtag} ';
}

String _getMastBeAvailableText({bool isSkill = false}) {
  return '${AppStrings.thisS} ${isSkill ? AppStrings.skill : AppStrings
    .post} ${AppStrings.mustBeAvailable}';
}

String _getPostInTopText({bool isSkill = false}) {
  return '${AppStrings.thisS} ${isSkill ? AppStrings.skill : AppStrings
    .post} ${AppStrings.sholdBeInTop} ';
}

String _getBottomFacebool({bool isSkill = false}) {
  return '${AppStrings.haveUCopied}  ${isSkill ? AppStrings.skill : AppStrings
    .post} ${AppStrings.byClicking}';
}

String _getBottomText({bool isSkill = false}) {
  return '${AppStrings.copiedAndCreate}  ${isSkill
    ? AppStrings.skill
    : AppStrings.post}?';
}

String _getGreatText({bool isSkill = false}) {
  return '${AppStrings.greatSocial}  ${isSkill ? AppStrings.skill : AppStrings
    .post} ${AppStrings.thatUJust}';
}

Map<SocialNetworkType, SocialUIModel> initUIModels(int shortNumberInt) {
  final formatter = new NumberFormat("000000000");
  var shortNumber = '#b${formatter.format(shortNumberInt)}';

  var facebookIUModel = SocialUIModel(
    'Facebook',
    title: 'Profile Facebook',
    subTitle: _getSubTitle('Facebook'),
    text: [
      [_getNeedMakeText('Facebook'), shortNumber],
      [_getMastBeAvailableText()],
      [_getPostInTopText(), AppStrings.hours24]
    ],
    isTextBold: [
      [false, true],
      [false],
      [false, true]
    ],
    bottomText: _getBottomFacebool(),
    nextText: _getGreatText(),
    example:
    'https://www.facebook.com/profile.php?id=ACCOUNT_ID \nhttps://www.facebook.com/USER_NAME');

  var instgramIUModel = SocialUIModel(
    'Instagram',
    title: 'Instagram',
    subTitle: _getSubTitle('Instagram'),
    text: [
      [_getNeedMakeText('Instagram'), shortNumber],
      [_getMastBeAvailableText()],
      [_getPostInTopText(), AppStrings.hours24]
    ],
    isTextBold: [
      [false, true],
      [false],
      [false, true]
    ],
    bottomText: _getBottomText(),
    nextText: _getGreatText(),
    example: 'https://www.instagram.com/your_name/');

  var twitterIUModel = SocialUIModel(
    'Twitter',
    title: 'Twitter',
    subTitle: _getSubTitle('Twitter'),
    text: [
      [_getNeedMakeText('Twitter'), shortNumber],
      [_getMastBeAvailableText()],
      [_getPostInTopText(), AppStrings.hours24]
    ],
    isTextBold: [
      [false, true],
      [false],
      [false, true]
    ],
    bottomText: _getBottomText(),
    nextText: _getGreatText(),
    example: 'https://www.twitter.com/your_name');

  var vkIUModel = SocialUIModel(
    'VK',
    title: 'VK',
    subTitle: _getSubTitle('VK'),
    text: [
      [_getNeedMakeText('VK'), shortNumber],
      [_getMastBeAvailableText()],
      [_getPostInTopText(), AppStrings.hours24]
    ],
    isTextBold: [
      [false, true],
      [false],
      [false, true]
    ],
    bottomText: _getBottomText(),
    nextText: _getGreatText(),
    example: 'https://www.vk.com/your_name');

  var linkedInIUModel = SocialUIModel(
    'Linkedin',
    title: 'Linkedin',
    subTitle: _getSubTitle('Linkedin'),
    text: [
      [_getNeedMakeText('Linkedin', isSkill: true), shortNumber],
      [_getMastBeAvailableText(isSkill: true)],
      [_getPostInTopText(isSkill: true), AppStrings.hours24]
    ],
    isTextBold: [
      [false, true],
      [false],
      [false, true]
    ],
    bottomText: _getBottomText(isSkill: true),
    nextText: _getGreatText(isSkill: true),
    example: 'https://www.linkedin.com/in/your_name');

  Map<SocialNetworkType, SocialUIModel> models = {
    SocialNetworkType.FACEBOOK: facebookIUModel,
    SocialNetworkType.INSTAGRAM: instgramIUModel,
    SocialNetworkType.TWITTER: twitterIUModel,
    SocialNetworkType.VK: vkIUModel,
    SocialNetworkType.LINKEDIN: linkedInIUModel
  };
  return models;
}
