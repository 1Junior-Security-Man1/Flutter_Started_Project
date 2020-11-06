import 'package:bounty_hub_client/data/enums/social_networks_types.dart';
import 'package:bounty_hub_client/data/models/entity/user/social.dart';
import 'package:bounty_hub_client/data/models/entity/user/user.dart';

class ProfileState {
  const ProfileState({
    this.user,
    this.selectedSocial,
    this.nextBtnWasPressed = const <SocialNetworkType, bool>{},
    this.socials=const [],
  });

  final User user;
  final SocialNetworkType selectedSocial;
  final Map<SocialNetworkType, bool> nextBtnWasPressed;
  final List<Socials> socials;

  ProfileState copyWith(
      {User user,
      SocialNetworkType selectedSocial,
      Map<SocialNetworkType, bool> nextBtnWasPressed,
      List<Socials> socials}) {
    return ProfileState(
      user: user ?? this.user,
      selectedSocial: selectedSocial ?? this.selectedSocial,
      nextBtnWasPressed: nextBtnWasPressed ?? this.nextBtnWasPressed,
      socials: socials ?? this.socials,
    );
  }
}
