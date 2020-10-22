import 'package:bloc/bloc.dart';
import 'package:bounty_hub_client/data/repositories/user_repository.dart';
import 'authentication_event.dart';
import 'authorization_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {

  final UserRepository _userRepository;

  AuthenticationBloc(this._userRepository) : super(Uninitialized());

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event,
      ) async* {

    if (event is AppStarted) {
      final String token = await _userRepository.getAccessToken();
      if (token != null) {
        yield Authenticated(token: token);
      } else {
        yield Unauthenticated();
      }
    }
  }
}