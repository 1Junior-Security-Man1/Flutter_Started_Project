import 'package:bloc/bloc.dart';
import 'authentication_event.dart';
import 'authorization_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {

  AuthenticationBloc() : super(Uninitialized());

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event,
      ) async* {

    if (event is AppStarted) {
      //final bool hasToken = await _userRepository.getAccessToken() != null;
      final bool hasToken = false;
      if (hasToken) {
        yield Authenticated();
      } else {
        yield Unauthenticated();
      }
    }

    if (event is LoggedIn) {
      yield Loading();
      yield Authenticated();
    }

    if (event is LoggedOut) {
      yield Loading();
      yield Unauthenticated();
    }
  }
}