import 'package:bounty_hub_client/data/enums/social_networks_types.dart';
import 'package:bounty_hub_client/data/models/entity/user/social.dart';
import 'package:bounty_hub_client/data/models/entity/user/user.dart';

class ProfileState {
  const ProfileState({
    this.user,
    this.selectedSocial,
    this.nextBtnWasPressed = const <SocialNetworkType, bool>{},
    this.socials = const [],
    this.errorText,
    this.errorType,
  });

  final User user;
  final SocialNetworkType selectedSocial;
  final Map<SocialNetworkType, bool> nextBtnWasPressed;
  final List<Socials> socials;
  final String errorText;
  final String errorType;

  ProfileState copyWith(
      {User user,
      SocialNetworkType selectedSocial,
      Map<SocialNetworkType, bool> nextBtnWasPressed,
      List<Socials> socials,
      String errorText,
      String errorType}) {
    return ProfileState(
      user: user ?? this.user,
      selectedSocial: selectedSocial ?? this.selectedSocial,
      nextBtnWasPressed: nextBtnWasPressed ?? this.nextBtnWasPressed,
      socials: socials ?? this.socials,
      errorText: errorText ?? this.errorText,
      errorType: errorType ?? this.errorType,
    );
  }
}
