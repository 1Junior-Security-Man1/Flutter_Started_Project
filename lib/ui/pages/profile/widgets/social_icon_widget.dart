import 'package:bounty_hub_client/data/enums/social_networks_types.dart';
import 'package:bounty_hub_client/ui/pages/profile/cubit/profile_cubit.dart';
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

  const SocialIconWidget({Key key, this.socialNetworkType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ProfileCubit _cubit = context.bloc<ProfileCubit>();

    return BlocBuilder<ProfileCubit, ProfileState>(builder: (context, state) {
      return InkWell(
        onTap: () {
          _cubit.selectSocial(socialNetworkType);
        },
        child: Container(
          height: 56,
          width: 56,
          decoration: state.selectedSocial == socialNetworkType
              ? BoxDecoration(
                  shape: BoxShape.circle,
                  border:
                      Border.all(width: 2, color: AppColors.socialBorderColor))
              : null,
          child: Container(
            height: 48,
            width: 48,
            child: Image.asset(iconsActive[socialNetworkType]),
          ),
        ),
      );
    });
  }
}
