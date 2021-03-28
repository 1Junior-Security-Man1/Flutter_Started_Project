import 'package:bounty_hub_client/ui/pages/tasks/widgets/tasks_list_item.dart';
import 'package:bounty_hub_client/ui/widgets/app_list_bottom_loader.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class NativeAdWidget extends StatelessWidget {
  final TasksListAdsStatus status;
  final NativeAd ad;

  const NativeAdWidget({Key key, this.status, this.ad}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (status == TasksListAdsStatus.success) {
      return Container(
          padding: EdgeInsets.only(left: 4.0),
          child: AdWidget(ad: ad),
          height: 72.0,
          alignment: Alignment.center);
    } else {
      return Container(
        height: 72.0,
        child: BottomLoader(),
      );
    }
  }
}
