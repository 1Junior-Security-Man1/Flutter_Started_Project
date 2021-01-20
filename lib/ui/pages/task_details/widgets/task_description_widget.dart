import 'package:bounty_hub_client/data/models/entity/task/task.dart';
import 'package:bounty_hub_client/ui/pages/task_details/widgets/task_ui_utils.dart';
import 'package:bounty_hub_client/ui/widgets/social_image.dart';
import 'package:bounty_hub_client/utils/localization/localization.res.dart';
import 'package:bounty_hub_client/utils/ui/colors.dart';
import 'package:bounty_hub_client/utils/ui/dimens.dart';
import 'package:bounty_hub_client/utils/ui/styles.dart';
import 'package:bounty_hub_client/utils/validation/string_utils.dart';
import 'package:flutter/material.dart';

class TaskDescriptionWidget extends StatelessWidget {

  final Task task;

  const TaskDescriptionWidget({Key key, this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            child: buildSocialImage(task.getSocialNetwork()),
          ),
          SizedBox(
            height: 14.0,
          ),
          Material(
            type: MaterialType.transparency,
            child: InkWell(
              onTap: () {
                launchURL(checkNullString(task.checkLink));
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.socialLink,
                    style: TextStyle(
                      color: AppColors.itemTextColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    checkNullString(task.checkLink),
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
            AppStrings.instruction,
            style: TextStyle(
              color: AppColors.itemTextColor,
              fontWeight: FontWeight.w700,
              fontSize: 12,
            ),
          ),
          Text(
            checkNullString(task.description),
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
            AppStrings.cantDo,
            style: TextStyle(
              color: AppColors.itemTextColor,
              fontWeight: FontWeight.w700,
              fontSize: 12,
            ),
          ),
          Text(
            checkNullString(task.forbiddenDo),
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

}