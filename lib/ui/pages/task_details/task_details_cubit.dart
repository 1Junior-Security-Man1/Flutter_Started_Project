import 'package:bloc/bloc.dart';
import 'package:bounty_hub_client/data/models/entity/task/task.dart';
import 'package:bounty_hub_client/data/repositories/campaigns_repository.dart';
import 'package:bounty_hub_client/data/repositories/tasks_repository.dart';
import 'package:bounty_hub_client/ui/pages/task_details/task_details_state.dart';
import 'package:logger/logger.dart';
import 'package:url_launcher/url_launcher.dart';

class TaskDetailsCubit extends Cubit<TaskDetailsState> {

  final log = Logger();

  final TaskRepository _taskRepository;

  final CampaignRepository _campaignRepository;

  TaskDetailsCubit(this._taskRepository, this._campaignRepository) : super(TaskDetailsState());

  void fetchTask(String taskId) async {
    _taskRepository.getTask(taskId)
        .then((task) {
          if(withCampaign(task)) {
            _fetchTaskCampaign(task);
          } else {
            emit(state.copyWith(task: task, campaign: null, status: TaskDetailsStatus.success));
          }
        })
        .catchError((Object obj) {
          log.e(obj);
          emit(state.copyWith(status: TaskDetailsStatus.failure));
        });
  }

  void _fetchTaskCampaign(Task task) async {
    _campaignRepository.getCampaign(task.campaignId)
        .then((campaign) {
          emit(state.copyWith(task: task, campaign: campaign, status: TaskDetailsStatus.success));
        })
        .catchError((Object obj) {
          log.e(obj);
          emit(state.copyWith(status: TaskDetailsStatus.failure));
        });
  }

  void launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  bool withCampaign(Task task) {
    return task.campaignId != null;
  }
}