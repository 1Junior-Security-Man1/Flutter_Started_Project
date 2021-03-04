import 'package:bounty_hub_client/ui/pages/my_tasks/my_tasks_page.dart';
import 'package:bounty_hub_client/ui/pages/tasks/cubit/tasks_cubit.dart';
import 'package:bounty_hub_client/ui/pages/tasks/cubit/tasks_state.dart';
import 'package:bounty_hub_client/ui/pages/tasks_list/tasks_list_page.dart';
import 'package:bounty_hub_client/ui/widgets/app_button.dart';
import 'package:bounty_hub_client/utils/localization/localization.res.dart';
import 'package:bounty_hub_client/utils/ui/dimens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TasksContent extends StatefulWidget {
  @override
  _TasksContentState createState() => _TasksContentState();
}

class _TasksContentState extends State<TasksContent> {

  TasksCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = context.bloc<TasksCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksCubit, TasksState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Stack(
            children: [
              Container(
                margin: EdgeInsets.only(left: Dimens.content_padding, right: Dimens.content_padding),
                height: 42,
                width: double.infinity,
                child: Row(
                  children: [
                    Expanded(
                      child: AppButton(
                        height: 42,
                        text: AppStrings.allTasks,
                        withShadow: state.currentTab == 0,
                        type: state.currentTab == 0?AppButtonType.BLUE:AppButtonType.WHITE,
                        onPressed: () {
                          _cubit.onTabClick(0);
                        },
                      ),
                    ),
                    SizedBox(width: Dimens.content_internal_padding),
                    Expanded(
                      child: AppButton(
                        height: 42,
                        text: AppStrings.myToDo,
                        withShadow: state.currentTab == 1,
                        type: state.currentTab == 1 ? AppButtonType.BLUE : AppButtonType.WHITE,
                        onPressed: () {
                          _cubit.onTabClick(1);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 42 + Dimens.content_internal_padding,),
                child: state.currentTab == 0 ? TasksListPage() : MyTasksPage(),
              ),
            ],
          ),
        );
      },
    );
  }
}