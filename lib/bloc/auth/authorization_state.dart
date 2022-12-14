import 'package:flutter_starter/bloc/auth/authentication_event.dart';
import 'package:equatable/equatable.dart';

enum AuthenticationStatus{ uninitialized, loading, authenticated, unauthenticated }

class AuthenticationState extends Equatable {
  final AuthenticationStatus status;
  final AuthenticationType authenticationType;
  final String token;

  const AuthenticationState({
    this.token = '',
    this.status = AuthenticationStatus.uninitialized,
    this.authenticationType = AuthenticationType.uninitialized,
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
      status: status ?? this.status,
      token: token ?? this.token,
    );
  }

  @override
  List<Object> get props => [authenticationType, status, token];
}