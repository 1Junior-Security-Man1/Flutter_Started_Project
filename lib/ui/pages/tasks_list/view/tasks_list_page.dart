import 'package:bounty_hub_client/data/repositories/tasks_repository.dart';
import 'package:bounty_hub_client/data/repositories/user_repository.dart';
import 'package:bounty_hub_client/ui/pages/tasks_list/tasks_list_cubit.dart';
import 'package:bounty_hub_client/ui/pages/tasks_list/view/list/tasks_list_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TasksListPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => TasksListCubit(context.repository<TaskRepository>(), context.repository<UserRepository>()),
        child: TasksListContent(),
      );
  }
}