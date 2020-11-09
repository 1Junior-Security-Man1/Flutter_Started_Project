import 'package:bounty_hub_client/data/models/entity/campaign/campaign.dart';
import 'package:bounty_hub_client/network/download/image_url_provider.dart';
import 'package:bounty_hub_client/utils/validation/string_utils.dart';
import 'package:flutter/material.dart';

class TaskHeaderWidget extends StatelessWidget {

  final Campaign campaign;

  const TaskHeaderWidget({Key key, this.campaign}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              child: campaign != null && campaign.coverId != null ?
              Image.network(getImageUrl(checkNullString(campaign.coverId)),
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

}