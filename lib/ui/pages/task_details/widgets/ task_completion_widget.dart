import 'package:bounty_hub_client/data/enums/task_validation_type.dart';
import 'package:bounty_hub_client/data/models/entity/task/task.dart';
import 'package:bounty_hub_client/data/models/entity/user_task/user_task.dart';
import 'package:bounty_hub_client/ui/pages/task_details/cubit/task_details_cubit.dart';
import 'package:bounty_hub_client/ui/pages/task_details/cubit/task_details_state.dart';
import 'package:bounty_hub_client/ui/pages/task_details/widgets/task_ui_utils.dart';
import 'package:bounty_hub_client/ui/pages/task_details/widgets/task_verification_time_widget.dart';
import 'package:bounty_hub_client/ui/widgets/app_button.dart';
import 'package:bounty_hub_client/utils/ui/colors.dart';
import 'package:bounty_hub_client/utils/ui/dimens.dart';
import 'package:bounty_hub_client/utils/ui/styles.dart';
import 'package:bounty_hub_client/utils/ui/text_styles.dart';
import 'package:bounty_hub_client/utils/validation/string_utils.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TaskCompletionWidget extends StatefulWidget {

  final UserTask userTask;

  final Task task;

  const TaskCompletionWidget({Key key, this.userTask, this.task}) : super(key: key);

  @override
  TaskDetailsWidgetState createState() => TaskDetailsWidgetState();
}

class TaskDetailsWidgetState extends State<TaskCompletionWidget> {

  @override
  Widget build(BuildContext context) {
    return BlocListener<TaskDetailsCubit, TaskDetailsState>(
      listener: (context, state) {},
      child: BlocBuilder<TaskDetailsCubit, TaskDetailsState>(
        builder: (context, state) {
          switch(state.task.getTaskValidationType()) {
            case TaskValidationType.SOCIAL_PARSER:
              return _buildSocialParserCompletionUI();
            case TaskValidationType.AUTO_CHECK:
              return _buildAutoCheckCompletionUI();
            default:
              return _buildSocialParserCompletionUI();
          }
        },
      ),
    );
  }

  Widget _buildAutoCheckCompletionUI() {
    int currentUserTaskStep = getTaskCompletionStepByStatus(widget.userTask.getTaskStatus(), widget.userTask.approveDate, checkNullInt(widget.task.confirmationDaysCount, defaultValue: 1));
    switch(currentUserTaskStep) {
      case 1: return _buildLeaveCompleteWidget(); // IN_PROGRESS
      case 2: return _buildContinueButton(); // VERIFYING
      case 3: return _buildVerifyingWidget(AppColors.accentColor, widget.task.confirmationDaysCount); // APPROVED or REJECTED
      case 4: return _buildReconfirmWidget(); // RECONFIRM
      case 5: return _buildEmptySpaceWidget(); // PAID or CANCELED
      default:
        return _buildEmptySpaceWidget();
    }
  }

  Widget _buildSocialParserCompletionUI() {
    int currentUserTaskStep = getTaskCompletionStepByStatus(widget.userTask.getTaskStatus(), widget.userTask.approveDate, checkNullInt(widget.task.confirmationDaysCount, defaultValue: 1));
    switch(currentUserTaskStep) {
      case 1: return _buildLeaveCompleteWidget(); // IN_PROGRESS
      case 2: return _buildVerifyingWidget(AppColors.accentColor, checkNullInt(widget.task.confirmationDaysCount, defaultValue: 1)); // VERIFYING
      case 3: return _buildEmptySpaceWidget(); // APPROVED or REJECTED
      case 4: return _buildEmptySpaceWidget(); // RECONFIRM
      case 5: return _buildEmptySpaceWidget(); // PAID or CANCELED
      default:
        return _buildEmptySpaceWidget();
    }
  }

