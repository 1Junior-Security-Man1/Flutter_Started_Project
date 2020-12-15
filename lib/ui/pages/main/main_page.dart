import 'package:bounty_hub_client/bloc/badge/badge_cubit.dart';
import 'package:bounty_hub_client/data/repositories/tasks_repository.dart';
import 'package:bounty_hub_client/ui/pages/activity/activity_page.dart';
import 'package:bounty_hub_client/ui/pages/main/cubit/main_cubit.dart';
import 'package:bounty_hub_client/ui/pages/profile_page/profile/bloc/profile_bloc.dart';
import 'package:bounty_hub_client/ui/pages/profile_page/profile/bloc/profile_event.dart';
import 'package:bounty_hub_client/ui/pages/profile_page/profile/profile_page.dart';
import 'package:bounty_hub_client/ui/pages/tasks/cubit/tasks_cubit.dart';
import 'package:bounty_hub_client/ui/pages/tasks/tasks_page.dart';
import 'package:bounty_hub_client/utils/localization/bloc/locale_bloc.dart';
import 'package:bounty_hub_client/utils/localization/bloc/locale_event.dart';
import 'package:bounty_hub_client/utils/ui/colors.dart';
import 'package:bounty_hub_client/utils/ui/styles.dart';
import 'package:bounty_hub_client/utils/ui/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  @override
  void initState() {
    Future.microtask(() {
      context.bloc<ActivityBadgeCubit>().getCount();
      context.bloc<TasksCubit>().getCompanies();
      context.bloc<ProfileBloc>().add(FetchProfileEvent());
      context.bloc<ProfileBloc>().listen((state) {
        BlocProvider.of<LocaleBloc>(context).add(ChangeLocaleEvent(
          countryCode: state.user.language.split('_')[1],
          languageCode: state.user.language.split('_')[0],
        ));
      });
    });
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _navigateToScreens(index);
  }

  void _navigateToScreens(int index) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) => MainCubit(context.repository<TaskRepository>()),
        child: Center(
          child: getNavMenu().elementAt(_selectedIndex),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: WidgetsDecoration.appNavigationStyle(),
        child: SizedBox(
          height: 70,
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(22.0),
              topRight: Radius.circular(22.0),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 1.0, right: 1.0),
              child: BottomNavigationBar(
                elevation: 0,
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Padding(
                      padding: const EdgeInsets.only(bottom: 5.0),
                      child: buildNavigationBarIcon(
                          0,
                          _selectedIndex,
                          'assets/images/menu_item_tasks.png',
                          'assets/images/menu_item_tasks_active.png'),
                    ),
                    label: 'Do Tasks',
                  ),
                  BottomNavigationBarItem(
                    icon: Padding(
                      padding: const EdgeInsets.only(bottom: 5.0),
                      child: buildNavigationBarIcon(
                          1,
                          _selectedIndex,
                          'assets/images/menu_item_profile.png',
                          'assets/images/menu_item_profile_active.png'),
                    ),
                    label: 'Profile',
                  ),
                  BottomNavigationBarItem(
                    icon: Padding(
                      padding: const EdgeInsets.only(bottom: 5.0),
                      child: BlocBuilder<ActivityBadgeCubit,ActivityBadgeState>(
                        builder:(context,state)=> Stack(
                          alignment: Alignment.topRight,
                          children: [
                            buildNavigationBarIcon(
                                2,
                                _selectedIndex,
                                'assets/images/menu_item_notification.png',
                                'assets/images/menu_item_notification_active.png'),
                            if(state.unreadCount>0)
                              Container(
                                decoration: WidgetsDecoration.appBlueButtonStyle(),
                                height: 14,
                                width: 14,
                                child: Center(child: Text(state.unreadCount.toString(), style: AppTextStyles.defaultBold.copyWith(color: Colors.white,fontSize: 9),)),
                              )
                          ],
                        ),
                      ),
                    ),
                    label: 'Notifications',
                  ),
                ],
                currentIndex: _selectedIndex,
                backgroundColor: AppColors.navigationBackgroundColor,
                selectedItemColor: AppColors.navigationWidgetsColor,
                unselectedFontSize: 10,
                selectedFontSize: 10,
                type: BottomNavigationBarType.fixed,
                onTap: _onItemTapped,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Image buildNavigationBarIcon(int itemIndex, int _selectedIndex,
      String iconNormal, String iconSelected) {
    return _selectedIndex == itemIndex
        ? Image.asset(iconSelected, width: 26)
        : Image.asset(iconNormal, width: 26);
  }

  List<Widget> getNavMenu() {
    return <Widget>[
      TasksPage(),
      ProfilePage(),
      ActivitiesPage(), // TODO
    ];
  }
}
