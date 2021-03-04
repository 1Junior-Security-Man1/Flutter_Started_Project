import 'package:bounty_hub_client/network/constants.dart';
import 'package:bounty_hub_client/ui/pages/profile_page/view_profile/bloc/profile_bloc.dart';
import 'package:bounty_hub_client/ui/pages/profile_page/view_profile/bloc/profile_state.dart';
import 'package:bounty_hub_client/ui/widgets/app_button.dart';
import 'package:bounty_hub_client/utils/localization/localization.res.dart';
import 'package:bounty_hub_client/utils/ui/colors.dart';
import 'package:bounty_hub_client/utils/ui/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bounty_hub_client/utils/ui/text_styles.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:bounty_hub_client/ui/pages/task_details/widgets/task_ui_utils.dart';
import 'package:bounty_hub_client/utils/bloc_utils.dart';

class BalancesWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      cubit: context.bloc<ProfileBloc>(),
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 30),
            decoration: WidgetsDecoration.appCardStyle().copyWith(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Text(
                    AppStrings.yourBalance,
                    style: AppTextStyles.titleTextStyle,
                  ),
                ),
                !isNoSocialMode() ? Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Container(
                        height: 50,
                        width: 50,
                        child: Image.asset('assets/images/bht_active.png'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('BHT',
                            style: TextStyle(
                                color: AppColors.itemTextColor,
                                fontWeight: FontWeight.w700,
                                fontSize: 14
                            ),
                          ),
                          Text(AppStrings.bountyCoin,
                            style: TextStyle(
                                color: AppColors.multiLineTextColor,
                                fontWeight: FontWeight.w400,
                                fontSize: 14
                            ),
                          ),
                        ],),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: Text(getBalance(state.user?.balances, 'BHT'),
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              color: AppColors.itemTextColor,
                              fontWeight: FontWeight.w700,
                              fontSize: 14
                          ),
                        ),
                      ),
                    ),
                  ],
                ) : SizedBox(),
                SizedBox(height: 8),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Container(
                        height: 50,
                        width: 50,
                        child: Image.asset('assets/images/trx_active.png'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('TRX',
                            style: TextStyle(
                                color: AppColors.itemTextColor,
                                fontWeight: FontWeight.w700,
                                fontSize: 14
                            ),
                          ),
                          Text(AppStrings.tronCoin,
                            style: TextStyle(
                                color: AppColors.multiLineTextColor,
                                fontWeight: FontWeight.w400,
                                fontSize: 14
                            ),
                          ),
                        ],),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: Text(getBalance(state.user?.balances, 'TRX'),
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              color: AppColors.itemTextColor,
                              fontWeight: FontWeight.w700,
                              fontSize: 14
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: AppButton(
                    enable: state.user != null && state.user.id != null,
                    text: AppStrings.withdraw.toUpperCase(),
                    width: 180,
                    onPressed: () async {
                      var url = Constants.baseUrl + Constants.profileUrl;
                      if (await canLaunch(url)) {
                        await launch(url);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
