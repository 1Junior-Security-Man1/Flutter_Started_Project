import 'package:bounty_hub_client/data/enums/social_networks_types.dart';
import 'package:bounty_hub_client/ui/pages/profile/cubit/profile_cubit.dart';
import 'package:bounty_hub_client/ui/pages/profile/widgets/social_description_widgets/social_description_widget.dart';
import 'package:bounty_hub_client/utils/ui/colors.dart';
import 'package:bounty_hub_client/utils/ui/styles.dart';
import 'package:bounty_hub_client/utils/ui/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'social_icon_widget.dart';

class SocialCardWidget extends StatefulWidget {
  @override
  _SocialCardWidgetState createState() => _SocialCardWidgetState();
}

class _SocialCardWidgetState extends State<SocialCardWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        child: Container(
          decoration: WidgetsDecoration.appCardStyle()
              .copyWith(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding:
                const EdgeInsets.only(top: 25, bottom: 34, left: 20, right: 20),
            child: Column(
              children: [
                Text(
                  'My Social Networks',
                  style: AppTextStyles.titleTextStyle,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'My Social network Pages to Share Your Activity with friends',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.greyContentTextStyle,
                ),
                SizedBox(
                  height: 10,
                ),
                FittedBox(
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SocialIconWidget(
                        socialNetworkType: SocialNetworkType.FACEBOOK,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      SocialIconWidget(
                        socialNetworkType: SocialNetworkType.INSTAGRAM,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      SocialIconWidget(
                        socialNetworkType: SocialNetworkType.TWITTER,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      SocialIconWidget(
                        socialNetworkType: SocialNetworkType.VK,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      SocialIconWidget(
                        socialNetworkType: SocialNetworkType.LINKEDIN,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top:22),
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 15),
                      child: state.selectedSocial == null
                          ? Text(
                              'Connect Your Social Networks to start Earn Money',
                              style: AppTextStyles.titleTextStyle,
                              textAlign: TextAlign.center,
                            )
                          : SocialDescriptionWidget(state.selectedSocial,shortNumber: state.user.shortNumber.toString(),),
                    ),
                    decoration: BoxDecoration(
                        color: AppColors.socialDescription,
                        border: Border.all(
                            color: AppColors.socialDescriptionBorder, width: 1),
                        borderRadius: BorderRadius.circular(14)),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
