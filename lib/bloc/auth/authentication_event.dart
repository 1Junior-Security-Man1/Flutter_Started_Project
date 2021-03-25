import 'package:equatable/equatable.dart';

enum AuthenticationType{ uninitialized, credentials, facebook, google, twitter, telegram, guest }

abstract class AuthenticationEvent extends Equatable {
  AuthenticationEvent([List props = const []]);
}

class AppStarted extends AuthenticationEvent {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'AppStarted';
}

class AppLoaded extends AuthenticationEvent {

  final String deepLinkConfirmCode;

  final String deepLinkEmail;

  AppLoaded({this.deepLinkEmail, this.deepLinkConfirmCode});

  @override
  List<Object> get props => [deepLinkConfirmCode, deepLinkEmail];

  @override
  String toString() => 'AppLoaded';
}

class SelectAuthenticationType extends AuthenticationEvent {

  final AuthenticationType type;

  SelectAuthenticationType({this.type});

  SelectAuthenticationType copyWith({AuthenticationType type, int signature}) {
    return SelectAuthenticationType(
      type: type ?? this.type,
    );
  }

  @override
  List<Object> get props => [type];
}

class LoggedOut extends AuthenticationEvent {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'LoggedOut';
}

class LoggedIn extends AuthenticationEvent {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'LoggedIn';
}