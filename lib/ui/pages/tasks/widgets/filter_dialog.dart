import 'package:bounty_hub_client/data/enums/social_networks_types.dart';
import 'package:bounty_hub_client/data/models/entity/campaign/campaign.dart';
import 'package:bounty_hub_client/network/download/image_url_provider.dart';
import 'package:bounty_hub_client/ui/widgets/custom_appbar.dart';
import 'package:bounty_hub_client/ui/widgets/social_image.dart';
import 'package:bounty_hub_client/ui/widgets/top_sheet_widget.dart';
import 'package:bounty_hub_client/utils/ui/colors.dart';
import 'package:bounty_hub_client/utils/ui/styles.dart';
import 'package:bounty_hub_client/utils/ui/text_styles.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

typedef void OnSelect(FilterEntity detail);

//item h 45
// item pad to text 8
//text, 2 line max h - 22
//text pad to next item - 12
//item h 45
//second item pad to title 30
// =158

//soc item - 78
// 3 row - 234
// indicator - 60
// = 294

//2 titles = 100

// = 556

class FilterDialog extends StatefulWidget {
  final OnSelect onSelect;

  final List<Campaign> compaing;

  FilterEntity selectedEntity;

  FilterDialog._(this.onSelect, this.compaing,  this.selectedEntity);

  static Future<void> show(
      BuildContext context, void onSelect(FilterEntity detail),
      {height = 546.0, compaing, FilterEntity selectedEntity}) async {
    return showDialog(
        context: context,
        builder: (context) =>
            TopSheet(FilterDialog._(onSelect, compaing,selectedEntity), height: height),
        barrierColor: Colors.transparent);
  }

  @override
  _FilterDialogState createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
  
  List<SocialNetworkType> selectedSocial = [];
  List<Campaign> selectedCompany = [];

  @override
  void initState() {
    selectedCompany = List.of(widget.selectedEntity.selectedCompany);
    selectedSocial = List.of(widget.selectedEntity.selectedSocial);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            CustomAppBar(
              title: 'Social Networks',
              leftIcon: 'assets/images/reject.png',
              onLeftIconClick: () {
                TopSheetState.close(context);
              },
              color: Colors.white,
            ),
            SizedBox(
              height: 162,
            ),
            CustomAppBar(
              title: 'Company',
              color: Colors.white,
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 66),
          child: Container(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ..._buildSocialList(),
                  SizedBox(
                    height: 60,
                  ),
                  ..._buildCompanyList(),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  List<Widget> _buildCompanyList() {
    return [
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (int i = 0;
              i < (widget.compaing.length ~/ 3) + (widget.compaing.length % 3 == 0 ? 0 : 1);
              i++)
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _buildCompanyItem(widget.compaing[i]),
                if (widget.compaing.length >= 2)
                  _buildCompanyItem(widget.compaing[
                      (widget.compaing.length ~/ 3) + (widget.compaing.length % 3 == 0 ? 0 : 1) + i]),
                if ((widget.compaing.length ~/ 3 * 2) +
                        (widget.compaing.length % 3 == 0 ? 0 : 2) +
                        i +
                        1 <=
                  widget.compaing.length)
                  _buildCompanyItem(widget.compaing[(widget.compaing.length ~/ 3 * 2) +
                      (widget.compaing.length % 3 == 0 ? 0 : 2) +
                      i]),
              ],
            )
        ],
      )
    ];
  }

  List<Widget> _buildSocialList() {
    var socialList = SocialNetworkType.values;
    return [
      Row(
        children: [
          for (int i = 0; i < socialList.length / 2; i++)
            _buildSocialItem(socialList[i])
        ],
      ),
      SizedBox(
        height: 8,
      ),
      Row(
        children: [
          for (int i = socialList.length ~/ 2 + socialList.length % 2;
              i < socialList.length;
              i++)
            _buildSocialItem(socialList[i]),
          if (!socialList.length.isEven)
            Container(
              width: 85,
            )
        ],
      )
    ];
  }

  Widget _buildCompanyItem(Campaign item) {
    return Container(
      height: 75,
      width: 75,
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              GestureDetector(
                onTap: (){
                  if(selectedCompany.contains(item)){
                    selectedCompany.remove(item);
                  }else{
                    selectedCompany.add(item);
                  }
                  widget.onSelect(FilterEntity(selectedCompany,selectedSocial));
                  setState(() {

                  });
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Container(
                    decoration: WidgetsDecoration.appBlueButtonStyle(),
                    child: CachedNetworkImage(
                      imageUrl: getImageUrl(item.coverId),
                      height: 45,
                      width: 45,
                      placeholder: (_,__)=> Container(
                        decoration: WidgetsDecoration.appBlueButtonStyle(),
                      ),
                    ),
                  ),
                ),
              ),
              if(selectedCompany.contains(item))
                Container(
                  child: Image.asset('assets/images/complete.png',color: Colors.white,height: 14,width: 14,),
                  decoration: WidgetsDecoration.appBlueButtonStyle().copyWith(border: Border.all(color: Colors.white),),
                )
            ],
          ),
          Container(
              width: 45,
              child: Text(
                item.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.smallBoldTitle
                    .copyWith(fontSize: 9, color: AppColors.itemTextColor),
              )),
        ],
      ),
    );
  }

  Widget _buildSocialItem(SocialNetworkType type) {
    return Container(
      height: 75,
      width: 75,
      child: Column(
        children: [
          GestureDetector(
            onTap: (){
              if(selectedSocial.contains(type)){
                selectedSocial.remove(type);
              }else{
                selectedSocial.add(type);
              }
              widget.onSelect(FilterEntity(selectedCompany,selectedSocial));
              setState(() {
                
              });
            },
            child: Stack(alignment: Alignment.bottomRight,
              children: [
                Align(
                  alignment:Alignment.center,
                  child: Container(
                    height: 45,
                    width: 45,
                    child: buildSocialImage(type),
                  ),
                ),
                if(selectedSocial.contains(type))
                Transform.translate(
                  offset: Offset(-12,0),
                  child: Container(
                    child: Image.asset('assets/images/complete.png',color: Colors.white,height: 14,width: 14,),
                    decoration: WidgetsDecoration.appBlueButtonStyle().copyWith(border: Border.all(color: Colors.white),),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FilterEntity {
  final List<Campaign> selectedCompany;
  final List<SocialNetworkType> selectedSocial;

  FilterEntity(this.selectedCompany, this.selectedSocial);
}
