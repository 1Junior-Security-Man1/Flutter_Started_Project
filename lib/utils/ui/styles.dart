import 'package:flutter_starter/utils/ui/colors.dart';
import 'package:flutter/material.dart';

import 'dimens.dart';

class Styles {
  static BoxDecoration appCardStyle(
      {Color color = Colors.white, double opacity = 0.1}) {
    return BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: Colors.grey[300]!.withOpacity(opacity),
          spreadRadius: 5,
          blurRadius: 7,
          offset: Offset(1, 10),
        ),
      ],
      color: color,
      border: Border.all(
        color: Colors.grey[200]!,
        width: 1,
      ),
      borderRadius: BorderRadius.circular(12),
    );
  }

  static InputDecoration appTextFormStyle(
      {String? hint, String? prefixIconAsset, IconData? prefixIcon, String? suffixIcon, bool? enabled}) {
    return InputDecoration(
      contentPadding:
          const EdgeInsets.only(left: 24.0, top: 24.0, bottom: 24.0),
      prefixIcon: Padding(
          padding: const EdgeInsets.only(
              left: Dimens.input_text_prefix_icon_padding,
              right: Dimens.input_text_prefix_icon_padding),
          child: prefixIconAsset != null
              ? Image.asset(prefixIconAsset, width: 50)
              : Icon(prefixIcon, size: 32)),
      suffixIconConstraints: BoxConstraints(
        minWidth: 2,
        minHeight: 2,
      ),
      suffixIcon: suffixIcon != null
          ? Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: Image.asset(suffixIcon, width: 36),
            )
          : SizedBox(width: 0),
      fillColor: Colors.white,
      filled: true,
      isDense: true,
      enabled: enabled!,
      labelStyle: TextStyle(
        color: AppColors.itemTextColor,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
      hintStyle: TextStyle(
        color: enabled
            ? AppColors.itemTextColor
            : AppColors.buttonDisabledTextColor,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
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
        color: Colors.black12,
        width: 0.7,
      ),
    );
  }
}
