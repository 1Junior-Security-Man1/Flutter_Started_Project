import 'package:bloc/bloc.dart';
import 'package:bounty_hub_client/data/repositories/login_repository.dart';
import 'package:bounty_hub_client/data/repositories/user_repository.dart';
import 'package:bounty_hub_client/ui/pages/login/cubit/login_state.dart';
import 'package:dio/dio.dart';

class LoginCubit extends Cubit<LoginState> {

  final LoginRepository _loginRepository;

  final UserRepository _userRepository;

  LoginCubit(this._loginRepository, this._userRepository) : super(LoginState());

  void onEmailSubmitted(String email) {
    emit(state.copyWith(status: LoginStatus.loading));
    Future.delayed(Duration(seconds: 1), () {
      emit(state.copyWith(status: LoginStatus.captcha, email: email));
    });
  }

  void onBackButtonClick() {
    emit(state.copyWith(status: LoginStatus.email));
  }

  void authenticate(String captchaCode) {
    emit(state.copyWith(status: LoginStatus.loading));
    _loginRepository.authenticate(state.email, captchaCode)
        .then((it){
      emit(state.copyWith(status: LoginStatus.confirmCode));
    }).catchError((Object obj) {
      switch (obj.runtimeType) {
        case DioError:
          final response = (obj as DioError).response;
          if(response != null && response.data['message'] != null) {
            emit(state.copyWith(status: LoginStatus.emailError, errorMessage: response.data['message']));
          } else {
            emit(state.copyWith(status: LoginStatus.emailError, errorMessage: 'Something went wrong, please try later'));
          }
          break;
        default:
          emit(state.copyWith(status: LoginStatus.emailError, errorMessage: 'Something went wrong, please try later'));
      }
    });
  }

  void confirmCode(String code) {
    emit(state.copyWith(status: LoginStatus.loading));
    _loginRepository.confirmCode(state.email, code)
        .then((value) => _userRepository.saveAccessToken(value))
        .then((value) => emit(state.copyWith(status: LoginStatus.complete)))
        .catchError((Object obj) {
      switch (obj.runtimeType) {
        case DioError:
          final response = (obj as DioError).response;
          if(response != null && response.data['message'] != null) {
            emit(state.copyWith(status: LoginStatus.confirmCodeError, errorMessage: response.data['message']));
          } else {
            emit(state.copyWith(status: LoginStatus.confirmCodeError, errorMessage: 'Something went wrong, please try later'));
          }
          break;
        default:
          emit(state.copyWith(status: LoginStatus.confirmCodeError, errorMessage: 'Something went wrong, please try later'));
      }
    });
  }

  void emailIsValid(value) {
    emit(state.copyWith(emailIsValid: value));
  }
}