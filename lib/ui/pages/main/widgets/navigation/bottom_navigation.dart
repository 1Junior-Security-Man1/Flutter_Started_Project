import 'package:bounty_hub_client/ui/pages/main/widgets/navigation/navigation_tab_item.dart';
import 'package:flutter/material.dart';
import 'package:bounty_hub_client/utils/ui/colors.dart';

class BottomNavigation extends StatelessWidget {
  BottomNavigation({@required this.currentTab, @required this.onSelectTab});

  final TabItem currentTab;
  final ValueChanged<TabItem> onSelectTab;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedItemColor: Colors.grey,
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,
      backgroundColor: AppColors.navigationBackgroundColor,
      items: [
        _buildItem(TabItem.tasks),
        _buildItem(TabItem.profile),
        _buildItem(TabItem.notifications),
      ],
      onTap: (index) => onSelectTab(
        TabItem.values[index],
      ),
    );
  }

  BottomNavigationBarItem _buildItem(TabItem tabItem) {
    return BottomNavigationBarItem(
      icon: Image.asset(navigationTabIcons[tabItem],
        width: 24,
        color: _colorTabMatching(tabItem),
      ),
      label: navigationTabNames[tabItem],
    );
  }

  Color _colorTabMatching(TabItem item) {
    return currentTab == item ? Colors.deepPurpleAccent : Colors.grey;
  }
}