import 'package:equatable/equatable.dart';

enum AuthorizationStatus{ email, captcha, confirmCode, complete, emailError, confirmCodeError, loading }

class AuthorizationState extends Equatable {
  const AuthorizationState({
    this.status = AuthorizationStatus.email,
    this.errorMessage,
    this.email,
    this.confirmCode,
    this.emailIsValid = false,
  });

  final AuthorizationStatus status;
  final String errorMessage;
  final String email;
  final String confirmCode;
  final bool emailIsValid;

  AuthorizationState copyWith({
    AuthorizationStatus status,
    String errorMessage,
    String email,
    String confirmCode,
    bool emailIsValid,
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
  List<Object> get props => [email, status, errorMessage, confirmCode,emailIsValid];
}