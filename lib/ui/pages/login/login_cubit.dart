import 'package:bloc/bloc.dart';
import 'login_state.dart';
import 'dart:developer' as developer;

class LoginCubit extends Cubit<LoginState> {

  LoginCubit() : super(InitialState());

  void authorize(String email) {
    emit(LoadingState());
    Future.delayed(Duration(seconds: 1), () {
      emit(CaptchaSentState(email));
    });
  }

  void confirmCode(String code) {
    developer.log('LoginCubit', name: 'confirmCode');
  }

  void captchaSecret(String secret) {
    developer.log('LoginCubit', name: 'confirmCode');
    // TODO authorize user and save credentials
  }

  void appStart() {
    developer.log('LoginCubit', name: 'appStart');
  }
}