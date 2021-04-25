import 'package:bloc/bloc.dart';
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
      : super(AuthenticationState(status: AuthenticationStatus.uninitialized));

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    if (event is AppStarted) {
      yield state.copyWith(status: AuthenticationStatus.loading);
    }

    if (event is SelectAuthenticationType) {
      _userRepository.saveGuestMode(event.type == AuthenticationType.guest);
      yield state.copyWith(
          type: event.type, status: AuthenticationStatus.selectAuthentication);
    }

    if (event is AppLoaded) {
      final String accessToken = await _userRepository.getAccessToken();
      if (accessToken != null && accessToken.isNotEmpty) {
        yield state.copyWith(
            status: AuthenticationStatus.authenticated, token: accessToken);
      } else {
        yield state.copyWith(
            status: AuthenticationStatus.unauthenticated, token: '');
      }
    }

    if (event is LoggedOut) {
      clearAppData(AppState.getContext());
      yield state.copyWith(
          status: AuthenticationStatus.unauthenticated,
          deepLinkConfirmCode: '',
          deepLinkEmail: '',
          token: '',
          signature: generateSignature());
    }

    if (event is LoggedIn) {
      yield state.copyWith(
          status: AuthenticationStatus.authenticated,
          signature: generateSignature());
    }
  }

  void clearAppData(BuildContext context) {
    _userRepository.removeAccessData();

    BlocProvider.of<AuthorizationCubit>(context).clearState();
    // clear states here if neededw
  }
}

void logout(BuildContext context) {
  Navigator.of(context).popUntil((route) => route.isFirst);
  BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
}
