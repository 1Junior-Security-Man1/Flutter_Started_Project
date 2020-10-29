import 'package:bloc/bloc.dart';
import 'package:bounty_hub_client/data/models/entity/task.dart';
import 'package:bounty_hub_client/data/repositories/campaigns_repository.dart';
import 'package:bounty_hub_client/data/repositories/tasks_repository.dart';
import 'package:bounty_hub_client/ui/pages/task_details/task_details_state.dart';
import 'package:logger/logger.dart';

class TaskDetailsCubit extends Cubit<TaskDetailsState> {

  final log = Logger();

  final TaskRepository _taskRepository;

  final CampaignRepository _campaignRepository;

  TaskDetailsCubit(this._taskRepository, this._campaignRepository) : super(TaskDetailsState());

  Future<Task> fetchTask(String taskId) async {
    return _taskRepository.getTask(taskId)
        .then((task) {
          emit(state.copyWith(task: task, status: TaskDetailsStatus.success));
        })
        .catchError((Object obj) {
      log.e(obj);
      emit(state.copyWith(status: TaskDetailsStatus.failure));
    });
  }
}