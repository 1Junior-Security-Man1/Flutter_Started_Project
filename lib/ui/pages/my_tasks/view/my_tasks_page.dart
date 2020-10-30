import 'package:bounty_hub_client/data/repositories/tasks_repository.dart';
import 'package:bounty_hub_client/data/repositories/user_repository.dart';
import 'package:bounty_hub_client/ui/pages/my_tasks/my_tasks_cubit.dart';
import 'package:bounty_hub_client/ui/pages/my_tasks/view/list/my_tasks_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyTasksPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => MyTasksCubit(context.repository<TaskRepository>(), context.repository<UserRepository>()),
        child: MyTasksContent(),
      );
  }
}