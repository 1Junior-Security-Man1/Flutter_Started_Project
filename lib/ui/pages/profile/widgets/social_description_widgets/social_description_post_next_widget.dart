import 'package:bounty_hub_client/ui/pages/profile/widgets/social_description_widgets/social_description_widget.dart';
import 'package:bounty_hub_client/ui/widgets/app_button.dart';
import 'package:bounty_hub_client/utils/localization/localization.res.dart';
import 'package:bounty_hub_client/utils/ui/colors.dart';
import 'package:bounty_hub_client/utils/ui/text_styles.dart';
import 'package:flutter/material.dart';

class SocialDescriptionPostNextWidget extends StatefulWidget {
  final SocialUIModel selectedModel;


  const SocialDescriptionPostNextWidget(
      {Key key, this.selectedModel})
      : super(key: key);

  @override
  _SocialDescriptionPostNextWidgetState createState() =>
      _SocialDescriptionPostNextWidgetState();
}

class _SocialDescriptionPostNextWidgetState
    extends State<SocialDescriptionPostNextWidget> {
  FocusNode focusText = FocusNode();

  @override
  void initState() {
    focusText.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.selectedModel.title,
          style: AppTextStyles.smallBoldTitle,
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          widget.selectedModel.nextText,
          style: AppTextStyles.defaultText,
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          '${AppStrings.profile}:',
          style: AppTextStyles.defaultText,
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          widget.selectedModel.example,
          style: AppTextStyles.defaultThinText,
        ),
        SizedBox(
          height: 16,
        ),
        Container(
          constraints: BoxConstraints(
            maxHeight: 100.0,
          ),
          decoration: BoxDecoration(
              color: AppColors.socialDescription,
              borderRadius: BorderRadius.all(Radius.circular(12)),
              border: Border.all(
                  color: focusText.hasPrimaryFocus
                      ? AppColors.socialDescriptionBorder
                      : AppColors.socialDescription,
                  width: 2)),
          child: TextField(
            maxLines: null,
            style: AppTextStyles.defaultText,
            focusNode: focusText,
            decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                border: InputBorder.none),
          ),
        ),
        SizedBox(
          height: 16,
        ),
        Align(
          alignment: Alignment.center,
          child: AppButton(
            height: 50,
            text: AppStrings.confirm,
            width: MediaQuery.of(context).size.width / 2 - 40,
            onPressed: () {},
          ),
        )
      ],
    );
  }
}
