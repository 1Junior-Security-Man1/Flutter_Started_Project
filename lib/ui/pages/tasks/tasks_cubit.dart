import 'package:bloc/bloc.dart';
import 'package:bounty_hub_client/data/models/entity/task/task.dart';
import 'package:bounty_hub_client/data/repositories/tasks_repository.dart';
import 'package:bounty_hub_client/data/repositories/user_repository.dart';
import 'package:bounty_hub_client/ui/pages/tasks/tasks_state.dart';
import 'package:logger/logger.dart';

class TasksCubit extends Cubit<TasksState> {

  final log = Logger();

  int page = 1;

  bool fetching = false;

  final TaskRepository _taskRepository;

  final UserRepository _userRepository;

  TasksCubit(this._taskRepository, this._userRepository) : super(TasksState());

  void fetchTasks() async {
    if (state.hasReachedMax) {
      emit(state);
      return;
    }

    String userId = await _userRepository.getUserId();
    if (state.status == TasksStatus.initial && !fetching) {
      final tasks = await _fetchTasks(userId, 0);
      emit(state.copyWith(
        status: TasksStatus.success,
        tasks: tasks,
        hasReachedMax: false,
      ));
      return;
    }

    if(fetching) return;
    final tasks = await _fetchTasks(userId, page);
    if(tasks == null || tasks.isEmpty) {
      emit(state.copyWith(hasReachedMax: true));
    } else {
      emit(state.copyWith(
        status: TasksStatus.success,
        tasks: List.of(state.tasks)..addAll(tasks),
        hasReachedMax: false,
      ));
      page++;
    }
  }

  Future<List<Task>> _fetchTasks(String userId, int page) async {
    fetching = true;
    return _taskRepository.getTasks(userId, page)
        .then((value) => value.content)
        .whenComplete(() => fetching = false)
        .catchError((Object obj) {
          log.e(obj);
          fetching = false;
          emit(state.copyWith(status: TasksStatus.failure));
        });
  }
}