import 'package:bounty_hub_client/data/repositories/campaigns_repository.dart';
import 'package:bounty_hub_client/network/server_api.dart';
import 'package:bounty_hub_client/ui/pages/tasks/cubit/tasks_cubit.dart';
import 'package:bounty_hub_client/ui/pages/tasks/cubit/tasks_state.dart';
import 'package:bounty_hub_client/ui/pages/tasks/widgets/tasks_content.dart';
import 'package:bounty_hub_client/ui/widgets/top_sheet_widget.dart';
import 'package:bounty_hub_client/utils/localization/localization.res.dart';
import 'package:bounty_hub_client/utils/ui/colors.dart';
import 'package:bounty_hub_client/utils/ui/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:retrofit/http.dart';

import 'widgets/filter_dialog.dart';

class TasksPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      backgroundColor: AppColors.pageBackgroundColor,
      body: TasksContent(),
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
              BlocBuilder<TasksCubit, TasksState>(
                 builder: (context, state) =>
                  IconButton(
                    icon: Image.asset(
                      'assets/images/filter.png',
                      width: 26,
                    ),
                    onPressed: () {
                      FilterDialog.show(context, (_) {}, compaing:state.campaing);
                    },
                  ),
              ),
            ],
          ),
        ),
      ),
      title: Text(
        AppStrings.tasksList,
        style: AppTextStyles.titleTextStyle,
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