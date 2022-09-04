import 'package:equatable/equatable.dart';

enum TemplateStatus{ loading }

class TemplateState extends Equatable {
  final TemplateStatus status;

  const TemplateState({
    this.status = TemplateStatus.loading,
  });

  TemplateState copyWith({
    TemplateStatus? status,
  }) {
    return TemplateState(
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [status];
}