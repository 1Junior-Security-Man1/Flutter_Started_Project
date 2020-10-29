import 'package:equatable/equatable.dart';

enum SampleStatus{ loading, success, failure }

class SampleState extends Equatable {

  const SampleState({
    this.status = SampleStatus.loading,
  });

  final SampleStatus status;

  SampleState copyWith({
    SampleStatus status,
  }) {
    return SampleState(
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [status];
}