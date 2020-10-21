import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {}

class InitialState extends LoginState {
  @override
  List<Object> get props => [];
}

class CaptchaInputState extends LoginState {
  CaptchaInputState();

  @override
  List<Object> get props => [];
}

class LoadingState extends LoginState {
  @override
  List<Object> get props => [];
}

class EmailSentState extends LoginState {
  @override
  List<Object> get props => [];
}

class ConfirmCodeInputState extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginCompleteState extends LoginState {

  LoginCompleteState();

  @override
  List<Object> get props => [];
}

class ExceptionState extends LoginState {
  final String message;

  ExceptionState(this.message);

  @override
  List<Object> get props => [message];
}