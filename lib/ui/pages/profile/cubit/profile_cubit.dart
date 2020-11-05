import 'package:bloc/bloc.dart';
import 'package:bounty_hub_client/data/enums/social_networks_types.dart';
import 'package:bounty_hub_client/data/models/entity/user/user.dart';
import 'package:bounty_hub_client/data/repositories/profile_local_repository.dart';
import 'package:bounty_hub_client/data/repositories/profile_repository.dart';
import 'package:equatable/equatable.dart';

import 'package:logger/logger.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this._profileRepository, this._profileLocalRepository)
      : super(ProfileState());

  final ProfileRepository _profileRepository;
  final ProfileLocalRepository _profileLocalRepository;

  final log = Logger();

  void loadUserProfile() async {
    var localUser = await _profileLocalRepository.getUser();
    if (localUser != null) {
      emit(state.copyWith(user: localUser));
    }

    var apiUser = await _profileRepository.getUser();
    if (apiUser != null) {
      emit(state.copyWith(user: apiUser));
      _profileLocalRepository.putUser(apiUser);
    }
  }

  void selectSocial(SocialNetworkType socialNetworkType) {
    emit(state.copyWith(selectedSocial: socialNetworkType));
  }

}
