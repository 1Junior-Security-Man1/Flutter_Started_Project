import 'package:bounty_hub_client/utils/ui/colors.dart';
import 'package:flutter/material.dart';

class TaskWarningWidget extends StatelessWidget {

  final String link;
  final String message;

  const TaskWarningWidget({Key key, @required this.link, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:  EdgeInsets.only(top: 24.0, bottom: 16.0),
      alignment: Alignment.topCenter,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Container(
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                child: Container(
                  padding: EdgeInsets.only(left: 6.0, right: 16.0, top: 10.0, bottom: 10.0),
                  color: AppColors.accentColor,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.info_outline,
                        size: 22.0,
                        color: Colors.white,
                      ),
                      SizedBox(width: 6.0),
                      Flexible(
                        child: Text(
                          message,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.white,
                            fontWeight: FontWeight.w500,
                            height: 1.2,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Image.network(link,
            fit: BoxFit.fill,
            height: 170,
          ),
        ],
      ),
    );
  }
}