  Widget _buildLeaveCompleteWidget() {
    return Container(
      margin: EdgeInsets.only(left: Dimens.content_padding, right: Dimens.content_padding, bottom: Dimens.content_internal_padding),
      padding: EdgeInsets.all(Dimens.content_internal_padding),
      decoration: WidgetsDecoration.appCardStyle(),
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            'Complete Task',
            style: AppTextStyles.titleTextStyle,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 12.0,
          ),
          Text(
            getCompletingTaskInformation(widget.task),
            style: AppTextStyles.greyContentTextStyle,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: Dimens.content_internal_padding,
          ),
          AppButton(
            height: 50,
            type: AppButtonType.BLUE,
            text: 'Complete',
            width: MediaQuery.of(context).size.width / 2,
            onPressed: () {

            },
          ),
          SizedBox(
            height: 12.0,
          ),
          AppButton(
            height: 50,
            type: AppButtonType.WHITE,
            text: 'Leave',
            width: MediaQuery.of(context).size.width / 2,
            onPressed: () {

            },
          ),
        ],
      ),
    );
  }

  String getCompletingTaskInformation(Task parentTask) {
    switch(parentTask.getTaskValidationType()) {
      case TaskValidationType.AUTO_CHECK:
        return 'In order to have your task verifying, please login to ' + EnumToString.convertToString(parentTask.getSocialNetwork());
      case TaskValidationType.SOCIAL_PARSER:
        if(parentTask.brief != null && parentTask.brief.isNotEmpty) {
          return parentTask.brief;
        } else {
          return 'To complete task, please follow the "Instruction" section and then click "Complete" to confirm';
        }
        break;
      default:
        return '';
    }
  }

  Widget _buildContinueButton() {
    return Container(
      margin: EdgeInsets.only(left: Dimens.content_padding, right: Dimens.content_padding, bottom: Dimens.content_internal_padding),
      padding: EdgeInsets.all(Dimens.content_internal_padding),
      decoration: WidgetsDecoration.appCardStyle(),
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            'Continue Task',
            style: AppTextStyles.titleTextStyle,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 12.0,
          ),
          Text(
            getCompletingTaskInformation(widget.task),
            style: AppTextStyles.greyContentTextStyle,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: Dimens.content_internal_padding,
          ),
          AppButton(
            height: 50,
            type: AppButtonType.BLUE,
            text: 'Continue',
            width: MediaQuery.of(context).size.width / 2,
            onPressed: () {

            },
          ),
        ],
      ),
    );
  }

  Widget _buildReconfirmWidget() {
    return Container(
      margin: EdgeInsets.only(left: Dimens.content_padding, right: Dimens.content_padding, bottom: Dimens.content_internal_padding),
      padding: EdgeInsets.all(Dimens.content_internal_padding),
      decoration: WidgetsDecoration.appCardStyle(),
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            'Reconfirm Task',
            style: AppTextStyles.titleTextStyle,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 12.0,
          ),
          Text(
            getCompletingTaskInformation(widget.task),
            style: AppTextStyles.greyContentTextStyle,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: Dimens.content_internal_padding,
          ),
          AppButton(
            height: 50,
            type: AppButtonType.BLUE,
            text: 'Reconfirm',
            width: MediaQuery.of(context).size.width / 2,
            onPressed: () {

            },
          ),
        ],
      ),
    );
  }

  Widget _buildVerifyingWidget(Color backgroundColor, int confirmationDaysCount) {
    return Container(
      margin: EdgeInsets.only(left: Dimens.content_padding, right: Dimens.content_padding, bottom: Dimens.content_internal_padding),
      padding: EdgeInsets.all(Dimens.content_internal_padding),
      decoration: WidgetsDecoration.appCardStyle(),
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            'Verifying',
            style: AppTextStyles.titleTextStyle,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 12.0,
          ),
          Text(
            'Please wait till Your task will be verified',
            style: AppTextStyles.greyContentTextStyle,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: Dimens.content_internal_padding,
          ),
          Container(
            margin: EdgeInsets.only(left: 40, right: 40),
            padding: EdgeInsets.all(Dimens.content_padding),
            decoration: BoxDecoration(
              color: AppColors.verificationTimerColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child:  CountdownTimer(
              textBefore: Text('Time to check: '),
              endTime: getTaskVerificationTime(checkNullInt(widget.task.confirmationDaysCount, defaultValue: 1),
                  widget.userTask.approveDate != null ? widget.userTask.approveDate : widget.userTask.lastModifiedDate),
              textStyle: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w400),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildEmptySpaceWidget() {
    return SizedBox();
  }
}