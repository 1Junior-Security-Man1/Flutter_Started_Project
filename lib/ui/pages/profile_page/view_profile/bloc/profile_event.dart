import 'package:bounty_hub_client/data/enums/social_networks_types.dart';
import 'package:bounty_hub_client/data/models/entity/user/social.dart';
import 'package:bounty_hub_client/data/models/entity/user/user.dart';

abstract class ProfileEvent {}

class FetchProfileEvent extends ProfileEvent {}

class DestroyProfileEvent extends ProfileEvent {}

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

class AddSocialProfileEvent extends ProfileEvent {
  final SocialNetworkType socialNetworkType;
  final String profileUrl;

  AddSocialProfileEvent(this.socialNetworkType, this.profileUrl);
}

class RemoveSocialProfileEvent extends ProfileEvent {
  final String id;

  RemoveSocialProfileEvent(this.id);
}

class UpdateTronWalletEvent extends ProfileEvent {
  final String wallet;

  UpdateTronWalletEvent(this.wallet);
}

class ErrorWasShown extends ProfileEvent {}
