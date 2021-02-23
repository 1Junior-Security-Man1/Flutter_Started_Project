import 'package:bounty_hub_client/data/enums/social_networks_types.dart';
import 'package:bounty_hub_client/ui/pages/profile_page/view_profile/bloc/profile_bloc.dart';
import 'package:bounty_hub_client/ui/pages/profile_page/view_profile/bloc/profile_state.dart';
import 'package:bounty_hub_client/ui/pages/profile_page/view_profile/widgets/social/social_description_widgets/social_description_widget.dart';
import 'package:bounty_hub_client/utils/localization/localization.res.dart';
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
    return BlocBuilder<ProfileBloc, ProfileState>(
      cubit: context.bloc<ProfileBloc>(),
      builder: (context, state) {
        return state.user?.id == null
            ? Container(padding: EdgeInsets.only(top: 8))
            : Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                child: Container(
                  decoration: WidgetsDecoration.appCardStyle()
                      .copyWith(borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 25, bottom: 34, left: 20, right: 20),
                    child: Column(
                      children: [
                        Text(
                          AppStrings.mySocialNetworks,
                          style: AppTextStyles.titleTextStyle,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          AppStrings.socialNetworkPages,
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
                                  social: state.socials.firstWhere(
                                      (element) =>
                                          element.type ==
                                          SocialNetworkType.FACEBOOK,
                                      orElse: () => null)),
                              SizedBox(
                                width: 8,
                              ),
                              SocialIconWidget(
                                  socialNetworkType:
                                      SocialNetworkType.INSTAGRAM,
                                  social: state.socials.firstWhere(
                                      (element) =>
                                          element.type ==
                                          SocialNetworkType.INSTAGRAM,
                                      orElse: () => null)),
                              SizedBox(
                                width: 8,
                              ),
                              SocialIconWidget(
                                  socialNetworkType: SocialNetworkType.TWITTER,
                                  social: state.socials.firstWhere(
                                      (element) =>
                                          element.type ==
                                          SocialNetworkType.TWITTER,
                                      orElse: () => null)),
                              SizedBox(
                                width: 8,
                              ),
                              SocialIconWidget(
                                  socialNetworkType: SocialNetworkType.VK,
                                  social: state.socials.firstWhere(
                                      (element) =>
                                          element.type == SocialNetworkType.VK,
                                      orElse: () => null)),
                              SizedBox(
                                width: 8,
                              ),
                              SocialIconWidget(
                                  socialNetworkType: SocialNetworkType.LINKEDIN,
                                  social: state.socials.firstWhere(
                                      (element) =>
                                          element.type ==
                                          SocialNetworkType.LINKEDIN,
                                      orElse: () => null)),
                              SizedBox(
                                width: 8,
                              ),
                              SocialIconWidget(
                                  socialNetworkType: SocialNetworkType.TIKTOK,
                                  social: state.socials.firstWhere(
                                          (element) =>
                                      element.type ==
                                          SocialNetworkType.TIKTOK,
                                      orElse: () => null)),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Container(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 12,
                                  horizontal:
                                      state.selectedSocial == null ? 15 : 0),
                              child: state.selectedSocial == null
                                  ? Text(
                                AppStrings.connectSocialNetworksEarn,
                                      style: AppTextStyles.titleTextStyle,
                                      textAlign: TextAlign.center,
                                    )
                                  : SocialDescriptionWidget(
                                      state.selectedSocial,
                                      social: state.socials.firstWhere(
                                          (element) =>
                                        element.type ==
                                          state.selectedSocial,
                                        orElse: () => null),
                                      shortNumber: state.user.shortNumber,
                                      nextBtnWasPressed: state.nextBtnWasPressed
                                              .containsKey(
                                                  state.selectedSocial) &&
                                          state.nextBtnWasPressed.containsKey(
                                              state.selectedSocial),
                                    ),
                            ),
                            decoration: state.selectedSocial == null
                                ? BoxDecoration(
                                    color: AppColors.socialDescription,
                                    border: Border.all(
                                        color:
                                            AppColors.socialDescriptionBorder,
                                        width: 1),
                                    borderRadius: BorderRadius.circular(14))
                                : null,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
      },
    );
  }
}
