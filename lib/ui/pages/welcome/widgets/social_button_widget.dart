import 'package:flutter/material.dart';
import 'package:bounty_hub_client/utils/ui/styles.dart';

class SocialButtonWidget extends StatelessWidget {

  final Function onClick;

  final double width;

  final double height;

  final String asset;

  final enabled;

  const SocialButtonWidget({Key key, this.onClick, this.width = 60, this.height  = 60, @required this.asset, this.enabled = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Container(
        height: height,
        width: width,
        decoration: WidgetsDecoration.appCardStyle(opacity: 0.3),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Opacity(
            child: Image.asset(asset),
            opacity: enabled ? 1.0 : 0.2,
          ),
        ),
      ),
    );
  }
}