import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class NativeAdWidget extends StatelessWidget {

  final bool isAdLoaded;
  final NativeAd ad;

  const NativeAdWidget({Key key, this.isAdLoaded, this.ad}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isAdLoaded ? Container(
      padding: EdgeInsets.only(left: 4.0),
      child: AdWidget(ad: ad),
      height: 72.0,
      alignment: Alignment.center) : SizedBox();
  }
}