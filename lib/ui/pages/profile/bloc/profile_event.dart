import 'package:bounty_hub_client/data/enums/social_networks_types.dart';
import 'package:bounty_hub_client/data/models/entity/user/social.dart';
import 'package:bounty_hub_client/data/models/entity/user/user.dart';

abstract class ProfileEvent {}

class FetchProfileEvent extends ProfileEvent {}

class UserProfileReceivedEvent extends ProfileEvent {
  User user;

  UserProfileReceivedEvent(this.user);
}
class SocialsReceivedEvent extends ProfileEvent {
  List<Socials> socials;

  SocialsReceivedEvent(this.socials);
}

class OnNextBtnPresEvent extends ProfileEvent {
  final SocialNetworkType socialNetworkType;

  OnNextBtnPresEvent(this.socialNetworkType);
}

class SelectSocialProfileEvent extends ProfileEvent {
  final SocialNetworkType socialNetworkType;

  SelectSocialProfileEvent(this.socialNetworkType);
}


