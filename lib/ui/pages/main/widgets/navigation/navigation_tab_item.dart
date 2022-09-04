import 'package:flutter_starter/ui/pages/template/template_page.dart';
import 'package:flutter_starter/utils/localization/localization.res.dart';
import 'package:flutter/material.dart';

enum TabItem { dashboard, profile, notifications }

Map<TabItem, String> navigationTabNames = {
  // TabItem.dashboard: AppStrings.dashboard,
  // TabItem.profile: AppStrings.profile,
  // TabItem.notifications: AppStrings.notifications,
  TabItem.dashboard: 'Text1',
  TabItem.profile: 'Text2',
  TabItem.notifications: 'Text3',
};

const Map<TabItem, String> navigationTabIcons = {
  TabItem.dashboard: 'assets/images/menu_item_dashboard.png',
  TabItem.profile: 'assets/images/menu_item_profile.png',
  TabItem.notifications: 'assets/images/menu_item_notification.png',
};

Map<TabItem, Widget> navigationTabPages = {
  TabItem.dashboard: TemplatePage('Dashboard'),
  TabItem.profile: TemplatePage('Profile'),
  TabItem.notifications: TemplatePage('Settings'),
};