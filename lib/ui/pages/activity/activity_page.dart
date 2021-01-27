import 'package:bounty_hub_client/ui/pages/activity/cubit/activity_cubit.dart';
import 'package:bounty_hub_client/ui/pages/activity/widgets/activity_item.dart';
import 'package:bounty_hub_client/ui/widgets/app_list_bottom_loader.dart';
import 'package:bounty_hub_client/ui/widgets/custom_appbar.dart';
import 'package:bounty_hub_client/ui/widgets/empty_data_place_holder.dart';
import 'package:bounty_hub_client/ui/widgets/settings_menu_dialog.dart';
import 'package:bounty_hub_client/utils/ui/colors.dart';
import 'package:bounty_hub_client/utils/ui/dimens.dart';
import 'package:bounty_hub_client/utils/ui/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActivitiesPage extends StatefulWidget {

  @override
  _ActivitiesPageState createState() => _ActivitiesPageState();
}

class _ActivitiesPageState extends State<ActivitiesPage> {
  final _scrollController = ScrollController();
  ActivityCubit _cubit;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _cubit = context.bloc<ActivityCubit>();
    _cubit.fetchActivities();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackgroundColor,
      appBar: CustomAppBar(
        //leftIcon: 'assets/images/filter.png',
        rightIcon: 'assets/images/settings.png',
        title: 'Activity',
        onLeftIconClick: () {},
        onRightIconClick: () {
          SettingsMenuDialog.show(context, () {});
        },
      ),
      body: BlocConsumer<ActivityCubit, ActivityState>(
        listener: (context, state) {
          if (!state.hasReachedMax && _isBottom) {
            _cubit.fetchActivities();
          }
        }, builder: (context, state) {
          switch (state.status) {
            case ActivityStatus.failure:
              return const EmptyDataPlaceHolder();
            case ActivityStatus.success:
              if (state.activities.isEmpty) {
                return const EmptyDataPlaceHolder();
              }
              return Container(
                margin: EdgeInsets.only(
                  left: Dimens.content_padding,
                  right: Dimens.content_padding,
                  bottom: Dimens.content_internal_padding,
                ),
                decoration: WidgetsDecoration.appCardStyle(),
                child: ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    return index >= state.activities.length
                        ? state.activities.length > 10 ? BottomLoader() : SizedBox()
                        : ActivityItem(activity: state.activities[index]);
                  },
                  itemCount: state.hasReachedMax
                      ? state.activities.length
                      : state.activities.length + 1,
                  controller: _scrollController,
                ),
              );
            default:
              return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  void _onScroll() {
    if (_isBottom) {
      _cubit.fetchActivities();
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients)
      return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }
}
