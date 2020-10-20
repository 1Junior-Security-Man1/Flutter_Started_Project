abstract class AuthenticationState {
  const AuthenticationState();
}

class InitialAuthentication extends AuthenticationState {}

class Uninitialized extends AuthenticationState {}

class Authenticated extends AuthenticationState {}

class Unauthenticated extends AuthenticationState {}

class Loading extends AuthenticationState {}