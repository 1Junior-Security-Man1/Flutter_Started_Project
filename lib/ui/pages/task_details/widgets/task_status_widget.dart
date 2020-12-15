import 'package:bounty_hub_client/ui/pages/task_details/cubit/task_details_cubit.dart';
import 'package:bounty_hub_client/ui/pages/task_details/cubit/task_details_state.dart';
import 'package:bounty_hub_client/ui/pages/task_details/widgets/task_status_bar_widget.dart';
import 'package:bounty_hub_client/ui/widgets/app_button.dart';
import 'package:bounty_hub_client/ui/widgets/app_progress_bar.dart';
import 'package:bounty_hub_client/utils/localization/localization.res.dart';
import 'package:bounty_hub_client/utils/ui/dimens.dart';
import 'package:bounty_hub_client/utils/validation/string_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TaskStatusWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskDetailsCubit, TaskDetailsState>(
        builder: (context, state) {
          if(state.userTaskStatus == UserTaskStatus.loading) {
            return Loading();
          } else if((state.userTaskStatus == UserTaskStatus.success || state.userTaskStatus == UserTaskStatus.take_success) && state.userTask != null) {
            return TaskStatusBarWidget(
              status: state.userTask.getTaskStatus(),
              approveDate: state.userTask.approveDate != null ? state.userTask.approveDate : null,
              confirmationDaysCount: checkNullInt(state.task.confirmationDaysCount, defaultValue: 1),
              height: Dimens.app_button_height,
            );
          } else {
            return AppButton(
              text: AppStrings.takeTask,
              width: MediaQuery.of(context).size.width / 2 - 20,
              height: Dimens.app_button_height,
              onPressed: () {
                context.bloc<TaskDetailsCubit>().onTakeTaskClick();
              },
            );
          }
        }
    );
  }
}