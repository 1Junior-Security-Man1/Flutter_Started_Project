import 'package:bloc/bloc.dart';
import 'package:bounty_hub_client/data/repositories/tasks_repository.dart';
import 'package:bounty_hub_client/ui/pages/main/main_state.dart';

class MainCubit extends Cubit<MainState> {

  final TaskRepository _taskRepository;

  MainCubit(this._taskRepository) : super(MainState());
}