import 'package:equatable/equatable.dart';

enum TemplateStatus{ loading }

class TemplateState extends Equatable {
  const TemplateState({
    this.status = TemplateStatus.loading,
  });

  final TemplateStatus status;

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