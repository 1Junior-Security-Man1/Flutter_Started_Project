import 'package:bloc/bloc.dart';
import 'package:bounty_hub_client/data/repositories/user_repository.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({UserRepository userRepository}) : super(InitialState());

  void authorize(String text) {}

  void confirmCode(String code) {}

  void appStart() {}
}