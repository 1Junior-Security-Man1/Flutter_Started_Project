import 'package:equatable/equatable.dart';

enum CampaignsStatus{ initial }

class CampaignsState extends Equatable {
  const CampaignsState({
    this.status = CampaignsStatus.initial,
  });

  final CampaignsStatus status;

  CampaignsState copyWith({
    CampaignsState status,
  }) {
    return CampaignsState(
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [status];
}