import 'package:bounty_hub_client/ui/pages/tasks_list/cubit/tasks_list_cubit.dart';
import 'package:bounty_hub_client/ui/pages/tasks_list/cubit/tasks_list_state.dart';
import 'package:bounty_hub_client/ui/pages/tasks_list/widgets/tasks_list_item.dart';
import 'package:bounty_hub_client/ui/widgets/app_list_bottom_loader.dart';
import 'package:bounty_hub_client/ui/widgets/empty_data_place_holder.dart';
import 'package:bounty_hub_client/utils/ui/dimens.dart';
import 'package:bounty_hub_client/utils/ui/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TasksListPage extends StatefulWidget {

  @override
  _TasksListPageState createState() => _TasksListPageState();
}

class _TasksListPageState extends State<TasksListPage> {
  final _scrollController = ScrollController();
  TasksListCubit _tasksCubit;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _tasksCubit = context.bloc<TasksListCubit>();
    _tasksCubit.fetchTasks(forceLoading: true);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TasksListCubit, TasksListState>(
      listener: (context, state) {
        if ((!state.hasReachedMax && _isBottom)  || state.status == TasksListStatus.refresh) {
          _tasksCubit.fetchTasks();
        }
      },
      builder: (context, state) {
        switch (state.status) {
          case TasksListStatus.failure:
            return const EmptyDataPlaceHolder();
          case TasksListStatus.success:
            if (state.tasks.isEmpty) {
              return const EmptyDataPlaceHolder();
            }
            return Container(
              margin: EdgeInsets.only(
                left: Dimens.content_padding,
                right: Dimens.content_padding,
                bottom: Dimens.content_internal_padding,
              ),
              decoration: WidgetsDecoration.appCardStyle(),
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return index >= state.tasks.length
                      ? state.tasks.length > 10 ? BottomLoader() : SizedBox()
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

  void _onScroll() {
    if (_isBottom) {
      _tasksCubit.fetchTasks();
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients)
      return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }


  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }
}