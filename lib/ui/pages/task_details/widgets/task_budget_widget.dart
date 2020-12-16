import 'package:bounty_hub_client/data/models/entity/task/task.dart';
import 'package:bounty_hub_client/ui/pages/task_details/widgets/task_ui_utils.dart';
import 'package:bounty_hub_client/utils/localization/localization.res.dart';
import 'package:bounty_hub_client/utils/ui/colors.dart';
import 'package:bounty_hub_client/utils/ui/dimens.dart';
import 'package:bounty_hub_client/utils/validation/string_utils.dart';
import 'package:flutter/material.dart';

class TaskBudgetWidget extends StatelessWidget {

  final Task task;

  const TaskBudgetWidget({Key key, this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  AppColors.stepTextColor,
                ),
                value: calculateLeftBudgetPercentage(task) / 100,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  checkNullDouble(task.leftBudget).toStringAsFixed(0) + ' ' + checkNullString(task.rewardCurrency),
                  style: TextStyle(
                    color: AppColors.progressTextColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 11,
                  ),
                ),
                Text(
                  checkNullDouble(task.budget).toStringAsFixed(0) + ' ' + checkNullString(task.rewardCurrency),
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
                  calculateLeftBudgetPercentage(task).toString() + '%',
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
                  AppStrings.budgetLeft,
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
}