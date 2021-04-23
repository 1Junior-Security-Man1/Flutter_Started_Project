import 'package:flutter_starter/utils/ui/colors.dart';
import 'package:flutter_starter/utils/ui/dimens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppTextStyles {
  static const TextStyle titleTextStyle = TextStyle(
    color: AppColors.appBarTextColor,
    fontWeight: FontWeight.w600,
    fontSize: Dimens.app_bar_text_size,
  );

  static const TextStyle settingsTextStyle = TextStyle(
    color: AppColors.itemTextColor,
    fontWeight: FontWeight.w600,
    fontSize: 14,
  );

  static const TextStyle greyContentTextStyle = TextStyle(
    fontSize: 16,
    color: AppColors.greyContentColor,
    fontWeight: FontWeight.w500,
    height: 1.4,
  );

  static const TextStyle smallBoldTitle = TextStyle(
    color: Colors.black87,
    fontWeight: FontWeight.bold,
    fontSize: 16
  );

  static const TextStyle defaultText = TextStyle(
    color: Colors.black87,
    fontWeight: FontWeight.normal,
  );

  static const TextStyle defaultErrorText = TextStyle(
      color: AppColors.errorTextColor,
      fontWeight: FontWeight.normal,
  );

  static const TextStyle defaultBold = TextStyle(
    color: Colors.black87,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle defaultThinText = TextStyle(
    color: Colors.black87,
    fontWeight: FontWeight.w300,
    fontSize: 14
  );
}
