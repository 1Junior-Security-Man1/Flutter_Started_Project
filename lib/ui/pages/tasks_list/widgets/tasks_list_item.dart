import 'package:bounty_hub_client/data/models/entity/task/task.dart';
import 'package:bounty_hub_client/ui/pages/task_details/task_details_page.dart';
import 'package:bounty_hub_client/ui/widgets/social_image.dart';
import 'package:bounty_hub_client/utils/ui/colors.dart';
import 'package:bounty_hub_client/utils/ui/dimens.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:bounty_hub_client/data/models/entity/task/base_task.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:bounty_hub_client/utils/ads/ad_helper.dart';

class TasksListItem extends StatefulWidget {
  const TasksListItem({Key key, @required this.task, this.index}) : super(key: key);

  final Task task;
  final int index;

  @override
  _TasksListItemState createState() => _TasksListItemState();
}

class _TasksListItemState extends State<TasksListItem> with AutomaticKeepAliveClientMixin {

  NativeAd _ad;
  bool _isAdLoaded = false;

  @override
  void initState() {
    super.initState();
    createNativeAd();
  }

  void createNativeAd() {
    _ad = NativeAd(
      adUnitId: AdHelper.tasksNativeAdUnitId,
      factoryId: 'listTile',
      request: AdRequest(),
      listener: AdListener(
        onAdLoaded: (_) {
          setState(() {
            _isAdLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
        },
      ),
    );

    if((widget.index + 1) % AdHelper.nativeAdStep == 0) {
      _ad.load();
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        child: Container(
          child: Column(
            children: [
              ListTile(
                hoverColor: Colors.transparent,
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => TaskDetailsPage(title: widget.task.productName, taskId: widget.task.id)
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
                  child:  buildSocialImage(widget.task.getSocialNetwork()),
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
                          (widget.task.finalRewardAmount ?? widget.task.rewardAmount ?? 0).toString() + ' ' + widget.task.rewardCurrency,
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
                        calculateUsdEquivalent(widget.task),
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
                title: Text(widget.task.productName,
                  style: TextStyle(
                      fontWeight: FontWeight.w500, fontSize: 13, color: AppColors.itemTextColor
                  ),
                ),
                dense: true,
              ),
              getNativeAdItem(_isAdLoaded, _ad),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _ad?.dispose();
  }

  @override
  bool get wantKeepAlive => true;
}

Widget getNativeAdItem(bool _isAdLoaded, NativeAd ad) {
  if(_isAdLoaded) {
    return Container(
      padding: EdgeInsets.only(left: 4.0),
      child: AdWidget(ad: ad),
      height: 72.0,
      alignment: Alignment.center,
    );
  } else {
    return SizedBox();
  }
}

String calculateUsdEquivalent(BaseTask task) {
  double value = (task.finalRewardAmount ?? task.rewardAmount ?? 0) * (task.usdEquivalent ?? 0);
  return '~' + NumberFormat.simpleCurrency(decimalDigits: value < 0.01 ? 4 : 2, name: 'USD ').format(value);
}