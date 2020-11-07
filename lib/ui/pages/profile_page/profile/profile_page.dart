import 'package:bounty_hub_client/ui/pages/profile_page/profile/widgets/social/social_card.dart';
import 'package:bounty_hub_client/ui/widgets/custom_appbar.dart';
import 'package:bounty_hub_client/utils/ui/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/profile_bloc.dart';
import 'bloc/profile_event.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  ProfileBloc _bloc;

  @override
  void initState() {
    _bloc = context.bloc<ProfileBloc>();
    Future.microtask(() {
      _bloc.add(FetchProfileEvent());
    });
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            SocialCardWidget()
          ],
        ),
      ),
    );
  }
}
