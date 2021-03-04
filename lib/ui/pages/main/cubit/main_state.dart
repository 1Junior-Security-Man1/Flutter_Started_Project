import 'package:equatable/equatable.dart';

enum MainStatus{ initial }

class MainState extends Equatable {
  const MainState({
    this.status = MainStatus.initial,
    this.currentNavigationItem = 0,
  });

  final MainStatus status;
  final int currentNavigationItem;

  MainState copyWith({
    MainState status,
    int currentNavigationItem,
  }) {
    return MainState(
      status: status ?? this.status,
      currentNavigationItem: currentNavigationItem ?? this.currentNavigationItem,
    );
  }

  @override
  List<Object> get props => [currentNavigationItem, status];
}