import 'package:bounty_hub_client/data/enums/social_networks_types.dart';
import 'package:bounty_hub_client/data/enums/social_status_types.dart';
import 'package:bounty_hub_client/data/models/entity/user/social.dart';
import 'package:bounty_hub_client/ui/pages/profile_page/view_profile/bloc/profile_bloc.dart';
import 'package:bounty_hub_client/ui/pages/profile_page/view_profile/bloc/profile_event.dart';
import 'package:bounty_hub_client/ui/pages/profile_page/view_profile/bloc/profile_state.dart';
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
    return BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
      return InkWell(
        onTap: () {
          context.bloc<ProfileBloc>().add(SelectSocialProfileEvent(socialNetworkType));
        },
        child: Stack(
          children: [
            Container(
              height: 56,
              width: 56,
              decoration: state.selectedSocial == socialNetworkType
                  ? BoxDecoration(
                      boxShadow: state.selectedSocial == socialNetworkType ||
                              (social == null)
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
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Container(
                  child: Image.asset(
                      (state.selectedSocial != socialNetworkType) &&
                              (social == null)
                          ? iconsDisable[socialNetworkType]
                          : iconsActive[socialNetworkType]),
                ),
              ),
            ),
            if (social != null)
              buildStatusIcon()
          ],
        ),
      );
    });
  }

  Positioned buildStatusIcon() {
    return Positioned(
              bottom: 0,
              right: 0,
              child: Transform.translate(
                offset: Offset(4,4),
                child: Container(
                  padding: EdgeInsets.all(2),
                  margin: EdgeInsets.only(bottom: 4, right: 4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Container(
                    padding: EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      color: social.status == SocialStatusType.REJECTED
                        ? AppColors.errorTextColor
                        : social.status == SocialStatusType.APPROVED
                        ? Colors.blue
                        : Colors.amber,
                      shape: BoxShape.circle,
                    ),
                    child: [
                      if (social.status == SocialStatusType.REJECTED)
                        Icon(
                          Icons.warning,
                          size: 11,
                          color: Colors.white,
                        ),
                      if (social.status == SocialStatusType.APPROVED)
                        Image.asset(
                          'assets/images/complete.png',
                          height: 11,
                          width: 11,
                          color: Colors.white,
                        ),
                      if (social.status != SocialStatusType.APPROVED &&
                        social.status != SocialStatusType.REJECTED)
                        Image.asset(
                          'assets/images/clock.png',
                          height: 11,
                          width: 11,
                          color: Colors.white,
                        )
                    ][0],
                  ),
                ),
              ),
            );
  }
}
