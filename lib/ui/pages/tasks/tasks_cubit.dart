import 'package:bloc/bloc.dart';
import 'package:bounty_hub_client/ui/pages/tasks/tasks_state.dart';

class TasksCubit extends Cubit<TasksState> {
  
  TasksCubit() : super(TasksState());

  void onTabClick(int index) {
    emit(state.copyWith(currentTab: index));
  }
}