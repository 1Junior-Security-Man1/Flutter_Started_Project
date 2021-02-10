import 'package:bounty_hub_client/data/models/entity/task/task.dart';
import 'package:bounty_hub_client/ui/pages/task_details/task_details_page.dart';
import 'package:bounty_hub_client/ui/widgets/social_image.dart';
import 'package:bounty_hub_client/utils/ui/colors.dart';
import 'package:bounty_hub_client/utils/ui/dimens.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TasksListItem extends StatelessWidget {
  const TasksListItem({Key key, @required this.task}) : super(key: key);

  final Task task;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        child: Container(
          height: 80,
          child: ListTile(
            hoverColor: Colors.transparent,
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => TaskDetailsPage(title: task.productName, taskId: task.id)
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
              child:  buildSocialImage(task.getSocialNetwork()),
            ),
            trailing: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: <Color>[AppColors.primarySwatch, AppColors.secondaryColor],
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 2.0, bottom: 2.0),
                    child: Text(
                      (task.finalRewardAmount ?? 0).toString() + ' ' + task.rewardCurrency,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w700
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text(
                    calculateUsdEquivalent(task.finalRewardAmount, task.usdEquivalent),
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: AppColors.currencyTextColor,
                        fontSize: 13,
                        fontWeight: FontWeight.w800
                    ),
                  ),
                ),
              ],
            ),
            title: Text(task.productName,
              style: TextStyle(
                  fontWeight: FontWeight.w500, fontSize: 13, color: AppColors.itemTextColor
              ),
            ),
            dense: true,
          ),
        ),
      ),
    );
  }
}

String calculateUsdEquivalent(double trxAmount, double equivalent) {
  double value = (trxAmount ?? 0) * (equivalent ?? 0);
  var usdEquivalent = NumberFormat.simpleCurrency(name: 'USD ').format(value);

  // If the equivalent value has 2 or more zero decimal digits
  if(usdEquivalent.contains('0.00')) {
    usdEquivalent = NumberFormat.simpleCurrency(decimalDigits: 4, name: 'USD ').format(value);
  }
  return '~' + usdEquivalent;
}