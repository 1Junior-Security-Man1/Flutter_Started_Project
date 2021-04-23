import 'package:bloc/bloc.dart';
import 'package:flutter_starter/data/app_data.dart';
import 'package:flutter_starter/data/repositories/auth_repository.dart';
import 'package:flutter_starter/data/repositories/user_repository.dart';
import 'package:flutter_starter/ui/pages/authorization/cubit/authorization_state.dart';
import 'package:dio/dio.dart';

class AuthorizationCubit extends Cubit<AuthorizationState> {
  final AuthRepository _loginRepository;
  final UserRepository _userRepository;

  AuthorizationCubit(this._loginRepository, this._userRepository)
      : super(AuthorizationState());

  void authenticate(String email, String password) {
    emit(state.copyWith(status: AuthorizationStatus.loading));
    _loginRepository.authenticate(state.email, password)
        .whenComplete(() {
      emit(state.copyWith(status: AuthorizationStatus.complete));
    }).catchError((Object obj) {
      switch (obj.runtimeType) {
        case DioError:
          final response = (obj as DioError).response;
          emit(state.copyWith(
              status: AuthorizationStatus.emailError,
              errorMessage: 'Something went wrong, please try later'));
      }
    });
  }

  void emailIsValid(value) {
    emit(state.copyWith(emailIsValid: value));
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
