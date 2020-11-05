import 'package:bounty_hub_client/utils/ui/colors.dart';
import 'package:bounty_hub_client/utils/ui/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String leftIcon;
  final String rightIcon;
  final String title;
  final VoidCallback onLeftIconClick;
  final VoidCallback onRightIconClick;

  const CustomAppBar(
      {Key key,
      this.leftIcon,
      this.rightIcon,
      this.title,
      this.onLeftIconClick,
      this.onRightIconClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: AppColors.pageBackgroundColor,
      elevation: 0,
      leading: Center(
        child: Container(
          child: Stack(
            children: [
              IconButton(
                icon: Image.asset(
                  leftIcon,
                  width: 26,
                ),
                onPressed: onLeftIconClick,
              ),
            ],
          ),
        ),
      ),
      title: Text(
        title,
        style: AppTextStyles.titleTextStyle,
      ),
      actions: <Widget>[
        IconButton(
          icon: Image.asset(
            rightIcon,
            width: 26,
          ),
          onPressed: onRightIconClick,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
