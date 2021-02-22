import 'package:bounty_hub_client/ui/widgets/app_button.dart';
import 'package:bounty_hub_client/utils/localization/localization.res.dart';
import 'package:bounty_hub_client/utils/ui/dimens.dart';
import 'package:bounty_hub_client/utils/ui/text_styles.dart';
import 'package:flutter/material.dart';

void showConfirmActionDialog(BuildContext context, String message, Function positiveButtonClick, Function negativeButtonClick) {
  showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (builder){
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter state) {
              return Container(
                height: 240,
                color: Colors.transparent,
                child: Center(
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(left: 36.0, right: 36.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: new BorderRadius.only(
                            topLeft: const Radius.circular(Dimens.app_bottom_dialog_border_radius),
                            topRight: const Radius.circular(Dimens.app_bottom_dialog_border_radius))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 24.0),
                          child: Text(
                            message,
                            style: AppTextStyles.titleTextStyle,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: Dimens.content_internal_padding),
                          child: AppButton(
                            height: 50,
                            type: AppButtonType.BLUE,
                            text: AppStrings.confirm,
                            width: MediaQuery.of(context).size.width / 2,
                            onPressed: positiveButtonClick,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: Dimens.content_internal_padding),
                          child: AppButton(
                            height: 50,
                            type: AppButtonType.WHITE,
                            text: AppStrings.cancel,
                            width: MediaQuery.of(context).size.width / 2,
                            onPressed: negativeButtonClick,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            });
      }
  );
}