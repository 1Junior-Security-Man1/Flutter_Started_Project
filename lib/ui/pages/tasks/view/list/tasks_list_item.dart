import 'package:bounty_hub_client/data/models/entity/task.dart';
import 'package:bounty_hub_client/utils/ui/colors.dart';
import 'package:bounty_hub_client/utils/ui/dimens.dart';
import 'package:flutter/material.dart';

class TasksListItem extends StatelessWidget {
  const TasksListItem({Key key, @required this.task}) : super(key: key);

  final Task task;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.only(left: Dimens.content_padding, right: Dimens.content_padding, top: 12.0, bottom: 12.0),
      leading: Container(
        decoration: BoxDecoration(
          color: AppColors.accentColor,
          shape: BoxShape.circle,
        ),
        width: 48,
        height: 48,
        alignment: Alignment.center,
      ),
      trailing: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[AppColors.primarySwatch, AppColors.accentColor],
          ),
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 4.0, right: 4.0, top: 2.0, bottom: 2.0),
          child: Text(
            task.finalRewardAmount.toString(),
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w700
            ),
          ),
        ),
      ),
      title: Text(task.productName,
        style: TextStyle(
            fontWeight: FontWeight.w500, fontSize: 13, color: AppColors.itemTextColor
        ),
      ),
      dense: true,
    );
  }
}