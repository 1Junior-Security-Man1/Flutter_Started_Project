import 'package:equatable/equatable.dart';

enum AuthorizationStatus { initial, error, complete, loading }

class AuthorizationState extends Equatable {
  final AuthorizationStatus status;
  final String errorMessage;
  final String email;
  final String confirmCode;
  final bool emailIsValid;

  const AuthorizationState({
    this.status = AuthorizationStatus.initial,
    this.errorMessage = '',
    this.email = '',
    this.confirmCode = '',
    this.emailIsValid = false,
  });

  AuthorizationState copyWith({
    AuthorizationStatus? status,
    String? errorMessage,
    String? email,
    String? confirmCode,
    bool? emailIsValid,
  }) {
    return AuthorizationState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      email: email ?? this.email,
      confirmCode: confirmCode ?? this.confirmCode,
      emailIsValid: emailIsValid ?? this.emailIsValid,
    );
  }

  @override
  List<Object> get props =>
      [email, status, errorMessage, confirmCode, emailIsValid];
}