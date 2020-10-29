import 'package:bounty_hub_client/ui/pages/tasks/tasks_cubit.dart';
import 'package:bounty_hub_client/ui/pages/tasks/view/list/tasks_list.dart';
import 'package:bounty_hub_client/utils/localization/app_localizations.dart';
import 'package:bounty_hub_client/utils/ui/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TasksPage extends StatefulWidget {
  @override
  _TasksPageState createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {

  TasksCubit _tasksCubit;

  @override
  void initState() {
    super.initState();
    _tasksCubit = context.bloc<TasksCubit>();
    _tasksCubit.fetchTasks();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Scaffold(
        appBar: AppBar(
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
              fontSize: 18,
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
        ),
        backgroundColor: AppColors.pageBackgroundColor,
        body: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: TasksList(),
        ),
      ),
    );
  }
}