import 'package:flutter_starter/app.dart';
import 'package:flutter_starter/bloc/auth/authorization_state.dart';
import 'package:flutter_starter/data/repositories/user_repository.dart';
import 'package:flutter_starter/ui/pages/authorization/cubit/authorization_cubit.dart';
import 'package:flutter_starter/utils/bloc_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'authentication_event.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository _userRepository;

  AuthenticationBloc(this._userRepository)
      : super(AuthenticationState(status: AuthenticationStatus.uninitialized)){
    on<AppStarted>((event, emit) async{
      emit(state.copyWith(status: AuthenticationStatus.loading));
    });
    on<AppLoaded>((event, emit) async{
      final String? accessToken = await _userRepository.getAccessToken();
      if (accessToken != null && accessToken.isNotEmpty) {
         emit(state.copyWith(status: AuthenticationStatus.authenticated, token: accessToken));
      } else {
        emit(state.copyWith(status: AuthenticationStatus.unauthenticated, token: ''));
      }
    });
    on<LoggedOut>((event, emit) async{
      clearAppData(AppState.getContext());
      emit(state.copyWith(
          status: AuthenticationStatus.unauthenticated,
          deepLinkConfirmCode: '',
          deepLinkEmail: '',
          token: '',
          signature: generateSignature()));
    });
    on<LoggedIn>((event, emit) async{
      emit(state.copyWith(
          status: AuthenticationStatus.authenticated,
          signature: generateSignature()));
    });
  }

  void clearAppData(BuildContext context) {
    _userRepository.removeAccessData();

    BlocProvider.of<AuthorizationCubit>(context).clearState();
    // clear other states here if needed
  }
}

void logout(BuildContext context) {
  Navigator.of(context).popUntil((route) => route.isFirst);
  BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
}