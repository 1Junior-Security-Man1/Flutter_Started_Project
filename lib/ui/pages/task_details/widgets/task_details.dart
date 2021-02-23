import 'dart:async';
import 'package:bounty_hub_client/bloc/auth/authorization_bloc.dart';
import 'package:bounty_hub_client/ui/pages/my_tasks/cubit/my_tasks_cubit.dart';
import 'package:bounty_hub_client/ui/pages/task_details/cubit/task_details_cubit.dart';
import 'package:bounty_hub_client/ui/pages/task_details/cubit/task_details_state.dart';
import 'package:bounty_hub_client/ui/pages/task_details/widgets/add_dialogs.dart';
import 'package:bounty_hub_client/ui/pages/task_details/widgets/task_budget_widget.dart';
import 'package:bounty_hub_client/ui/pages/task_details/widgets/task_campaign_socials_widget.dart';
import 'package:bounty_hub_client/ui/pages/task_details/widgets/task_completion_widget.dart';
import 'package:bounty_hub_client/ui/pages/task_details/widgets/task_description_widget.dart';
import 'package:bounty_hub_client/ui/pages/task_details/widgets/task_header_widget.dart';
import 'package:bounty_hub_client/ui/pages/task_details/widgets/task_status_widget.dart';
import 'package:bounty_hub_client/ui/pages/tasks_list/cubit/tasks_list_cubit.dart';
import 'package:bounty_hub_client/ui/widgets/app_alert.dart';
import 'package:bounty_hub_client/ui/widgets/app_button.dart';
import 'package:bounty_hub_client/ui/widgets/app_progress_bar.dart';
import 'package:bounty_hub_client/ui/widgets/empty_data_place_holder.dart';
import 'package:bounty_hub_client/utils/localization/localization.res.dart';
import 'package:bounty_hub_client/utils/ui/colors.dart';
import 'package:bounty_hub_client/utils/ui/dimens.dart';
import 'package:bounty_hub_client/utils/ui/styles.dart';
import 'package:bounty_hub_client/utils/ui/text_styles.dart';
import 'package:bounty_hub_client/utils/validation/string_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:uni_links/uni_links.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;

class TaskDetailsWidget extends StatefulWidget {
  final String taskId;
  final String title;

  const TaskDetailsWidget(this.taskId, this.title);

  @override
  TaskDetailsWidgetState createState() => TaskDetailsWidgetState();
}

class TaskDetailsWidgetState extends State<TaskDetailsWidget> {
  TaskDetailsCubit _cubit;
  TasksListCubit _tasksListCubit;
  MyTasksCubit _myTasksListCubit;
  var logger = Logger();
  StreamSubscription _sub;

  @override
  void initState() {
    super.initState();
    _cubit = context.bloc<TaskDetailsCubit>();
    _tasksListCubit = context.bloc<TasksListCubit>();
    _myTasksListCubit = context.bloc<MyTasksCubit>();
    _cubit.fetchTask(widget.taskId);
    initPlatformState();
  }

  initPlatformState() async {
    await initPlatformStateForUniLinks();
  }

  initPlatformStateForUniLinks() async {
    _sub = getLinksStream().listen((String link) {
      _cubit.onOpenedFromDeepLinkEvent(widget.taskId);
      launcher.closeWebView();
    }, onError: (err) {
      logger.e('initPlatformStateForUniLinks $err');
    });
  }

