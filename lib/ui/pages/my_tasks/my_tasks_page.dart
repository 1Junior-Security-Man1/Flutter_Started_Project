import 'package:bounty_hub_client/ui/widgets/app_list_bottom_loader.dart';
import 'package:bounty_hub_client/ui/pages/my_tasks/cubit/my_tasks_cubit.dart';
import 'package:bounty_hub_client/ui/widgets/empty_data_place_holder.dart';
import 'package:bounty_hub_client/utils/ui/colors.dart';
import 'package:bounty_hub_client/utils/ui/dimens.dart';
import 'package:bounty_hub_client/utils/ui/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/my_tasks_state.dart';
import 'widgets/my_task_item.dart';

class MyTasksPage extends StatefulWidget {

  @override
  _MyTasksPageState createState() => _MyTasksPageState();
}

class _MyTasksPageState extends State<MyTasksPage> {
  final _scrollController = ScrollController();
  MyTasksCubit _tasksCubit;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _tasksCubit = context.bloc<MyTasksCubit>();
    _tasksCubit.fetchTasks(forceLoading: true);
  }

  @override
  Widget build(BuildContext context) {
    return Theme(data: Theme.of(context).copyWith(canvasColor: Colors.white),
      child: RefreshIndicator(
        color: AppColors.accentColor,
        onRefresh:() async {
          _tasksCubit.refresh();
        },
        child: BlocConsumer<MyTasksCubit, MyTasksState>(
          listener: (context, state) {
            if ((!state.hasReachedMax && _isBottom) || state.status == MyTasksStatus.refresh) {
              _tasksCubit.fetchTasks();
            }
          },
          builder: (context, state) {
            switch (state.status) {
              case MyTasksStatus.failure:
                return const EmptyDataPlaceHolder();
              case MyTasksStatus.success:
                if (state.tasks.isEmpty) {
                  return const EmptyDataPlaceHolder();
                }
                return Container(
                  padding: EdgeInsets.only(bottom: 42.0),
                  margin: EdgeInsets.only(
                    left: Dimens.content_padding,
                    right: Dimens.content_padding,
                    bottom: Dimens.content_internal_padding,
                  ),
                  decoration: WidgetsDecoration.appCardStyle(),
                  child: ListView.builder(
                    physics: AlwaysScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return index >= state.tasks.length
                          ? state.tasks.length > 10 ? BottomLoader() : SizedBox()
                          : MyTaskItem(task: state.tasks[index]);
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
        ),
      ),
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