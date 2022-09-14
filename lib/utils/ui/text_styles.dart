import 'package:flutter_starter/utils/ui/colors.dart';
import 'package:flutter_starter/utils/ui/dimens.dart';
import 'package:flutter/material.dart';

class AppTextStyles {
  static const TextStyle titleTextStyle = TextStyle(
    color: AppColors.appBarTextColor,
    fontWeight: FontWeight.w600,
    fontSize: Dimens.app_bar_text_size,
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
}