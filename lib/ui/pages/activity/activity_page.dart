import 'package:bounty_hub_client/data/models/entity/activity/notification.dart';
import 'package:bounty_hub_client/ui/pages/activity/cubit/activity_cubit.dart';
import 'package:bounty_hub_client/ui/widgets/custom_appbar.dart';
import 'package:bounty_hub_client/utils/ui/colors.dart';
import 'package:bounty_hub_client/utils/ui/styles.dart';
import 'package:bounty_hub_client/utils/ui/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';

class ActivitiesPage extends StatefulWidget {
  @override
  _ActivitiesPageState createState() => _ActivitiesPageState();
}

class _ActivitiesPageState extends State<ActivitiesPage> {
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(_scrollListener);

    Future.microtask(
        () => BlocProvider.of<ActivityCubit>(context).loadActivities());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackgroundColor,
      appBar: CustomAppBar(
        leftIcon: 'assets/images/filter.png',
        rightIcon: 'assets/images/settings.png',
        title: 'Activity',
        onLeftIconClick: () {},
        onRightIconClick: () {},
      ),
      body: BlocBuilder<ActivityCubit, ActivityState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: ListView.builder(
                controller: _scrollController,
                itemBuilder: (context, index) {
                  var formatter = new DateFormat('dd-MM-yyyy');
                  var date = formatter.format(
                      DateTime.fromMillisecondsSinceEpoch(
                          state.activities[index].updated));
                  return _buildActivityItem(
                      context, state.activities[index], date);
                },
                physics: BouncingScrollPhysics(),
                itemCount: state.activities.length,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildActivityItem(
      BuildContext context, Activity activity, String date) {
    return Stack(
      alignment: Alignment.centerLeft,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 20,
          ),
          child: Container(
            height: 45,
            width: 45,
            decoration: WidgetsDecoration.appBlueButtonStyle(),
            child: Center(
                child: Image.asset(
              activity.action == 'ITEM_RECONFIRMATION'
                  ? 'assets/images/menu_item_tasks_active.png'
                  : 'assets/images/menu_item_notification_active.png',
              color: Colors.white,
              height: 24,
              width: 24,
            )),
          ),
        ),
        Material(
          color: Colors.transparent,
          child: InkWell(
            highlightColor: Colors.black12,
            splashColor: Colors.black12,
            onTap: () {
              //TODO роут по уведомлению
            },
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10, top: 10),
              child: Container(
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 20,
                        right: 15,
                      ),
                      child: Container(
                        height: 45,
                        width: 45,
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width - 219,
                      child: Html(
                        renderNewlines: true,
                        data: activity.content,
                        defaultTextStyle: AppTextStyles.defaultText.copyWith(
                            fontWeight: FontWeight.w600, fontSize: 12),
                        onLinkTap: (link) {},
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: Container(
                        child: Text(
                          date,
                          style: AppTextStyles.defaultThinText,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  _scrollListener() async {
    if (_scrollController.position.pixels >
        _scrollController.position.maxScrollExtent - 100) {
      BlocProvider.of<ActivityCubit>(context).loadActivities();
    }
  }
}
