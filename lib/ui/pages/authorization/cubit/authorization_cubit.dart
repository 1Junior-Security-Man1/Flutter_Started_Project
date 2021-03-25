import 'package:bloc/bloc.dart';
import 'package:bounty_hub_client/data/app_data.dart';
import 'package:bounty_hub_client/data/repositories/auth_repository.dart';
import 'package:bounty_hub_client/data/repositories/user_repository.dart';
import 'package:bounty_hub_client/ui/pages/authorization/cubit/authorization_state.dart';
import 'package:dio/dio.dart';

class AuthorizationCubit extends Cubit<AuthorizationState> {

  final AuthRepository _loginRepository;

  final UserRepository _userRepository;

  AuthorizationCubit(this._loginRepository, this._userRepository) : super(AuthorizationState());

  void authenticate(String captchaCode) {
    emit(state.copyWith(status: AuthorizationStatus.loading));
    _loginRepository.getBasicToken()
        .then((basicToken) => AppData.instance.saveBasicToken(basicToken))
        .then((it) => _loginRepository.authenticate(state.email, captchaCode))
        .whenComplete(() {
          emit(state.copyWith(status: AuthorizationStatus.confirmCode));
        }).catchError((Object obj) {
          switch (obj.runtimeType) {
            case DioError:
              final response = (obj as DioError).response;
              if(response != null && response.data['message'] != null) {
                emit(state.copyWith(status: AuthorizationStatus.emailError, errorMessage: response.data['message']));
              } else {
                emit(state.copyWith(status: AuthorizationStatus.emailError, errorMessage: 'Something went wrong, please try later'));
              }
              break;
            default:
              emit(state.copyWith(status: AuthorizationStatus.emailError, errorMessage: 'Something went wrong, please try later'));
          }
        });
  }

  void confirmCode(String code) {
    if(code == null || code.isEmpty) return;

    emit(state.copyWith(status: AuthorizationStatus.loading));
    _loginRepository.confirmCode(state.email, code)
        .then((value) => _userRepository.saveAccessToken(value))
        .then((value) => emit(state.copyWith(status: AuthorizationStatus.complete)))
        .catchError((Object obj) {
      switch (obj.runtimeType) {
        case DioError:
          final response = (obj as DioError).response;
          if(response != null && response.data['message'] != null) {
            emit(state.copyWith(status: AuthorizationStatus.confirmCodeError, errorMessage: response.data['message']));
          } else {
            emit(state.copyWith(status: AuthorizationStatus.confirmCodeError, errorMessage: 'Something went wrong, please try later'));
          }
          break;
        default:
          emit(state.copyWith(status: AuthorizationStatus.confirmCodeError, errorMessage: 'Something went wrong, please try later'));
      }
    });
  }

  void setDeepLinkData(String email, String confirmCode) {
      emit(state.copyWith(email: email,
          confirmCode: confirmCode,
          status: AuthorizationStatus.confirmCode));
  }

  void emailIsValid(value) {
    emit(state.copyWith(emailIsValid: value));
  }

  void onEmailSubmitted(String email) {
    emit(state.copyWith(status: AuthorizationStatus.loading));
    Future.delayed(Duration(seconds: 1), () {
      emit(state.copyWith(status: AuthorizationStatus.captcha, email: email));
    });
  }

  void onBack() {
    emit(state.copyWith(status: AuthorizationStatus.email));
  }

  void clearState() {
    emit(state.copyWith(
        email: '',
        confirmCode: '',
        status: AuthorizationStatus.email,
        emailIsValid: false));
  }
}