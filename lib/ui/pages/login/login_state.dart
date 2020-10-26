import 'package:equatable/equatable.dart';

enum LoginStatus{ email, captcha, confirmCode, complete, emailError, confirmCodeError, loading }

class LoginState extends Equatable {
  const LoginState({
    this.status = LoginStatus.email,
    this.errorMessage,
    this.email,
    this.confirmCode,
  });

  final LoginStatus status;
  final String errorMessage;
  final String email;
  final String confirmCode;

  LoginState copyWith({
    LoginStatus status,
    String errorMessage,
    String email,
    String confirmCode,
  }) {
    return LoginState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      email: email ?? this.email,
      confirmCode: confirmCode ?? this.confirmCode,
    );
  }

  @override
  List<Object> get props => [email, status, errorMessage, confirmCode];
}