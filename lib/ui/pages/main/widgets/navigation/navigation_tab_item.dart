import 'package:flutter_starter/ui/pages/template/template_page.dart';
import 'package:flutter_starter/utils/localization/localization.res.dart';
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
  TabItem.tasks: TemplatePage('Dashboard'),
  TabItem.profile: TemplatePage('Profile'),
  TabItem.notifications: TemplatePage('Settings'),
};