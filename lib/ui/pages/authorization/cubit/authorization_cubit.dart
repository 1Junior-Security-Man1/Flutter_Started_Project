import 'package:bloc/bloc.dart';
import 'package:flutter_starter/data/repositories/auth_repository.dart';
import 'package:flutter_starter/data/repositories/user_repository.dart';
import 'package:flutter_starter/ui/pages/authorization/cubit/authorization_state.dart';
import 'package:dio/dio.dart';

class AuthorizationCubit extends Cubit<AuthorizationState> {
  final AuthRepository _loginRepository;

  AuthorizationCubit(this._loginRepository) : super(AuthorizationState());

  void authenticate(String email, String password) {
    emit(state.copyWith(status: AuthorizationStatus.loading));
    _loginRepository.authenticate(state.email, password).whenComplete(() {
      emit(state.copyWith(status: AuthorizationStatus.complete));
    }).catchError((Object obj) {
      switch (obj.runtimeType) {
        case DioError:
          final response = (obj as DioError).response;
          emit(state.copyWith(
              status: AuthorizationStatus.error,
              errorMessage: 'Something went wrong, please try later $response'));
      }
    });
  }

  void emailIsValid(value) {
    emit(state.copyWith(emailIsValid: value));
  }

  void clearState() {
    emit(state.copyWith(
        email: '',
        confirmCode: '',
        status: AuthorizationStatus.initial,
        emailIsValid: false));
  }
}