import 'package:bounty_hub_client/utils/ui/colors.dart';
import 'package:flutter/material.dart';

import 'dimens.dart';

class WidgetsDecoration {

  static BoxDecoration appCardStyle() {
    return BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: Colors.grey[300].withOpacity(0.1),
          spreadRadius: 5,
          blurRadius: 7,
          offset: Offset(1, 10),
        ),
      ],
      color: Colors.white,
      border: Border.all(
        color: AppColors.borderColor,
        width: 1,
      ),
      borderRadius: BorderRadius.circular(12),
    );
  }

  static BoxDecoration appBlueButtonStyle() {
    return BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[AppColors.primaryColor, AppColors.accentColor],
    ),
      borderRadius: BorderRadius.all(Radius.circular(12.0)),
    );
  }

  static BoxDecoration appWhiteButtonStyle() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(12.0)),
    );
  }

  static BoxDecoration appNavigationStyle() {
    return BoxDecoration(
      borderRadius: BorderRadius.only(
          topRight: Radius.circular(20), topLeft: Radius.circular(22.0)),
      boxShadow: [
        BoxShadow(color: Colors.grey[200], spreadRadius: 0, blurRadius: 6),
      ],
    );
  }

  static InputDecoration appTextFormStyle(String hint, String prefixIcon, String suffixIcon, bool enabled) {
    return InputDecoration(
      contentPadding: const EdgeInsets.all(24.0),
      prefixIcon: Padding(
          padding: const EdgeInsets.only(
              left: Dimens.input_text_prefix_icon_padding,
              right: Dimens.input_text_prefix_icon_padding
          ), child: Image.asset(prefixIcon, width: 50)),
      suffixIcon: Padding(
          padding: const EdgeInsets.only(
              left: Dimens.input_text_prefix_icon_padding,
              right: Dimens.input_text_prefix_icon_padding
          ), child: suffixIcon != null ? Image.asset(suffixIcon, width: 36) : Container(width: 0)),
      fillColor: Colors.white,
      filled: true,
      isDense: true,
      enabled: enabled,
      labelStyle: TextStyle(color: AppColors.itemTextColor, fontSize: 18, fontWeight: FontWeight.w600,),
      hintStyle: TextStyle(color: enabled ? AppColors.itemTextColor : AppColors.inputDisabledTextColor, fontSize: 18, fontWeight: FontWeight.w600,),
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