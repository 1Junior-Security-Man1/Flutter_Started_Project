import 'package:equatable/equatable.dart';

enum AuthenticationStatus{ uninitialized, loading, authenticated, unauthenticated }

class AuthenticationState extends Equatable {

  const AuthenticationState({
    this.token,
    this.status = AuthenticationStatus.uninitialized,
    this.signature, // TODO hard fix. Block does not respond to the change of the AuthenticationStatus enum only to the change of the String field
  });

  final AuthenticationStatus status;
  final String token;
  final int signature;

  AuthenticationState copyWith({
    AuthenticationStatus status,
    String token,
    int signature,
  }) {
    return AuthenticationState(
      signature: signature ?? this.signature,
      status: status ?? this.status,
      token: token ?? this.token,
    );
  }

  @override
  List<Object> get props => [signature, status, token];
}