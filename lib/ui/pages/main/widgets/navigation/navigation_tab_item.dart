import 'package:bounty_hub_client/ui/pages/activity/activity_page.dart';
import 'package:bounty_hub_client/ui/pages/profile_page/view_profile/profile_page.dart';
import 'package:bounty_hub_client/ui/pages/tasks/tasks_page.dart';
import 'package:bounty_hub_client/utils/localization/localization.res.dart';
import 'package:flutter/material.dart';

enum TabItem { tasks, profile, notifications }

Map<TabItem, String> navigationTabNames = {
  TabItem.tasks: AppStrings.tasksList,
  TabItem.profile: AppStrings.profile,
  TabItem.notifications: AppStrings.notifications,
};

const Map<TabItem, String> navigationTabIcons = {
  TabItem.tasks: 'assets/images/menu_item_tasks.png',
  TabItem.profile: 'assets/images/menu_item_profile.png',
  TabItem.notifications: 'assets/images/menu_item_notification.png',
};

Map<TabItem, Widget> navigationTabPages = {
  TabItem.tasks: TasksPage(),
  TabItem.profile: ProfilePage(),
  TabItem.notifications: ActivitiesPage(),
};