import 'package:bounty_hub_client/ui/pages/profile/widgets/social_card.dart';
import 'package:bounty_hub_client/ui/widgets/custom_appbar.dart';
import 'package:bounty_hub_client/utils/ui/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/profile_cubit.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  ProfileCubit _cubit;

  @override
  void initState() {
    _cubit = context.bloc<ProfileCubit>();
    _cubit.loadUserProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackgroundColor,
      appBar: CustomAppBar(
        title: 'Profile',
        leftIcon: 'assets/images/edit_icon.png',
        rightIcon: 'assets/images/settings.png',
        onLeftIconClick: () {},
        onRightIconClick: () {},
      ),
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(children: [
              SizedBox(height: 20,),
              SocialCardWidget()
            ],),
          );
        },
      ),
    );
  }
}
