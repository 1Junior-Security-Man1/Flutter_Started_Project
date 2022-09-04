import 'package:equatable/equatable.dart';

enum MainStatus{ initial }

class MainState extends Equatable {
  final MainStatus status;
  final int currentNavigationItem;

  const MainState({
    this.status = MainStatus.initial,
    this.currentNavigationItem = 0,
  });

  MainState copyWith({
    MainStatus? status,
    int? currentNavigationItem,
  }) {
    return MainState(
      status: status ?? this.status,
      currentNavigationItem: currentNavigationItem ?? this.currentNavigationItem,
    );
  }

  @override
  List<Object> get props => [currentNavigationItem, status];
}