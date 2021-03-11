import 'package:bounty_hub_client/data/enums/response_error_types.dart';
import 'package:bounty_hub_client/ui/pages/main/cubit/main_cubit.dart';
import 'package:bounty_hub_client/ui/widgets/app_button.dart';
import 'package:bounty_hub_client/utils/localization/localization.res.dart';
import 'package:bounty_hub_client/utils/localization/response_localization.dart';
import 'package:bounty_hub_client/utils/ui/colors.dart';
import 'package:bounty_hub_client/utils/ui/dimens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppAlertDialog extends StatefulWidget {

  final String message;
  final ServerErrorType serverErrorType;

  const AppAlertDialog({Key key,
    this.message,
    this.serverErrorType = ServerErrorType.UNKNOWN,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => AppAlertDialogState();
}

class AppAlertDialogState extends State<AppAlertDialog> with SingleTickerProviderStateMixin {
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
                        getLocalizedMessage(widget.message),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: AppColors.itemTextColor,
                          height: 1.4,
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                    hasAction(widget.message) ? Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: AppButton(
                        height: 50,
                        type: AppButtonType.BLUE,
                        text: AppStrings.goToProfile,
                        width: MediaQuery.of(context).size.width / 2,
                        onPressed: onAlertButtonAction(context, widget.message),
                      ),
                    ): SizedBox(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool hasAction(String message) {
    ServerErrorType errorType = getServerErrorType(message);
    return errorType == ServerErrorType.NO_SOCIAL_NETWORKS_ADDED_ERROR; // add other error types here for which button action is needed
  }

  Function onAlertButtonAction(BuildContext context, String message) {
    switch(getServerErrorType(message)) {
      case ServerErrorType.NO_SOCIAL_NETWORKS_ADDED_ERROR:
        return () {
          context.bloc<MainCubit>().setCurrentNavigationItem(1);
          Navigator.of(context).popUntil((route) => route.isFirst);
        };
        break;
      default:
        return null;
    }
  }
}