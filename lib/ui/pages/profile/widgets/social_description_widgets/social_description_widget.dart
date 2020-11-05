import 'package:bounty_hub_client/data/enums/social_networks_types.dart';
import 'package:bounty_hub_client/utils/ui/text_styles.dart';
import 'package:flutter/widgets.dart';

class SocialDescriptionWidget extends StatefulWidget {
  SocialDescriptionWidget(
    this.selectedSocial, {
    Key key,
    this.shortNumber,
  }) : super(key: key) {}

  final String shortNumber;
  final selectedSocial;

  @override
  _SocialDescriptionWidgetState createState() =>
      _SocialDescriptionWidgetState();
}

class _SocialDescriptionWidgetState extends State<SocialDescriptionWidget> {
  SocialUIModel facebookIUModel;
  SocialUIModel instgrammIUModel;
  Map<SocialNetworkType, SocialUIModel> UIModels;

  @override
  void initState() {
    initUIModels();
    UIModels = {SocialNetworkType.FACEBOOK: facebookIUModel,SocialNetworkType.INSTAGRAM: instgrammIUModel};
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final selectedModel = UIModels[widget.selectedSocial];
    print('!!!!!');
    print(selectedModel.text.length);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(selectedModel.title,style: AppTextStyles.smallBoldTitle,),
        SizedBox(height: 8,),
        Text(selectedModel.subTitle,style: AppTextStyles.defaultText,),
        SizedBox(height: 8,),
        Column(
          children: [
            for (var i = 0; i < selectedModel.text.length; i++)
              Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('  ${i+1}. ',style: AppTextStyles.defaultText,),
                      Container(
                        width: MediaQuery.of(context).size.width-137,
                        child: RichText(
                          text: TextSpan(
                            children: [
                              for (var j = 0; j < selectedModel.text[i].length; j++)
                                TextSpan(text: '${selectedModel.text[i][j]}',style: selectedModel.isTextBold[i][j]?AppTextStyles.defaultBold:AppTextStyles.defaultText),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              )
          ],
        ),
        SizedBox(height: 8,),
        Text(selectedModel.bottomText,style: AppTextStyles.defaultText,)
      ],
    );
  }

  void initUIModels() {
    facebookIUModel = SocialUIModel(
        title: 'Profile Facebook',
        subTitle:
            'In order to authenticate you on Facebook, you must fulfill a few conditions:',
        text: [
          [
            'You need to make a post on Facebook, with this hashtag ',
            widget.shortNumber
          ],
          [
            'This post must be available for all users, otherwise you account won\'t be validated'
          ],
          ['This post should be in your top 5 news feed for ', '24 hours']
        ],
        isTextBold: [
          [false, true],
          [false],
          [false, true]
        ],
        bottomText:
            'Have you copied your hashtag? Please create a post by clicking the button below:',
        nextText:
            'Great! Now, you need to provide a link to your profile so that we can find the post that you just made on your page.',
        example:
            'https://www.facebook.com/profile.php?id=ACCOUNT_ID \nhttps://www.facebook.com/USER_NAME');

   instgrammIUModel = SocialUIModel(
        title: 'Instagram',
        subTitle:
            'In order to authenticate you on Instagram, you must fulfill a few conditions:',
        text: [
          [
            'You need to make a post on Instagram, with this hashtag ',
            widget.shortNumber
          ],
          [
            'This post must be available for all users, otherwise you account won\'t be validated'
          ],
          ['This post should be in your top 5 news feed for ', '24 hours']
        ],
        isTextBold: [
          [false, true],
          [false],
          [false, true]
        ],
        bottomText:
            'Have you copied your hashtag and created a post?',
        nextText:
            'Great! Now, you need to provide a link to your profile so that we can find the post that you just made on your page.',
        example:
            'https://www.instagram.com/your_name/');
  }
}

class SocialUIModel {
  final String title;
  final String subTitle;
  final String bottomText;
  final List<List<String>> text;
  final List<List<bool>> isTextBold;
  final String nextText;
  final String example;

  const SocialUIModel(
      {this.title,
      this.subTitle,
      this.bottomText,
      this.text,
      this.isTextBold,
      this.nextText,
      this.example});
}
