import 'package:bloc/bloc.dart';
import 'package:bounty_hub_client/app.dart';
import 'package:bounty_hub_client/bloc/auth/authorization_state.dart';
import 'package:bounty_hub_client/data/repositories/user_repository.dart';
import 'package:bounty_hub_client/data/repositories/profile_local_repository.dart';
import 'package:bounty_hub_client/ui/pages/my_tasks/cubit/my_tasks_cubit.dart';
import 'package:bounty_hub_client/ui/pages/profile_page/view_profile/bloc/profile_bloc.dart';
import 'package:bounty_hub_client/ui/pages/tasks_list/cubit/tasks_list_cubit.dart';
import 'package:bounty_hub_client/ui/pages/tasks/cubit/tasks_cubit.dart';
import 'package:bounty_hub_client/ui/pages/activity/cubit/activity_cubit.dart';
import 'package:bounty_hub_client/bloc/badge/badge_cubit.dart';
import 'package:bounty_hub_client/utils/bloc_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'authentication_event.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {

  final UserRepository _userRepository;

  final ProfileLocalRepository _profileRepository;

  AuthenticationBloc(this._userRepository, this._profileRepository) : super(AuthenticationState(status: AuthenticationStatus.uninitialized));

  @override
  Stream<AuthenticationState> mapEventToState(AuthenticationEvent event) async* {
    if (event is AppStarted) {
      yield state.copyWith(status: AuthenticationStatus.loading);
    }
    if (event is SelectAuthenticationType) {
      _userRepository.saveGuestMode(event.type == AuthenticationType.guest);
      yield state.copyWith(type: event.type, status: AuthenticationStatus.selectAuthentication);
    }
    if (event is AppLoaded) {
      final String accessToken = await _userRepository.getAccessToken();
      if (accessToken != null && accessToken.isNotEmpty) {
        yield state.copyWith(status: AuthenticationStatus.authenticated, token: accessToken);
      } else {
        yield state.copyWith(status: AuthenticationStatus.unauthenticated, token: '');
      }
    }
    if (event is LoggedOut) {
      clearAppData(AppState.getContext());
      yield state.copyWith(status: AuthenticationStatus.unauthenticated, token: '', signature: generateSignature());
    }
    if (event is LoggedIn) {
      yield state.copyWith(status: AuthenticationStatus.authenticated, signature: generateSignature());
    }
  }

  void clearAppData(BuildContext context) {
    _userRepository.removeAccessData();
    _profileRepository.removeUserData();

    BlocProvider.of<TasksCubit>(context).destroy();
    BlocProvider.of<ActivityBadgeCubit>(context).destroy();
    BlocProvider.of<ActivityCubit>(context).destroy();
    BlocProvider.of<TasksListCubit>(context).destroy();
    BlocProvider.of<MyTasksCubit>(context).destroy();
    BlocProvider.of<ProfileBloc>(context).destroy();
  }
}

void logout(BuildContext context) {
  Navigator.of(context).popUntil((route) => route.isFirst);
  BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
}