import 'package:bounty_hub_client/data/models/entity/user_task/user_task.dart';
import 'package:bounty_hub_client/ui/pages/task_details/view/task_details_page.dart';
import 'package:bounty_hub_client/ui/widgets/social_image.dart';
import 'package:bounty_hub_client/utils/ui/colors.dart';
import 'package:bounty_hub_client/utils/ui/dimens.dart';
import 'package:flutter/material.dart';

class MyTaskItem extends StatelessWidget {
  const MyTaskItem({Key key, @required this.task}) : super(key: key);

  final UserTask task;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        child: ListTile(
          hoverColor: Colors.transparent,
          onTap: () {
            Navigator.push(context, MaterialPageRoute(
                builder: (context) => TaskDetailsPage(title: task.productName, taskId: task.itemId)
            )
            );
          },
          contentPadding: EdgeInsets.only(left: Dimens.content_padding, right: Dimens.content_padding, top: 12.0, bottom: 12.0),
          leading: Container(
            decoration: BoxDecoration(
              color: AppColors.secondaryColor,
              shape: BoxShape.circle,
            ),
            width: 48,
            height: 48,
            alignment: Alignment.center,
            child: buildSocialImage(task.getSocialNetwork()),
          ),
          trailing: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[AppColors.primarySwatch, AppColors.secondaryColor],
              ),
              borderRadius: BorderRadius.all(Radius.circular(12.0)),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 4.0, right: 4.0, top: 2.0, bottom: 2.0),
              child: Text(
                task.finalRewardAmount.toString() + ' ' + task.rewardCurrency,
                overflow: TextOverflow.ellipsis,
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
        ),
      ),
    );
  }
}