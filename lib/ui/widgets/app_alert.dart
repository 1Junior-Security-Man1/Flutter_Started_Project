import 'package:bounty_hub_client/ui/widgets/app_button.dart';
import 'package:bounty_hub_client/utils/localization/localization.res.dart';
import 'package:bounty_hub_client/utils/ui/colors.dart';
import 'package:bounty_hub_client/utils/ui/dimens.dart';
import 'package:flutter/material.dart';

class AnimatedAlertBuilder extends StatefulWidget {

  final String message;

  final Function action;

  final String buttonText;

  const AnimatedAlertBuilder({Key key,
    this.message, this.action, this.buttonText
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => AnimatedAlertBuilderState();
}

class AnimatedAlertBuilderState extends State<AnimatedAlertBuilder> with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.easeInOut);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: ScaleTransition(
          scale: scaleAnimation,
          child: Container(
            width: double.infinity,
            margin: EdgeInsets.all(Dimens.content_padding),
            decoration: ShapeDecoration(
                color: AppColors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0))),
            child: Padding(
              padding: const EdgeInsets.all(Dimens.content_padding),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      AppStrings.warning,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: AppColors.errorTextColor,
                        fontSize: 16.0,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 4.0),
                      child: Text(
                        widget.message,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: AppColors.itemTextColor,
                          height: 1.4,
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                    widget.action != null ? Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: AppButton(
                        height: 50,
                        type: AppButtonType.BLUE,
                        text: widget.buttonText,
                        width: MediaQuery.of(context).size.width / 2,
                        onPressed: widget.action,
                      ),
                    ) : SizedBox(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}