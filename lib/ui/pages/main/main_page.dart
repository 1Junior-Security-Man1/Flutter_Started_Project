import 'package:bounty_hub_client/bloc/badge/badge_cubit.dart';
import 'package:bounty_hub_client/bloc/locale/locale_bloc.dart';
import 'package:bounty_hub_client/bloc/locale/locale_event.dart';
import 'package:bounty_hub_client/ui/pages/main/cubit/main_cubit.dart';
import 'package:bounty_hub_client/ui/pages/main/cubit/main_state.dart';
import 'package:bounty_hub_client/ui/pages/main/widgets/navigation/bottom_navigation.dart';
import 'package:bounty_hub_client/ui/pages/main/widgets/navigation/navigation_tab_item.dart';
import 'package:bounty_hub_client/ui/pages/main/widgets/navigation/tab_navigator.dart';
import 'package:bounty_hub_client/ui/pages/profile_page/view_profile/bloc/profile_bloc.dart';
import 'package:bounty_hub_client/ui/pages/profile_page/view_profile/bloc/profile_event.dart';
import 'package:bounty_hub_client/ui/pages/tasks/cubit/tasks_cubit.dart';
import 'package:bounty_hub_client/utils/validation/string_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPage extends StatefulWidget {

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  TabItem _currentTab = TabItem.tasks;

  final _navigatorKeys = {
    TabItem.tasks: GlobalKey<NavigatorState>(),
    TabItem.profile: GlobalKey<NavigatorState>(),
    TabItem.notifications: GlobalKey<NavigatorState>(),
  };

  void _selectTab(TabItem tabItem) {
    if (tabItem == _currentTab) {
      // pop to first page in current tab
      _navigatorKeys[tabItem].currentState.popUntil((route) => route.isFirst);
    } else {
      setState(() => _currentTab = tabItem);
    }
  }

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
          return WillPopScope(
            onWillPop: () async {
              final isFirstRouteInCurrentTab =
              !await _navigatorKeys[_currentTab].currentState.maybePop();
              if (isFirstRouteInCurrentTab) {
                if (_currentTab != TabItem.tasks) {
                  _selectTab(TabItem.tasks);
                  // back button handled by app
                  return false;
                }
              }
              // let system handle back button if we're on the first route
              return isFirstRouteInCurrentTab;
            },
            child: Scaffold(
              body: Stack(children: <Widget>[
                _buildOffstageNavigator(TabItem.tasks),
                _buildOffstageNavigator(TabItem.profile),
                _buildOffstageNavigator(TabItem.notifications),
              ]),
              bottomNavigationBar: BottomNavigation(
                currentTab: _currentTab,
                onSelectTab: _selectTab,
              ),
            ),
          );
        });
  }

  Widget _buildOffstageNavigator(TabItem tabItem) {
    return Offstage(
      offstage: _currentTab != tabItem,
      child: TabNavigator(
        navigatorKey: _navigatorKeys[tabItem],
        tabItem: tabItem,
      ),
    );
  }
}
