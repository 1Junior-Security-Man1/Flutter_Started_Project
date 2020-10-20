import 'package:bounty_hub_client/data/models/api/response/token_response.dart';
import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {}

class InitialState extends LoginState {
  @override
  List<Object> get props => [];
}

class CaptchaSentState extends LoginState {
  final String email;

  CaptchaSentState(this.email);

  @override
  List<Object> get props => [email];
}

class LoadingState extends LoginState {
  @override
  List<Object> get props => [];
}

class EmailSentState extends LoginState {
  @override
  List<Object> get props => [];
}

class ConfirmCodeState extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginCompleteState extends LoginState {
  final TokenResponse _token;

  LoginCompleteState(this._token);

  TokenResponse getToken(){
    return _token;
  }

  @override
  List<Object> get props => [_token];
}

class ExceptionState extends LoginState {
  final String message;

  ExceptionState({this.message});

  @override
  List<Object> get props => [message];
}