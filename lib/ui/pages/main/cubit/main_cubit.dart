import 'package:bloc/bloc.dart';
import 'package:flutter_starter/data/repositories/tasks_repository.dart';
import 'package:flutter_starter/ui/pages/main/cubit/main_state.dart';

class MainCubit extends Cubit<MainState> {

  final TaskRepository _taskRepository;

  MainCubit(this._taskRepository) : super(MainState());

  void setCurrentNavigationItem(int index) {
    emit(state.copyWith(currentNavigationItem: index));
  }
}