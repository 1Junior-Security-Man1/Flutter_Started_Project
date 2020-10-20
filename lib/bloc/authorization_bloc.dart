import 'package:bloc/bloc.dart';
import 'package:bounty_hub_client/data/repositories/user_repository.dart';
import 'authentication_event.dart';
import 'authorization_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository _userRepository;

  AuthenticationBloc(this._userRepository) : super(InitialAuthentication());

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event,
      ) async* {

    if (event is AppStarted) {
      final bool hasToken = await _userRepository.getAccessToken() != null;

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