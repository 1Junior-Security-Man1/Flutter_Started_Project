import 'package:bounty_hub_client/ui/pages/my_tasks/cubit/my_tasks_cubit.dart';
import 'package:bounty_hub_client/ui/pages/tasks/cubit/tasks_cubit.dart';
import 'package:bounty_hub_client/ui/pages/tasks/cubit/tasks_state.dart';
import 'package:bounty_hub_client/ui/pages/tasks/widgets/filter_dialog.dart';
import 'package:bounty_hub_client/ui/pages/tasks/widgets/tasks_content.dart';
import 'package:bounty_hub_client/ui/pages/tasks_list/cubit/tasks_list_cubit.dart';
import 'package:bounty_hub_client/ui/widgets/settings_menu_dialog.dart';
import 'package:bounty_hub_client/utils/localization/localization.res.dart';
import 'package:bounty_hub_client/utils/ui/colors.dart';
import 'package:bounty_hub_client/utils/ui/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
                      TasksListCubit allTasksCubit = context.bloc<TasksListCubit>();
                      MyTasksCubit myTasksCubit = context.bloc<MyTasksCubit>();

                      FilterDialog.show(allTasksCubit.filterEntity, context, (selectedEntity) {
                        allTasksCubit.filterEntity = selectedEntity;
                        myTasksCubit.filterEntity = selectedEntity;

                        allTasksCubit.destroy();
                        allTasksCubit.fetchTasks();

                        myTasksCubit.destroy();
                        myTasksCubit.fetchTasks();
                      }, campaign:state.campaigns, selectedEntity:FilterEntity(null, null));
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
            SettingsMenuDialog.show(context, () { });
          },
        ),
      ],
    );
  }
}