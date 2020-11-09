import 'package:bloc/bloc.dart';
import 'package:bounty_hub_client/data/models/entity/campaign/campaign.dart';
import 'package:bounty_hub_client/data/models/entity/task/task.dart';
import 'package:bounty_hub_client/data/repositories/campaigns_repository.dart';
import 'package:bounty_hub_client/data/repositories/tasks_repository.dart';
import 'package:bounty_hub_client/data/repositories/user_repository.dart';
import 'package:bounty_hub_client/ui/pages/task_details/cubit/task_details_state.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:url_launcher/url_launcher.dart';

class TaskDetailsCubit extends Cubit<TaskDetailsState> {

  final log = Logger();

  final TaskRepository _taskRepository;

  final CampaignRepository _campaignRepository;

  final UserRepository _userRepository;

  TaskDetailsCubit(this._taskRepository, this._campaignRepository, this._userRepository) : super(TaskDetailsState());

  void fetchTask(String taskId) async {
    _taskRepository.getTask(taskId)
        .then((task) {
          if(withCampaign(task)) {
            _fetchTaskCampaign(task);
          } else {
            whenComplete(task: task);
          }
        })
        .catchError((Object obj) {
          log.e(obj);
          emit(state.copyWith(status: TaskDetailsStatus.failure));
        });
  }

  void _fetchUserTask(String taskId) async {
    String userId = await _userRepository.getUserId();
    _taskRepository.getUserTask(userId, taskId)
        .then((userTask) {
          emit(state.copyWith(userTask: userTask, userTaskStatus: UserTaskStatus.success));
        })
        .catchError((Object obj) {
          emit(state.copyWith(userTaskStatus: UserTaskStatus.failure));
        });
  }

  void _fetchTaskCampaign(Task task) async {
    _campaignRepository.getCampaign(task.campaignId)
        .then((campaign) {
          whenComplete(task: task, campaign: campaign);
        })
        .catchError((Object obj) {
          log.e(obj);
          emit(state.copyWith(status: TaskDetailsStatus.failure));
        });
  }

  void _takeTask() async {
    String userId = await _userRepository.getUserId();
    emit(state.copyWith(userTaskStatus: UserTaskStatus.loading));
    _taskRepository.takeTask(userId, state.task.id)
        .then((userTask) {
          emit(state.copyWith(userTask: userTask, userTaskStatus: UserTaskStatus.take_success));
        })
        .catchError((Object obj) {
          switch (obj.runtimeType) {
            case DioError:
              final response = (obj as DioError).response;
              if(response != null && response.data['message'] != null) {
                emit(state.copyWith(userTaskStatus: UserTaskStatus.take_failure, errorMessage: response.data['message']));
              } else {
                emit(state.copyWith(userTaskStatus: UserTaskStatus.take_failure, errorMessage: null));
              }
              break;
            default:
              emit(state.copyWith(userTaskStatus: UserTaskStatus.take_failure, errorMessage: null));
          }
        });
  }

  void whenComplete({Task task, Campaign campaign}) {
    emit(state.copyWith(task: task, campaign: campaign, status: TaskDetailsStatus.success));
    _fetchUserTask(task.id);
  }

  void launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  bool withCampaign(Task task) {
    return task.campaignId != null;
  }

  void onTakeTaskClick() {
    _takeTask();
  }
}