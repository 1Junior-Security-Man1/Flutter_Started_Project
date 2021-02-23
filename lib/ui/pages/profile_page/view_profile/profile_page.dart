import 'package:bounty_hub_client/ui/pages/profile_page/edit_profile/cubit/edit_profile_cubit.dart';
import 'package:bounty_hub_client/ui/pages/profile_page/edit_profile/edit_profile_page.dart';
import 'package:bounty_hub_client/ui/pages/profile_page/view_profile/widgets/lvl_card_widget.dart';
import 'package:bounty_hub_client/ui/pages/profile_page/view_profile/widgets/social/social_card.dart';
import 'package:bounty_hub_client/ui/pages/profile_page/view_profile/widgets/wallet_card_widget.dart';
import 'package:bounty_hub_client/ui/pages/profile_page/view_profile/widgets/balances_widget.dart';
import 'package:bounty_hub_client/ui/widgets/custom_appbar.dart';
import 'package:bounty_hub_client/utils/localization/localization.res.dart';
import 'package:bounty_hub_client/utils/ui/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/profile_bloc.dart';
import 'bloc/profile_event.dart';

class ProfilePage extends StatefulWidget {

  final showBackButton;

  const ProfilePage({Key key, this.showBackButton = false}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  ProfileBloc _bloc;

  @override
  void initState() {
    _bloc = context.bloc<ProfileBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackgroundColor,
      appBar: CustomAppBar(
        title: AppStrings.profile,
        rightIcon: 'assets/images/edit_icon.png',
        leftIcon: widget.showBackButton ? 'assets/images/back.png' : '',
        onRightIconClick: () async {
          await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => BlocProvider(
                      create: (context) =>
                          EditProfileCubit(_bloc.state.user?.copy()),
                      child: EditProfilePage())));

          _bloc.add(FetchProfileEvent());
        },
        onLeftIconClick: () {
          Navigator.pop(context);
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            LvlCardWidget(),
            BalancesWidget(),
            WalletCardWidget(),
            SocialCardWidget()
          ],
        ),
      ),
    );
  }
}
