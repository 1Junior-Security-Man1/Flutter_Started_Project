import 'package:bounty_hub_client/data/enums/social_networks_types.dart';
import 'package:bounty_hub_client/ui/pages/profile/bloc/profile_bloc.dart';
import 'package:bounty_hub_client/ui/pages/profile/bloc/profile_event.dart';
import 'package:bounty_hub_client/ui/pages/profile/widgets/social_description_widgets/social_description_widget.dart';
import 'package:bounty_hub_client/ui/widgets/app_button.dart';
import 'package:bounty_hub_client/utils/ui/colors.dart';
import 'package:bounty_hub_client/utils/ui/styles.dart';
import 'package:bounty_hub_client/utils/ui/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class SocialDescriptionPreNextWidget extends StatelessWidget {
  final SocialUIModel selectedModel;

  final shortNumber;
  final selectedSocial;

  const SocialDescriptionPreNextWidget({Key key, this.selectedModel, this.shortNumber, this.selectedSocial}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          selectedModel.title,
          style: AppTextStyles.smallBoldTitle,
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          selectedModel.subTitle,
          style: AppTextStyles.defaultText,
        ),
        SizedBox(
          height: 8,
        ),
        Column(
          children: [
            for (var i = 0; i < selectedModel.text.length; i++)
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '  ${i + 1}. ',
                          style: AppTextStyles.defaultText,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width - 137,
                          child: RichText(
                            text: TextSpan(
                              children: [
                                for (var j = 0;
                                j < selectedModel.text[i].length;
                                j++)
                                  TextSpan(
                                    text: '${selectedModel.text[i][j]}',
                                    style: selectedModel.isTextBold[i][j]
                                      ? AppTextStyles.defaultBold
                                      : AppTextStyles.defaultText),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
          ],
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          selectedModel.bottomText,
          style: AppTextStyles.defaultText,
        ),
        _buildHashCode(shortNumber,context),
        _buildNextBtn(selectedModel, selectedSocial,context),
      ],
    );
  }

  _buildHashCode(int code, context) {
    var strCode = '#b${NumberFormat("000000000").format(code)}';
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Row(
        children: [
          Container(
            height: 50,
            width: MediaQuery.of(context).size.width - 82 - 50,
            decoration: BoxDecoration(
              color: AppColors.pageBackgroundColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12))),
            child: Center(
              child: Text(strCode,style: AppTextStyles.defaultBold,),),
          ),
          AppButton(
            height: 50,
            width: 50,
            onPressed: (){
              Clipboard.setData(ClipboardData(text: strCode));
              Scaffold.of(context).showSnackBar(SnackBar(content: Text('Copied'),duration: Duration(seconds: 2),));
            },
            child: Icon(
              Icons.copy_outlined,
              color: Colors.white,
            ),
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(12),
              bottomRight: Radius.circular(12)),
          ),
        ],
      ),
    );
  }

  _buildNextBtn(SocialUIModel selectedModel, selectedSocial, context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Align(
        alignment: Alignment.center,
        child: AppButton(
          width: MediaQuery.of(context).size.width / 2 - 20,
          text: selectedSocial == SocialNetworkType.FACEBOOK
            ? 'MAKE POST'
            : 'NEXT',
          onPressed: () {
            BlocProvider.of<ProfileBloc>(context).add(OnNextBtnPresEvent(selectedSocial));
          },
        ),
      ),
    );
  }
}
