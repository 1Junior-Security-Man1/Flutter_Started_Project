import 'package:bounty_hub_client/data/enums/user_task_status.dart';
import 'package:bounty_hub_client/utils/localization/app_localizations.dart';
import 'package:bounty_hub_client/utils/ui/colors.dart';
import 'package:bounty_hub_client/utils/ui/dimens.dart';
import 'package:flutter/material.dart';

class TaskStatusBar extends StatefulWidget {

  final double width;
  final double height;
  final UserTaskStatusType status;
  final int approveDate;
  final int confirmationDaysCount;

  const TaskStatusBar({Key key,
    this.width = double.infinity,
    this.height = Dimens.app_button_height,
    this.status = UserTaskStatusType.IN_PROGRESS,
    this.approveDate,
    this.confirmationDaysCount = 1,
  }) : super(key: key);

  @override
  _TaskStatusBarState createState() => _TaskStatusBarState();
}

class _TaskStatusBarState extends State<TaskStatusBar> {

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: Dimens.content_padding, right: Dimens.content_padding),
      width: widget.width,
      height: widget.height,
      child: buildBody(widget.status, widget.approveDate, widget.confirmationDaysCount),
    );
  }

  Row buildBody(UserTaskStatusType status, int approveDate, int confirmationDaysCount) {
    int currentStep = getCurrentStepByStatus(status, approveDate, confirmationDaysCount);
    List<Widget> rows = [];
    for(int step = 1; step <= 5; step++) {
      if(step != 1) {
        rows.add(SizedBox(width: 8.0));
      }
      if(step == currentStep) {
        rows.add(_buildCurrentStepWidget(status, step));
      } else {
        rows.add(_buildStepWidget(step));
      }
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: rows,
    );
  }

  Widget _buildCurrentStepWidget(UserTaskStatusType status, int step) {
    return Container(
      width: 150,
      height: widget.height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: getStepWidgetColor(status, step),
        ),
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
      ),
      child: Center(
          child: Text(getStepWidgetTitle(context, status, step),
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Colors.white
            ),
          )),
    );
  }

  Widget _buildStepWidget(int step) {
    return Expanded(
      child: Container(
            height: widget.height,
            decoration: BoxDecoration(
              color: AppColors.stepTextColor,
              borderRadius: BorderRadius.all(Radius.circular(12.0)),
            ),
        child: Center(
            child: Text(step.toString(),
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: AppColors.progressTextColor,
              ),
            )),
      ),
    );
  }

  String getStepWidgetTitle(BuildContext context, UserTaskStatusType status, int step) {
    switch(step) {
      case 1: return step.toString() + ' ' + Strings.of(context).get('in_progress');
      case 2: return step.toString() + ' ' + Strings.of(context).get('verifying');
      case 3: return status == UserTaskStatusType.APPROVED ? step.toString() + ' ' + Strings.of(context).get('approved') : step.toString() + ' ' + Strings.of(context).get('rejected');
      case 4: return step.toString() + ' ' + Strings.of(context).get('re_confirm');
      case 5: return status == UserTaskStatusType.PAID ? step.toString() + ' ' + Strings.of(context).get('paid') : step.toString() + ' ' + Strings.of(context).get('canceled');
      default:
        return Strings.of(context).get('');
    }
  }

  List<Color> getStepWidgetColor(UserTaskStatusType status, int step) {
    switch(step) {
      case 1: return <Color>[Color(0xff9271FF), Color(0xff67A3F7)];
      case 2: return <Color>[Color(0xff6299E4), Color(0xff6AD7F7)];
      case 3: return status == UserTaskStatusType.APPROVED ? <Color>[Color(0xff64a8ee), Color(0xff55c8b4)] : <Color>[Colors.red[600], Colors.red[400]];
      case 4: return <Color>[Color(0xffFFC171), Color(0xffE6E63F)];
      case 5: return status == UserTaskStatusType.PAID ? <Color>[Color(0xff7BD66A), Color(0xffCFD94B)] : <Color>[Colors.red[600], Colors.red[400]];
      default:
        return <Color>[AppColors.primaryColor, AppColors.accentColor];
    }
  }

  int getCurrentStepByStatus(UserTaskStatusType status, int approveDate, int confirmationDaysCount) {
    switch(status) {
      case UserTaskStatusType.IN_PROGRESS:
        return 1;
      case UserTaskStatusType.VERIFYING:
        return 2;
      case UserTaskStatusType.REJECTED:
        return 3;
      case UserTaskStatusType.APPROVED:
        return checkIfTaskReadyToReconfirm(approveDate, confirmationDaysCount) ? 4 : 3;
      case UserTaskStatusType.PAID:
      case UserTaskStatusType.CANCELED:
        return 5;
      default:
        return 1;
    }
  }

  bool checkIfTaskReadyToReconfirm(int approveDate, int confirmationDaysCount) {
    var now = new DateTime.now();
    var duration = new Duration(days : confirmationDaysCount);
    var approveDateTime = DateTime.fromMillisecondsSinceEpoch(approveDate);
    approveDateTime = approveDateTime.add(duration);
    return now.isAfter(approveDateTime);
  }
}