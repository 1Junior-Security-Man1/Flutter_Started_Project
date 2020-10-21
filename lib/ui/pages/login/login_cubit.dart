import 'package:bloc/bloc.dart';
import 'package:bounty_hub_client/data/repositories/login_repository.dart';
import 'package:bounty_hub_client/data/repositories/user_repository.dart';
import 'package:dio/dio.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {

  final LoginRepository _loginRepository;

  final UserRepository _userRepository;

  LoginCubit(this._loginRepository, this._userRepository) : super(InitialState());

  void onEmailSubmitted(String email) {
    _userRepository.setEmail(email);
    emit(LoadingState());
    Future.delayed(Duration(seconds: 1), () {
      emit(CaptchaInputState());
    });
  }

  void onConfirmCodeSubmitted(String confirmCode) {
    _userRepository.setConfirmCode(confirmCode);
  }

  void authenticate(String captchaCode) {
    emit(LoadingState());
    _loginRepository.authenticate(_userRepository.getEmail(), captchaCode)
        .then((it){
      emit(ConfirmCodeInputState());
    }).catchError((Object obj) {
      switch (obj.runtimeType) {
        case DioError:
          final response = (obj as DioError).response;
          if(response != null && response.data['message'] != null) {
            emit(ExceptionState(response.data['message']));
          } else {
            emit(ExceptionState('Something went wrong, please try later'));
          }
          break;
        default:
          emit(ExceptionState('Something went wrong, please try later'));
      }
    });
  }

  void confirmCode() {
    emit(LoadingState());
    _loginRepository.confirmCode(_userRepository.getEmail(), _userRepository.getConfirmCode())
        .then((value) => _userRepository.saveAccessToken(value))
        .then((it){ emit(LoginCompleteState()); })
        .catchError((Object obj) {
      switch (obj.runtimeType) {
        case DioError:
          final response = (obj as DioError).response;
          if(response != null && response.data['message'] != null) {
            emit(ExceptionState(response.data['message']));
          } else {
            emit(ExceptionState('Something went wrong, please try later'));
          }
          break;
        default:
          emit(ExceptionState('Something went wrong, please try later'));
      }
    });
  }

  void resetState() {
    emit(InitialState());
  }
}