import 'package:flutter_starter/bloc/auth/authentication_event.dart';
import 'package:equatable/equatable.dart';

enum AuthenticationStatus{ uninitialized, loading, authenticated, unauthenticated }

class AuthenticationState extends Equatable {
  final AuthenticationStatus? status;
  final AuthenticationType? authenticationType;
  final String? token;
  final int? signature;

  const AuthenticationState({
    this.token,
    this.status = AuthenticationStatus.uninitialized,
    this.authenticationType,
    this.signature,
  });

  AuthenticationState copyWith({
    AuthenticationStatus? status,
    String? token,
    String? deepLinkEmail,
    String? deepLinkConfirmCode,
    int? signature,
    AuthenticationType? type,
  }) {
    return AuthenticationState(
      authenticationType: type ?? this.authenticationType,
      signature: signature ?? this.signature,
      status: status ?? this.status,
      token: token ?? this.token,
    );
  }

  @override
  List<Object> get props => [authenticationType!, signature!, status!, token!];
}