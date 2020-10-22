import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

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

class ConfirmCodeInputState extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginCompleteState extends LoginState {
  final String token;

  LoginCompleteState({@required this.token});

  @override
  List<Object> get props => [token];
}

class EmailExceptionState extends LoginState {
  final String message;

  EmailExceptionState(this.message);

  @override
  List<Object> get props => [message];
}

class ConfirmCodeExceptionState extends LoginState {
  final String message;

  ConfirmCodeExceptionState(this.message);

  @override
  List<Object> get props => [message];
}