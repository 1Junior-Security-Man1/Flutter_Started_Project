import 'package:bounty_hub_client/network/download/image_url_provider.dart';
import 'package:bounty_hub_client/ui/pages/task_details/task_details_cubit.dart';
import 'package:bounty_hub_client/ui/pages/task_details/task_details_state.dart';
import 'package:bounty_hub_client/ui/widgets/app_alert.dart';
import 'package:bounty_hub_client/ui/widgets/app_button.dart';
import 'package:bounty_hub_client/ui/widgets/app_progress_bar.dart';
import 'package:bounty_hub_client/ui/widgets/empty_data_place_holder.dart';
import 'package:bounty_hub_client/ui/widgets/social_image.dart';
import 'package:bounty_hub_client/ui/widgets/task_status_bar.dart';
import 'package:bounty_hub_client/utils/localization/app_localizations.dart';
import 'package:bounty_hub_client/utils/ui/colors.dart';
import 'package:bounty_hub_client/utils/ui/dimens.dart';
import 'package:bounty_hub_client/utils/ui/styles.dart';
import 'package:bounty_hub_client/utils/validation/string_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TaskDetailsContent extends StatefulWidget {
  final String taskId;
  final String title;

  const TaskDetailsContent(this.taskId, this.title);

  @override
  TaskDetailsContentState createState() => TaskDetailsContentState();
}

