import 'package:bounty_hub_client/ui/pages/tasks/tasks_cubit.dart';
import 'package:bounty_hub_client/ui/pages/tasks/tasks_state.dart';
import 'package:bounty_hub_client/ui/pages/tasks/view/list/tasks_list_item.dart';
import 'package:bounty_hub_client/ui/widgets/app_list_bottom_loader.dart';
import 'package:bounty_hub_client/ui/widgets/empty_data_place_holder.dart';
import 'package:bounty_hub_client/utils/ui/dimens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TasksList extends StatefulWidget {
  @override
  _TasksListState createState() => _TasksListState();
}

class _TasksListState extends State<TasksList> {
  final _scrollController = ScrollController();
  TasksCubit _tasksCubit;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _tasksCubit = context.bloc<TasksCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TasksCubit, TasksState>(
      listener: (context, state) {
        if (!state.hasReachedMax && _isBottom) {
          _tasksCubit.fetchTasks();
        }
      },
      builder: (context, state) {
        switch (state.status) {
          case TasksStatus.failure:
            return const EmptyDataPlaceHolder();
          case TasksStatus.success:
            if (state.tasks.isEmpty) {
              return const EmptyDataPlaceHolder();
            }
            return Container(
              margin: EdgeInsets.all(Dimens.content_padding),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return index >= state.tasks.length
                      ? BottomLoader()
                      : TasksListItem(task: state.tasks[index]);
                },
                itemCount: state.hasReachedMax
                    ? state.tasks.length
                    : state.tasks.length + 1,
                controller: _scrollController,
              ),
            );
          default:
            return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) _tasksCubit.fetchTasks();
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}