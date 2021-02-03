import 'package:equatable/equatable.dart';

enum WelcomeStatus{ loading }

class WelcomeState extends Equatable {
  const WelcomeState({
    this.status = WelcomeStatus.loading,
  });

  final WelcomeStatus status;

  WelcomeState copyWith({
    WelcomeStatus status,
  }) {
    return WelcomeState(
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [status];
}