  @override
  Widget build(BuildContext context) {
    //todo использовать BlocConsumer
    return BlocListener<TaskDetailsCubit, TaskDetailsState>(
      listener: (context, state) {
        if (state.userTaskStatus == UserTaskStatus.failure ||
            state.status == TaskDetailsStatus.failure) {
          showDialog(
            context: context,
            builder: (_) => AnimatedAlertBuilder(
                message: state.errorMessage != null
                    ? state.errorMessage
                    : AppStrings.defaultErrorMessage),
          );
        }

        if (state.userTaskStatus == UserTaskStatus.take_success ||
            state.userTaskStatus == UserTaskStatus.leave_success) {
          _myTasksListCubit.refresh();
          _tasksListCubit.refresh();
        }

        if (state.userTaskStatus == UserTaskStatus.confirm_success) {
          _cubit.fetchUserTask(widget.taskId);
          _tasksListCubit.refresh();
          if (state.link != null && state.link.isNotEmpty) {
            showSocialAccountAuthorizationDialog(state.link, false);
          }
        }

        if (state.userTaskStatus == UserTaskStatus.reconfirm) {
          showSocialAccountAuthorizationDialog(state.link, true);
        }

          if(state.action == UserAction.logout) {
            showConfirmActionDialog(context, AppStrings.toEarn + ' ' + (state.task?.finalRewardAmount ?? 0.0).toString() + ' ' + state.task?.rewardCurrency + ' ' + AppStrings.pleaseLogIn, () {
              logout(context);
            }, () {
              Navigator.of(context).pop();
            });
          }
        },
        child: BlocBuilder<TaskDetailsCubit, TaskDetailsState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: _buildContent(context, state),
            );
          },
        ),
    );
  }

  void showSocialAccountAuthorizationDialog(String authLink, bool reconfirm) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (builder) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter state) {
                return Container(
                  height: 300,
                  color: Colors.transparent,
                  child: Container(
                    padding: EdgeInsets.only(left: 36.0, right: 36.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: new BorderRadius.only(
                            topLeft: const Radius.circular(Dimens.app_bottom_dialog_border_radius),
                            topRight: const Radius.circular(Dimens.app_bottom_dialog_border_radius))),
                    child: Form(
                      child: ListView(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 24.0),
                            child: Text(
                                AppStrings.bountyCheckingProcedure,
                              style: AppTextStyles.titleTextStyle,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 16.0),
                            child: Container(
                              child: Text(
                                AppStrings.authorizeWithSocialInstruction,
                                style: AppTextStyles.greyContentTextStyle,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 24.0, bottom: 200),
                            child: Center(
                              child: AppButton(
                                height: 50,
                                type: AppButtonType.BLUE,
                                text: AppStrings.authorize,
                                width: MediaQuery.of(context).size.width / 2,
                                onPressed: () async {
                                  Navigator.of(context).pop();
                                  _cubit.onSocialAccountAuthorization(reconfirm);
                                  if (await canLaunch(authLink)) {
                                    await launch(authLink);
                                  }
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              });
        }
    );
  }

  _buildContent(BuildContext context, TaskDetailsState state) {
    if (state.status == TaskDetailsStatus.loading) {
      return Loading();
    } else if (state.status == TaskDetailsStatus.success ||
        state.userTaskStatus == UserTaskStatus.fetch_success) {
      return SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 8.0),
              height: 300,
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        left: Dimens.content_padding,
                        right: Dimens.content_padding,
                        bottom: Dimens.content_internal_padding,
                        top: Dimens.content_padding),
                    decoration: WidgetsDecoration.appCardStyle(),
                  ),
                  TaskHeaderWidget(campaign: state.campaign),
                  Container(
                    alignment: Alignment.topCenter,
                    margin: EdgeInsets.only(
                        top: 120.0,
                        left: Dimens.content_padding,
                        right: Dimens.content_padding,
                        bottom: Dimens.content_padding),
                    child: Column(
                      children: [
                        CampaignSocialsWidget(campaign: state.campaign),
                        TaskBudgetWidget(task: state.task),
                        TaskStatusWidget(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            state.task != null && state.userTask != null && !state.refresh
                ? TaskCompletionWidget(
                    task: state.task, userTask: state.userTask)
                : SizedBox(),
            Container(
              padding: EdgeInsets.only(
                  left: Dimens.content_padding, right: Dimens.content_padding),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      alignment: Alignment.center,
                      height: 85,
                      decoration: WidgetsDecoration.appCardStyle(),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/money.png',
                            width: 34,
                            height: 34,
                          ),
                          SizedBox(width: 8.0),
                          Flexible(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  checkNullDouble(state.task.bhtAmount)
                                          .toString() +
                                      ' BHT',
                                  style: TextStyle(
                                    color: AppColors.currencyTextColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  checkNullDouble(state.task.finalRewardAmount)
                                          .toString() +
                                      ' ' +
                                      state.task.rewardCurrency,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: AppColors.currencyTextColor,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: Dimens.content_internal_padding,
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      alignment: Alignment.center,
                      height: 85,
                      decoration: WidgetsDecoration.appCardStyle(),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/participants.png',
                            width: 34,
                            height: 34,
                          ),
                          SizedBox(width: 8.0),
                          Flexible(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  AppStrings.participants,
                                  style: TextStyle(
                                    color: AppColors.participantsTextColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  checkNullInt(state.task.participants)
                                          .toString() +
                                      ' / ∞',
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: AppColors.participantsTextColor,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            TaskDescriptionWidget(task: state.task),
          ],
        ),
      );
    } else {
      return EmptyDataPlaceHolder(message: AppStrings.emptyTaskMessage);
    }
  }

  @override
  void dispose() {
    if (_sub != null) _sub.cancel();
    super.dispose();
  }
}
