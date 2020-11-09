import 'package:bounty_hub_client/data/repositories/campaigns_repository.dart';
import 'package:bounty_hub_client/data/repositories/tasks_repository.dart';
import 'package:bounty_hub_client/data/repositories/user_repository.dart';
import 'package:bounty_hub_client/ui/pages/task_details/cubit/task_details_cubit.dart';
import 'package:bounty_hub_client/ui/pages/task_details/widgets/task_details_content.dart';
import 'package:bounty_hub_client/utils/ui/colors.dart';
import 'package:bounty_hub_client/utils/ui/dimens.dart';
import 'package:bounty_hub_client/utils/validation/string_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TaskDetailsPage extends StatelessWidget {
  final String taskId;
  final String title;

  const TaskDetailsPage({Key key, this.taskId, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      backgroundColor: AppColors.pageBackgroundColor,
      body: BlocProvider(
        create: (_) => TaskDetailsCubit(
            context.repository<TaskRepository>(),
            context.repository<CampaignRepository>(),
            context.repository<UserRepository>(),
        ),
        child: TaskDetailsContent(taskId, title),
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
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: AppColors.navigationWidgetsColor,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
      title: Text(checkNullString(title),
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