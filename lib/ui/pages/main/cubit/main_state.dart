import 'package:equatable/equatable.dart';

enum MainStatus{ initial }

class MainState extends Equatable {
  const MainState({
    this.status = MainStatus.initial,
  });

  final MainStatus status;

  MainState copyWith({
    MainState status,
  }) {
    return MainState(
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [status];
}