import 'package:bounty_hub_client/bloc/badge/badge_cubit.dart';
import 'package:bounty_hub_client/data/models/entity/activity/notification.dart';
import 'package:bounty_hub_client/ui/pages/activity/widgets/activity_utils.dart';
import 'package:bounty_hub_client/ui/pages/task_details/task_details_page.dart';
import 'package:bounty_hub_client/utils/localization/localization.res.dart';
import 'package:bounty_hub_client/utils/ui/styles.dart';
import 'package:bounty_hub_client/utils/ui/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:bounty_hub_client/utils/ads/ad_helper.dart';
import 'package:bounty_hub_client/ui/widgets/ads/native_ad_widget.dart';

class ActivityItem extends StatefulWidget {
  const ActivityItem({Key key, @required this.activity, @required this.index}) : super(key: key);

  final Activity activity;
  final int index;

  @override
  _ActivityItemState createState() => _ActivityItemState();
}

class _ActivityItemState extends State<ActivityItem> with AutomaticKeepAliveClientMixin {

  NativeAd _ad;
  bool _isAdLoaded = false;

  @override
  void initState() {
    super.initState();
    createNativeAd();
  }

  void createNativeAd() {
    _ad = NativeAd(
      adUnitId: AdHelper.nativeAdUnitId,
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

    if(AdHelper.isNativeAdNeedShow(widget.index, 8)) {
      _ad.load();
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: [
        Stack(
          alignment: Alignment.centerLeft,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 20,
              ),
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  Container(
                    height: 45,
                    width: 45,
                    decoration: WidgetsDecoration.appBlueButtonStyle(),
                    child: Center(
                        child: Image.asset(
                          widget.activity.action == 'ITEM_RECONFIRMATION'
                              ? 'assets/images/menu_item_tasks_active.png'
                              : 'assets/images/menu_item_notification_active.png',
                          color: Colors.white,
                          height: 24,
                          width: 24,
                        )),
                  ),
                  if (!widget.activity.read)
                    Transform.translate(
                      offset: Offset(4, -4),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                          border: Border.all(width: 1, color: Colors.white),
                        ),
                        height: 14,
                        width: 14,
                      ),
                    )
                ],
              ),
            ),
            Material(
              color: Colors.transparent,
              child: InkWell(
                highlightColor: Colors.black12,
                splashColor: Colors.black12,
                onTap: () {
                  context.bloc<ActivityBadgeCubit>().readNotification(widget.activity.id);
                  widget.activity.read = true;
                  setState(() {});
                  if(widget.activity?.action == 'ITEM_RECONFIRMATION'
                      || widget.activity?.action == 'ITEM_REJECTED'
                      || widget.activity?.action == 'ITEM_PAID'
                      || widget.activity?.action == 'ITEM_DELETED') {
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>
                        TaskDetailsPage(title: AppStrings.taskDetails, taskId: parseTaskIdFromHtml(widget.activity.content))),
                    );
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10, top: 10),
                  child: Container(
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 20,
                            right: 15,
                          ),
                          child: Container(
                            height: 45,
                            width: 45,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width - 140,
                              child: Html(
                                renderNewlines: true,
                                data: widget.activity.content,
                                defaultTextStyle: AppTextStyles.defaultText.copyWith(
                                    fontWeight: FontWeight.w600, fontSize: 12),
                                onLinkTap: (link) {},
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 16),
                              child: Container(
                                margin: const EdgeInsets.only(top: 8),
                                child: Text(DateFormat('dd-MM-yyyy').format(widget.activity.updated),
                                  style: AppTextStyles.defaultThinText.copyWith(fontSize: 12),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        NativeAdWidget(isAdLoaded: _isAdLoaded, ad: _ad),
      ],
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