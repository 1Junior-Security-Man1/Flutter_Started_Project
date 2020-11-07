import 'package:bounty_hub_client/data/enums/social_networks_types.dart';
import 'package:bounty_hub_client/ui/pages/profile_page/profile/bloc/profile_bloc.dart';
import 'package:bounty_hub_client/ui/pages/profile_page/profile/bloc/profile_event.dart';
import 'package:bounty_hub_client/ui/pages/profile_page/profile/widgets/social/social_description_widgets/social_description_widget.dart';
import 'package:bounty_hub_client/ui/widgets/app_button.dart';
import 'package:bounty_hub_client/utils/localization/localization.res.dart';
import 'package:bounty_hub_client/utils/ui/colors.dart';
import 'package:bounty_hub_client/utils/ui/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialDescriptionPostNextWidget extends StatefulWidget {
  final SocialUIModel selectedModel;
  final SocialNetworkType socialNetworkType;

  const SocialDescriptionPostNextWidget(
      {Key key, this.selectedModel, this.socialNetworkType})
      : super(key: key);

  @override
  _SocialDescriptionPostNextWidgetState createState() =>
      _SocialDescriptionPostNextWidgetState();
}

class _SocialDescriptionPostNextWidgetState
    extends State<SocialDescriptionPostNextWidget> {
  FocusNode focusText = FocusNode();
  TextEditingController _editingController;

  @override
  void initState() {
    _editingController = TextEditingController();
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
            controller: _editingController,
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
            onPressed: () {
              BlocProvider.of<ProfileBloc>(context).add(AddSocialProfileEvent(widget.socialNetworkType,_editingController.text));
            },
          ),
        )
      ],
    );
  }
}
