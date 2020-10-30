import 'package:bounty_hub_client/ui/pages/tasks/tasks_cubit.dart';
import 'package:bounty_hub_client/ui/pages/tasks/view/tasks_content.dart';
import 'package:bounty_hub_client/utils/localization/app_localizations.dart';
import 'package:bounty_hub_client/utils/ui/colors.dart';
import 'package:bounty_hub_client/utils/ui/dimens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TasksPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      backgroundColor: AppColors.pageBackgroundColor,
      body: BlocProvider(
        create: (_) => TasksCubit(),
        child: TasksContent(),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
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
                  'assets/images/filter.png',
                  width: 26,
                ),
                onPressed: () {
                  // do something
                },
              ),
            ],
          ),
        ),
      ),
      title: Text(
        Strings.of(context).get('tasks_list'),
        style: TextStyle(
          color: AppColors.appBarTextColor,
          fontWeight: FontWeight.w600,
          fontSize: Dimens.app_bar_text_size,
        ),
      ),
      actions: <Widget>[
        IconButton(
          icon: Image.asset(
            'assets/images/settings.png',
            width: 26,
          ),
          onPressed: () {
            // do something
          },
        ),
      ],
    );
  }
}