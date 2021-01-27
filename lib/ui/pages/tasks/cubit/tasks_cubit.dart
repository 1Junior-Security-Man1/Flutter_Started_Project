import 'package:bloc/bloc.dart';
import 'package:bounty_hub_client/data/repositories/campaigns_repository.dart';
import 'package:bounty_hub_client/ui/pages/tasks/cubit/tasks_state.dart';

class TasksCubit extends Cubit<TasksState> {
  CampaignRepository campaignRepository;

  TasksCubit(this.campaignRepository) : super(TasksState());

  void onTabClick(int index) {
    emit(state.copyWith(currentTab: index));
  }

  void getCompanies()async{
    var result = await campaignRepository.getAllCampaign();
    emit(state.copyWith(campaing:result));
  }
}