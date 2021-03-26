import 'package:bounty_hub_client/ui/pages/activity/activity_page.dart';
import 'package:bounty_hub_client/ui/pages/main/widgets/navigation/navigation_tab_item.dart';
import 'package:bounty_hub_client/ui/pages/profile_page/view_profile/profile_page.dart';
import 'package:bounty_hub_client/ui/pages/tasks/tasks_page.dart';
import 'package:flutter/material.dart';

class TabNavigator extends StatelessWidget {
  TabNavigator({this.navigatorKey, this.tabItem});

  final GlobalKey<NavigatorState> navigatorKey;
  final TabItem tabItem;

  Widget getRootNavigationPages(TabItem tabItem) {
    switch(tabItem) {
      case TabItem.tasks:
        return TasksPage();
      case TabItem.profile:
        return ProfilePage();
      case TabItem.notifications:
        return ActivitiesPage();
      default:
        return TasksPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      initialRoute: '/',
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(
          builder: (context) => getRootNavigationPages(tabItem),
        );
      },
    );
  }
}