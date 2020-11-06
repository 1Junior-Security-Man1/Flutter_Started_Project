import 'package:bounty_hub_client/data/enums/social_networks_types.dart';
import 'package:bounty_hub_client/data/enums/social_status_types.dart';
import 'package:bounty_hub_client/data/models/entity/user/social.dart';
import 'package:bounty_hub_client/ui/pages/profile/bloc/profile_bloc.dart';
import 'package:bounty_hub_client/ui/pages/profile/bloc/profile_event.dart';
import 'package:bounty_hub_client/ui/pages/profile/bloc/profile_state.dart';
import 'package:bounty_hub_client/utils/ui/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialIconWidget extends StatelessWidget {
  final SocialNetworkType socialNetworkType;

  static final iconsActive = {
    SocialNetworkType.FACEBOOK: 'assets/images/facebook.png',
    SocialNetworkType.INSTAGRAM: 'assets/images/instagram.png',
    SocialNetworkType.TWITTER: 'assets/images/twitter.png',
    SocialNetworkType.VK: 'assets/images/vk.png',
    SocialNetworkType.LINKEDIN: 'assets/images/linkedin.png',
  };
  static final iconsDisable = {
    SocialNetworkType.FACEBOOK: 'assets/images/facebook_disable.png',
    SocialNetworkType.INSTAGRAM: 'assets/images/instagram_disable.png',
    SocialNetworkType.TWITTER: 'assets/images/twitter_disable.png',
    SocialNetworkType.VK: 'assets/images/vk_disable.png',
    SocialNetworkType.LINKEDIN: 'assets/images/linkedin_disable.png',
  };

  final Socials social;

  const SocialIconWidget({Key key, this.socialNetworkType, this.social})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ProfileBloc _bloc = context.bloc<ProfileBloc>();

    return BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
      return InkWell(
        onTap: () {
          _bloc.add(SelectSocialProfileEvent(socialNetworkType));
        },
        child: Container(
          height: 56,
          width: 56,
          decoration: state.selectedSocial == socialNetworkType
              ? BoxDecoration(
                  boxShadow: state.selectedSocial == socialNetworkType ||
                          (social == null &&
                              (social.status == SocialStatusType.APPROVED ||
                                  social.status == SocialStatusType.VERIFYING))
                      ? [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 5,
                            blurRadius: 5,
                            offset: Offset(1, 3),
                          )
                        ]
                      : null,
                  shape: BoxShape.circle,
                  border:
                      Border.all(width: 2, color: AppColors.socialBorderColor))
              : null,
          child: Center(
            child: Container(
              height: 48,
              width: 48,
              child: Image.asset((state.selectedSocial != socialNetworkType) &&
                      (social == null || social.status == SocialStatusType.NEW)
                  ? iconsDisable[socialNetworkType]
                  : iconsActive[socialNetworkType]),
            ),
          ),
        ),
      );
    });
  }
}
