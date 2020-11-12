import 'package:bounty_hub_client/ui/widgets/custom_appbar.dart';
import 'package:bounty_hub_client/ui/widgets/top_sheet_widget.dart';
import 'package:bounty_hub_client/utils/ui/colors.dart';
import 'package:bounty_hub_client/utils/ui/text_styles.dart';
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

  FilterDialog._(this.onSelect);

  static Future<void> show(
      BuildContext context, void onSelect(FilterEntity detail),
      {height = 556.0}) async {
    return showDialog(
        context: context,
        builder: (context) =>
            TopSheet(FilterDialog._(onSelect), height: height),
        barrierColor: Colors.transparent);
  }

  @override
  _FilterDialogState createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
  var companyCount = 10;
  var socialCount = 20;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            CustomAppBar(
              title: 'Company',
              leftIcon: 'assets/images/reject.png',
              onLeftIconClick: () {
                TopSheetState.close(context);
              },
              color: Colors.white,
            ),
            SizedBox(
              height: 182,
            ),
            CustomAppBar(
              title: 'Social Networks',
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
                  ..._buildCompanyList(),
                  SizedBox(
                    height: 80,
                  ),
                  ..._buildSocialsList(),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  List<Widget> _buildSocialsList() {
    return [
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (int i = 0;
              i < (socialCount ~/ 3) + (socialCount % 3 == 0 ? 0 : 1);
              i++)
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _buildSocialItemItem(i),
                if (socialCount >= 2)
                  _buildSocialItemItem(
                      (socialCount ~/ 3) + (socialCount % 3 == 0 ? 0 : 1) + i),
                if ((socialCount ~/ 3 * 2) +
                        (socialCount % 3 == 0 ? 0 : 2) +
                        i +
                        1 <=
                    socialCount)
                  _buildSocialItemItem((socialCount ~/ 3 * 2) +
                      (socialCount % 3 == 0 ? 0 : 2) +
                      i),
              ],
            )
        ],
      )
    ];
  }

  List<Widget> _buildCompanyList() {
    return [
      Row(
        children: [
          for (int i = 0; i < companyCount / 2; i++) _buildCompanyItem(i)
        ],
      ),
      SizedBox(
        height: 8,
      ),
      Row(
        children: [
          for (int i = companyCount ~/ 2 + companyCount % 2;
              i < companyCount;
              i++)
            _buildCompanyItem(i),
          if (!companyCount.isEven)
            Container(
              width: 85,
            )
        ],
      )
    ];
  }

  Widget _buildCompanyItem(int i) {
    return Container(
      height: 75,
      width: 75,
      child: Column(
        children: [
          Container(
            height: 45,
            width: 45,
            child: Text(i.toString()),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12), color: Colors.blue),
          ),
          Container(
              width: 45,
              child: Text(
                'SomeText',
                style: AppTextStyles.smallBoldTitle
                    .copyWith(fontSize: 9, color: AppColors.itemTextColor),
              )),
        ],
      ),
    );
  }

  Widget _buildSocialItemItem(int i) {
    return Container(
      height: 75,
      width: 75,
      child: Column(
        children: [
          Container(
            height: 45,
            width: 45,
            child: Text(i.toString()),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12), color: Colors.blue),
          ),
        ],
      ),
    );
  }
}

class FilterEntity {
  List<String> selectedCompany;
  List<String> selectedSocial;
}
