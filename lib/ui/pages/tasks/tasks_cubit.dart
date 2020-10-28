import 'package:bloc/bloc.dart';
import 'package:bounty_hub_client/data/models/entity/task.dart';
import 'package:bounty_hub_client/data/repositories/tasks_repository.dart';
import 'package:bounty_hub_client/ui/pages/tasks/tasks_state.dart';
import 'package:logger/logger.dart';

class TasksCubit extends Cubit<TasksState> {

  final log = Logger();

  int page = 1;

  final TaskRepository _taskRepository;

  TasksCubit(this._taskRepository) : super(TasksState());

  void fetchTasks() async {
    if (state.hasReachedMax) emit(state);

    if (state.status == TasksStatus.initial) {
      final tasks = await _fetchTasks(0);
      emit(state.copyWith(
        status: TasksStatus.success,
        tasks: tasks,
        hasReachedMax: false,
      ));
      return;
    }

    final tasks = await _fetchTasks(page);
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

  Future<List<Task>> _fetchTasks(int page) async {
    return _taskRepository.getTasks(page)
        .then((value) => value.content)
        .catchError((Object obj) {
          log.e(obj);
          emit(state.copyWith(status: TasksStatus.failure));
        });
  }
}