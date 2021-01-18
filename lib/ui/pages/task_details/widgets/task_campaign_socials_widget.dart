import 'package:bounty_hub_client/data/models/entity/campaign/campaign.dart';
import 'package:bounty_hub_client/ui/pages/task_details/widgets/task_ui_utils.dart';
import 'package:bounty_hub_client/ui/widgets/social_image.dart';
import 'package:flutter/material.dart';

class CampaignSocialsWidget extends StatelessWidget {

  final Campaign campaign;

  const CampaignSocialsWidget({Key key, this.campaign}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var socials = List<Widget>();
    socials.add(SizedBox(width: 8.0));

    if(campaign != null) {
      campaign.socials.forEach((social) {
        socials.add(GestureDetector(
          onTap: () {
            launchURL(social.link);
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
}