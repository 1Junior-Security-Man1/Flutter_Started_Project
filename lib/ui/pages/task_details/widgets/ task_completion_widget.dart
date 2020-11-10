import 'package:bounty_hub_client/data/enums/task_validation_type.dart';
import 'package:bounty_hub_client/ui/pages/task_details/cubit/task_details_cubit.dart';
import 'package:bounty_hub_client/ui/pages/task_details/cubit/task_details_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TaskCompletionWidget extends StatefulWidget {
  @override
  TaskDetailsWidgetState createState() => TaskDetailsWidgetState();
}

class TaskDetailsWidgetState extends State<TaskCompletionWidget> {

  @override
  Widget build(BuildContext context) {
    return BlocListener<TaskDetailsCubit, TaskDetailsState>(
      listener: (context, state) {},
      child: BlocBuilder<TaskDetailsCubit, TaskDetailsState>(
        builder: (context, state) {
          switch(state.userTask.getTaskValidationType()) {
            case TaskValidationType.SOCIAL_PARSER:
              return Container();
            case TaskValidationType.AUTO_CHECK:
              return Container();
            default:
              return Container();
          }
        },
      ),
    );
  }
}