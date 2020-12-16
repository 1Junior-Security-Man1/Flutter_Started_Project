import 'package:bloc/bloc.dart';
import 'package:bounty_hub_client/data/models/entity/user_task/user_task.dart';
import 'package:bounty_hub_client/data/repositories/tasks_repository.dart';
import 'package:bounty_hub_client/data/repositories/user_repository.dart';
import 'package:bounty_hub_client/ui/pages/my_tasks/cubit/my_tasks_state.dart';
import 'package:logger/logger.dart';

class MyTasksCubit extends Cubit<MyTasksState> {

  final log = Logger();
  final TaskRepository _taskRepository;
  final UserRepository _userRepository;
  int page = 1;
  bool fetching = false;

  MyTasksCubit(this._taskRepository, this._userRepository) : super(MyTasksState());

  void fetchMyTasks() async {
    if (state.hasReachedMax) {
      emit(state);
      return;
    }

    String userId = await _userRepository.getUserId();
    if (state.status == MyTasksStatus.initial && !fetching) {
      final tasks = await _fetchMyTasks(userId, 0);
      emit(state.copyWith(
        status: MyTasksStatus.success,
        tasks: tasks,
        hasReachedMax: false,
      ));
      return;
    }

    if(fetching) return;
    final tasks = await _fetchMyTasks(userId, page);
    if(tasks == null || tasks.isEmpty) {
      emit(state.copyWith(hasReachedMax: true));
    } else {
      emit(state.copyWith(
        status: MyTasksStatus.success,
        tasks: List.of(state.tasks)..addAll(tasks),
        hasReachedMax: false,
      ));
      page++;
    }
  }

  Future<List<UserTask>> _fetchMyTasks(String userId, int page) async {
    fetching = true;
    return _taskRepository.getUserTasks(userId, page)
        .then((value) => value.content)
        .whenComplete(() => fetching = false)
        .catchError((Object obj) {
          log.e(obj);
          fetching = false;
          emit(state.copyWith(status: MyTasksStatus.failure));
        });
  }
}