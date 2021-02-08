import 'package:bounty_hub_client/ui/pages/profile_page/view_profile/bloc/profile_bloc.dart';
import 'package:bounty_hub_client/ui/pages/profile_page/view_profile/bloc/profile_state.dart';
import 'package:bounty_hub_client/utils/ui/colors.dart';
import 'package:bounty_hub_client/utils/ui/styles.dart';
import 'package:bounty_hub_client/utils/ui/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:polygon_clipper/polygon_clipper.dart';

class LvlCardWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      cubit: context.bloc<ProfileBloc>(),
      builder: (context, state) {
        return Padding(
          padding:
          const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 30),
            decoration: WidgetsDecoration.appCardStyle().copyWith(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Container(
                    height: 70,
                    width: 70,
                    child: ClipPolygon(
                      sides: 6,
                      borderRadius: 12,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: <Color>[
                              AppColors.primaryColor,
                              AppColors.accentColor
                            ].reversed.toList(),
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: Text(
                                state.user?.userLevel?.name??'1',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20),
                              ),
                            ),
                            Center(
                                child: Text(
                                  'level',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 10),
                                )),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(state.user?.name ?? 'Guest', style:AppTextStyles.titleTextStyle,overflow: TextOverflow.ellipsis,),
                      Text(state.user?.email ?? '', style:AppTextStyles.titleTextStyle.copyWith(fontSize: 14),overflow: TextOverflow.ellipsis,),
                    ],),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
