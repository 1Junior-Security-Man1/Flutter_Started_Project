part of 'profile_cubit.dart';

class ProfileState extends Equatable {
  const ProfileState( {this.user,this.selectedSocial,});

  final User user;
  final SocialNetworkType selectedSocial;

  ProfileState copyWith({User user,SocialNetworkType selectedSocial}) {
    return ProfileState(
      user: user ?? this.user,
      selectedSocial: selectedSocial ?? this.selectedSocial,
    );
  }

  @override
  List<Object> get props => [this.user,this.selectedSocial];
}
