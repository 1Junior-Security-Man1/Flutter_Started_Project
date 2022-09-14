import 'package:bloc/bloc.dart';
import 'package:flutter_starter/ui/pages/main/cubit/main_state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(MainState());
  void setCurrentNavigationItem(int index) {
    emit(state.copyWith(currentNavigationItem: index));
  }
}