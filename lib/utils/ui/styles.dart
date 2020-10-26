import 'package:bounty_hub_client/utils/ui/colors.dart';
import 'package:flutter/material.dart';
import 'dimens.dart';

class WidgetsDecoration {

  static BoxDecoration appButtonStyle() {
    return BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[AppColors.primaryColor, AppColors.accentColor],
    ),
      borderRadius: BorderRadius.all(Radius.circular(12.0)),
    );
  }

  static InputDecoration appTextFormStyle(String hint, String prefixIcon, bool enabled) {
    return InputDecoration(
      contentPadding: const EdgeInsets.all(24.0),
      prefixIcon: Padding(
          padding: const EdgeInsets.only(
              left: Dimens.input_text_prefix_icon_padding,
              right: Dimens.input_text_prefix_icon_padding
          ), child: Image.asset(prefixIcon, width: 50)),
      fillColor: Colors.white,
      filled: true,
      isDense: true,
      enabled: enabled,
      labelStyle: TextStyle(color: AppColors.textHintColor, fontSize: 18, fontWeight: FontWeight.w600,),
      hintStyle: TextStyle(color: enabled ? AppColors.inputTextColor : AppColors.inputDisabledTextColor, fontSize: 18, fontWeight: FontWeight.w600,),
      border: buildInputBorderStyle(),
      focusedBorder: buildInputBorderStyle(),
      enabledBorder: buildInputBorderStyle(),
      disabledBorder: buildInputBorderStyle(),
      errorBorder: buildInputBorderStyle(),
      focusedErrorBorder: buildInputBorderStyle(),
      hintText: hint,
    );
  }

  static OutlineInputBorder buildInputBorderStyle() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(
        color: AppColors.textFormBorderColor,
        width: 0.7,
      ),
    );
  }
}