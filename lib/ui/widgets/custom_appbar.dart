import 'package:flutter_starter/utils/ui/colors.dart';
import 'package:flutter_starter/utils/ui/text_styles.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final VoidCallback? onActionClick;
  final Color? color;

  const CustomAppBar(
      {Key?key,
      this.title,
      this.color,
      this.onActionClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(color: AppColors.accentColor),
      centerTitle: true,
      backgroundColor:color?? Colors.white,
      elevation: 0,
      title: Text(
        title!,
        style: AppTextStyles.titleTextStyle,
      ),
      actions: <Widget>[
        PopupMenuButton<String>(
          onSelected: onSelected,
          itemBuilder: (BuildContext context) {
            return {'Logout'}.map((String choice) {
              return PopupMenuItem<String>(
                value: choice,
                child: Text(choice),
              );
            }).toList();
          },
        ),
      ],
    );
  }

  void onSelected(String value) {
    onActionClick!.call();
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
