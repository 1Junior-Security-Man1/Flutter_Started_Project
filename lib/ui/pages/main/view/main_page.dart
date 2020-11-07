import 'package:bounty_hub_client/data/repositories/tasks_repository.dart';
import 'package:bounty_hub_client/ui/pages/main/main_cubit.dart';
import 'package:bounty_hub_client/ui/pages/profile_page/profile/profile_page.dart';
import 'package:bounty_hub_client/ui/pages/tasks/view/tasks_page.dart';
import 'package:bounty_hub_client/utils/ui/colors.dart';
import 'package:bounty_hub_client/utils/ui/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

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
                      child: buildNavigationBarIcon(
                          2,
                          _selectedIndex,
                          'assets/images/menu_item_notification.png',
                          'assets/images/menu_item_notification_active.png'),
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
      Text('Notifications'), // TODO
    ];
  }
}
