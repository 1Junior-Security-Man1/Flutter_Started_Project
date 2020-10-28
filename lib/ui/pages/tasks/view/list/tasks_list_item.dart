import 'package:bounty_hub_client/data/enums/social_networks_types.dart';
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
          color: AppColors.secondaryColor,
          shape: BoxShape.circle,
        ),
        width: 48,
        height: 48,
        alignment: Alignment.center,
        child:  _buildTaskImage(task.getSocialNetwork()),
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
            task.finalRewardAmount.toString(),
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
    );
  }

  Image _buildTaskImage(SocialNetworkType socialNetworkType) {
    switch (socialNetworkType) {
      case SocialNetworkType.FACEBOOK:
        return Image.asset('assets/images/facebook.png');
      case SocialNetworkType.VK:
        return Image.asset('assets/images/vk.png');
      case SocialNetworkType.TWITTER:
        return Image.asset('assets/images/twitter.png');
      case SocialNetworkType.MEDIUM:
        return Image.asset('assets/images/medium.png');
      case SocialNetworkType.TELEGRAM:
        return Image.asset('assets/images/telegram.png');
      case SocialNetworkType.INSTAGRAM:
        return Image.asset('assets/images/instagram.png');
      case SocialNetworkType.LINKEDIN:
        return Image.asset('assets/images/linkedin.png');
      case SocialNetworkType.YOUTUBE:
        return Image.asset('assets/images/youtube.png');
      default:
        return Image.asset('assets/images/other.png');
    }
  }
}