import 'package:bounty_hub_client/ui/pages/task_details/task_details_page.dart';
import 'package:bounty_hub_client/ui/widgets/social_image.dart';
import 'package:bounty_hub_client/utils/ui/colors.dart';
import 'package:bounty_hub_client/utils/ui/dimens.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:bounty_hub_client/data/models/entity/task/base_task.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:bounty_hub_client/utils/ads/ad_helper.dart';
import 'package:bounty_hub_client/ui/widgets/ads/native_ad_widget.dart';

enum TasksListAdsStatus { no_ads, loading, success, failed }

class TasksListItem extends StatefulWidget {
  const TasksListItem({Key key, @required this.task, @required this.index})
      : super(key: key);

  final BaseTask task;
  final int index;

  @override
  _TasksListItemState createState() => _TasksListItemState();
}

class _TasksListItemState extends State<TasksListItem>
    with AutomaticKeepAliveClientMixin {
  NativeAd _ad;
  TasksListAdsStatus _status = TasksListAdsStatus.no_ads;

  @override
  void initState() {
    super.initState();
    createNativeAd();
  }

  void createNativeAd() {
    if (AdHelper.isNativeAdNeedShow(widget.index, 7)) {
      _status = TasksListAdsStatus.loading;
      _ad = NativeAd(
        adUnitId: AdHelper.nativeAdUnitId,
        factoryId: 'listTile',
        request: AdRequest(),
        listener: AdListener(
          onAdLoaded: (_) {
            setState(() {
              _status = TasksListAdsStatus.success;
            });
          },
          onAdFailedToLoad: (ad, error) {
            ad.dispose();
            setState(() {
              _status = TasksListAdsStatus.failed;
            });
          },
        ),
      );

      _ad.load();
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      height: AdHelper.isNativeAdNeedShow(widget.index, 7) ? 156 : 84,
      child: Column(
        children: [
          Material(
            child: InkWell(
              child: Container(
                child: ListTile(
                  hoverColor: Colors.transparent,
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TaskDetailsPage(
                                title: widget.task.productName,
                                taskId: widget.task.itemId ?? widget.task.id)));
                  },
                  contentPadding: EdgeInsets.only(
                      left: Dimens.content_padding,
                      right: Dimens.content_padding,
                      top: 12.0,
                      bottom: 12.0),
                  leading: Container(
                    decoration: BoxDecoration(
                      color: AppColors.secondaryColor,
                      shape: BoxShape.circle,
                    ),
                    width: 48,
                    height: 48,
                    alignment: Alignment.center,
                    child: buildSocialImage(widget.task.getSocialNetwork()),
                  ),
                  trailing: Container(
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: <Color>[
                                AppColors.primarySwatch,
                                AppColors.secondaryColor
                              ],
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(12.0)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 8.0, right: 8.0, top: 2.0, bottom: 2.0),
                            child: Text(
                              (widget.task.finalRewardAmount ??
                                          widget.task.rewardAmount ??
                                          0)
                                      .toString() +
                                  ' ' +
                                  widget.task.rewardCurrency,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700),
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
                                fontWeight: FontWeight.w800),
                          ),
                        ),
                      ],
                    ),
                  ),
                  title: Text(
                    widget.task.productName,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 13,
                        color: AppColors.itemTextColor),
                  ),
                  dense: true,
                ),
              ),
            ),
          ),
          _status == TasksListAdsStatus.no_ads ||
                  _status == TasksListAdsStatus.failed
              ? SizedBox()
              : NativeAdWidget(status: _status, ad: _ad),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _status = TasksListAdsStatus.no_ads;
    _ad?.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;
}

String calculateUsdEquivalent(BaseTask task) {
  double value = (task.finalRewardAmount ?? task.rewardAmount ?? 0) *
      (task.usdEquivalent ?? 0);
  return '~' +
      NumberFormat.simpleCurrency(
              decimalDigits: value < 0.01 ? 4 : 2, name: 'USD ')
          .format(value);
}
