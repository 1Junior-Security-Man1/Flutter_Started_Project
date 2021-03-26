enum TabItem { tasks, profile, notifications }

const Map<TabItem, String> tabName = {
  TabItem.tasks: 'Tasks',
  TabItem.profile: 'Profile',
  TabItem.notifications: 'Notifications',
};

const Map<TabItem, String> tabIcon = {
  TabItem.tasks: 'assets/images/menu_item_tasks.png',
  TabItem.profile: 'assets/images/menu_item_profile.png',
  TabItem.notifications: 'assets/images/menu_item_notification.png',
};