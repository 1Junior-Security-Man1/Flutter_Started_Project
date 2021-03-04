import 'package:bounty_hub_client/bloc/badge/badge_cubit.dart';
import 'package:bounty_hub_client/bloc/locale/locale_bloc.dart';
import 'package:bounty_hub_client/bloc/locale/locale_event.dart';
import 'package:bounty_hub_client/ui/pages/activity/activity_page.dart';
import 'package:bounty_hub_client/ui/pages/main/cubit/main_cubit.dart';
import 'package:bounty_hub_client/ui/pages/main/cubit/main_state.dart';
import 'package:bounty_hub_client/ui/pages/profile_page/view_profile/bloc/profile_bloc.dart';
import 'package:bounty_hub_client/ui/pages/profile_page/view_profile/bloc/profile_event.dart';
import 'package:bounty_hub_client/ui/pages/profile_page/view_profile/profile_page.dart';
import 'package:bounty_hub_client/ui/pages/tasks/cubit/tasks_cubit.dart';
import 'package:bounty_hub_client/ui/pages/tasks/tasks_page.dart';
import 'package:bounty_hub_client/utils/localization/localization.res.dart';
import 'package:bounty_hub_client/utils/ui/colors.dart';
import 'package:bounty_hub_client/utils/ui/styles.dart';
import 'package:bounty_hub_client/utils/ui/text_styles.dart';
import 'package:bounty_hub_client/utils/validation/string_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPage extends StatefulWidget {

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  @override
  void initState() {
    Future.microtask(() {
      context.bloc<ActivityBadgeCubit>().getCount();
      context.bloc<TasksCubit>().getCampaigns();
      context.bloc<ProfileBloc>().add(FetchProfileEvent());
      context?.bloc<ProfileBloc>()?.listen((state) {
        if (context != null) {
          BlocProvider.of<LocaleBloc>(context).add(ChangeLocaleEvent(
            countryCode: getLanguageCode(state.user?.language)[1],
            languageCode: getLanguageCode(state.user?.language)[0],
          ));
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(
        builder: (context, state) {
          return Scaffold(
            body: Center(
              child: getNavigationTabs().elementAt(state.currentNavigationItem),
            ),
            bottomNavigationBar: _buildBottomNavigationBar(state),
          );
        });
  }

  Image buildNavigationBarIcon(int itemIndex, int _selectedIndex,
      String iconNormal, String iconSelected) {
    return _selectedIndex == itemIndex
        ? Image.asset(iconSelected, width: 26)
        : Image.asset(iconNormal, width: 26);
  }

  Widget _buildBottomNavigationBar(MainState state) {
    return Container(
      decoration: WidgetsDecoration.appNavigationStyle(),
      child: SizedBox(
        height: 70 + MediaQuery.of(context).padding.bottom,
        child: BottomNavigationBar(
          elevation: 0,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: buildNavigationBarIcon(
                    0,
                    state.currentNavigationItem,
                    'assets/images/menu_item_tasks.png',
                    'assets/images/menu_item_tasks_active.png'),
              ),
              label: AppStrings.doTasks,
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: buildNavigationBarIcon(
                    1,
                    state.currentNavigationItem,
                    'assets/images/menu_item_profile.png',
                    'assets/images/menu_item_profile_active.png'),
              ),
              label: AppStrings.profile,
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: BlocBuilder<ActivityBadgeCubit, ActivityBadgeState>(
                  builder: (context, newState) => Stack(
                    alignment: Alignment.topRight,
                    children: [
                      buildNavigationBarIcon(
                          2,
                          state.currentNavigationItem,
                          'assets/images/menu_item_notification.png',
                          'assets/images/menu_item_notification_active.png'),
                      if (newState.unreadCount > 0)
                        Container(
                          decoration: WidgetsDecoration.appBlueButtonStyle(),
                          height: 14,
                          width: 14,
                          child: Center(
                              child: Text(
                                newState.unreadCount.toString(),
                                style: AppTextStyles.defaultBold
                                    .copyWith(color: Colors.white, fontSize: 9),
                              )),
                        )
                    ],
                  ),
                ),
              ),
              label: AppStrings.notifications,
            ),
          ],
          currentIndex: state.currentNavigationItem,
          backgroundColor: AppColors.navigationBackgroundColor,
          selectedItemColor: AppColors.navigationWidgetsColor,
          unselectedFontSize: 10,
          selectedFontSize: 10,
          type: BottomNavigationBarType.fixed,
          onTap: context.bloc<MainCubit>().setCurrentNavigationItem,
        ),
      ),
    );
  }

  List<Widget> getNavigationTabs() {
    return <Widget>[
      TasksPage(),
      ProfilePage(),
      ActivitiesPage(), // TODO
    ];
  }
}