class TaskDetailsContentState extends State<TaskDetailsContent> {
  TaskDetailsCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = context.bloc<TaskDetailsCubit>();
    _cubit.fetchTask(widget.taskId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TaskDetailsCubit, TaskDetailsState>(
      listener: (context, state) {
        if (state.userTaskStatus == UserTaskStatus.take_failure) {
          showDialog(
            context: context,
            builder: (_) => AnimatedAlertBuilder(message: state.errorMessage != null ? state.errorMessage : Strings.of(context).get('default_error_message')),
          );
        }
      },
      child: BlocBuilder<TaskDetailsCubit, TaskDetailsState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: _buildUI(context, state),
          );
        },
      ),
    );
  }

  _buildUI(BuildContext context, TaskDetailsState state) {
    if(state.status == TaskDetailsStatus.loading) {
      return Loading();
    } else if(state.status == TaskDetailsStatus.success) {
      return _buildContent(state);
    } else {
      return EmptyDataPlaceHolder();
    }
  }

  StatelessWidget _buildContent(TaskDetailsState state) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 8.0),
            height: 300,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Container(
                  margin: EdgeInsets.only(left: Dimens.content_padding, right: Dimens.content_padding, bottom: Dimens.content_internal_padding, top: Dimens.content_padding),
                  decoration: WidgetsDecoration.appCardStyle(),
                ),
                _buildHeader(state),
                Container(
                  alignment: Alignment.topCenter,
                  margin: EdgeInsets.only(top: 120.0, left: Dimens.content_padding, right: Dimens.content_padding, bottom: Dimens.content_padding),
                  child: Column(
                    children: [
                      _buildCampaignSocials(state),
                      _buildTaskBudget(state),
                      _buildTaskStatus(),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: Dimens.content_padding, right: Dimens.content_padding),
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
                        Image.asset('assets/images/money.png',
                          width: 34,
                          height: 34,
                        ),
                        SizedBox(width: 8.0),
                        Flexible(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(checkNullDouble(state.task.bhtAmount).toString() + ' BHT',
                                style: TextStyle(
                                  color: AppColors.currencyTextColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                ),
                              ),
                              Text(checkNullDouble(state.task.finalRewardAmount).toString() + ' ' + state.task.rewardCurrency,
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
                        Image.asset('assets/images/participants.png',
                          width: 34,
                          height: 34,
                        ),
                        SizedBox(width: 8.0),
                        Flexible(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(Strings.of(context).get('participants'),
                                style: TextStyle(
                                  color: AppColors.participantsTextColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                ),
                              ),
                              Text(checkNullInt(state.task.participants).toString() + ' / ∞',
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
          _buildTaskDescription(state),
        ],
      ),
    );
  }

  Container _buildHeader(TaskDetailsState state) {
    return Container(
      alignment: Alignment.topCenter,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 7,
                  blurRadius: 7,
                  offset: Offset(0, 5),
                ),
              ],
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30.0),
              child: state.campaign != null && state.campaign.coverId != null ?
              Image.network(getImageUrl(checkNullString(state.campaign.coverId)),
                height: 95,
                width: 95,
              ) : Image.asset('assets/images/empty_campaign_logo.png',
                height: 95,
                width: 95,),
            ),
          ),
        ],
      ),
    );
  }

  Row _buildCampaignSocials(TaskDetailsState state) {
    var socials = List<Widget>();
    socials.add(SizedBox(width: 8.0));

    if(state.campaign != null) {
      state.campaign.socials.forEach((social) {
        socials.add(GestureDetector(
          onTap: () {
            _cubit.launchURL(social.link);
          },
          child: Container(
            width: 22.0,
            height: 22.0,
            child: buildSocialImage(social.getSocialNetwork()),
          ),
        ));
        socials.add(SizedBox(width: 8.0));
      });
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: socials,
    );
  }

  Widget _buildTaskStatus() {
    return BlocBuilder<TaskDetailsCubit, TaskDetailsState>(
      builder: (context, state) {
        if(state.userTaskStatus == UserTaskStatus.loading) {
          return Loading();
        } else if(state.userTaskStatus == UserTaskStatus.success && state.userTask != null) {
          return TaskStatusBar(
            status: state.userTask.getTaskStatus(),
            approveDate: checkNullInt(state.userTask.approveDate),
            confirmationDaysCount: checkNullInt(state.userTask.confirmationDaysCount, defaultValue: 1),
            height: Dimens.app_button_height,
          );
        } else {
          return AppButton(
            decoration: WidgetsDecoration.appButtonStyle(),
            text: Strings.of(context).get('take_task'),
            width: MediaQuery.of(context).size.width / 2 - 20,
            height: Dimens.app_button_height,
            textColor: Colors.white,
            onPressed: () {
              _cubit.onTakeTaskClick();
            },
          );
        }
      }
    );
  }

  Container _buildTaskDescription(TaskDetailsState state) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(Dimens.content_padding),
      margin: EdgeInsets.only(left: Dimens.content_padding, right: Dimens.content_padding, top: Dimens.content_internal_padding, bottom: Dimens.content_internal_padding),
      decoration: WidgetsDecoration.appCardStyle(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 22,
            height: 22,
            child: buildSocialImage(state.task.getSocialNetwork()),
          ),
          SizedBox(
            height: 14.0,
          ),
          Material(
            type: MaterialType.transparency,
            child: InkWell(
              onTap: () {
                _cubit.launchURL(checkNullString(state.task.checkLink));
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    Strings.of(context).get('social_link'),
                    style: TextStyle(
                      color: AppColors.itemTextColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    checkNullString(state.task.checkLink),
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: AppColors.itemTextColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 8.0,
          ),
          Text(
            Strings.of(context).get('instruction'),
            style: TextStyle(
              color: AppColors.itemTextColor,
              fontWeight: FontWeight.w700,
              fontSize: 12,
            ),
          ),
          Text(
            checkNullString(state.task.description),
            style: TextStyle(
              color: AppColors.itemTextColor,
              fontWeight: FontWeight.w500,
              fontSize: 12,
            ),
          ),
          SizedBox(
            height: 8.0,
          ),
          Text(
            Strings.of(context).get('cant_do'),
            style: TextStyle(
              color: AppColors.itemTextColor,
              fontWeight: FontWeight.w700,
              fontSize: 12,
            ),
          ),
          Text(
            checkNullString(state.task.forbiddenDo),
            style: TextStyle(
              color: AppColors.itemTextColor,
              fontWeight: FontWeight.w500,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Container _buildTaskBudget(TaskDetailsState state) {
    return Container(
      margin: EdgeInsets.all(Dimens.content_padding),
      child: Stack(
        children: [
          Container(
            height: 6,
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              child: LinearProgressIndicator(
                backgroundColor: AppColors.primaryColor,
                valueColor: AlwaysStoppedAnimation<Color>(
                  AppColors.progressBackgroundColor,
                ),
                value: calculateLeftBudgetPercentage(state) / 100,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  checkNullDouble(state.task.leftBudget).toStringAsFixed(0) + ' ' + checkNullString(state.task.rewardCurrency),
                  style: TextStyle(
                    color: AppColors.progressTextColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 11,
                  ),
                ),
                Text(
                  checkNullDouble(state.task.budget).toStringAsFixed(0) + ' ' + checkNullString(state.task.rewardCurrency),
                  style: TextStyle(
                    color: AppColors.accentColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  calculateLeftBudgetPercentage(state).toString() + '%',
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
                SizedBox(
                  width: 8.0,
                ),
                Text(
                  Strings.of(context).get('budget_left'),
                  style: TextStyle(
                    color: AppColors.progressTextColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  int calculateLeftBudgetPercentage(TaskDetailsState state) {
    return (checkNullDouble(state.task.leftBudget) * 100) ~/ checkNullDouble(state.task.budget);
  }
}