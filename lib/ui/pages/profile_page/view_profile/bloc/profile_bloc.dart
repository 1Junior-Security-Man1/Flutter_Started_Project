import 'package:bloc/bloc.dart';
import 'package:bounty_hub_client/data/models/entity/user/user.dart';
import 'package:bounty_hub_client/data/repositories/profile_local_repository.dart';
import 'package:bounty_hub_client/data/repositories/profile_repository.dart';
import 'package:bounty_hub_client/ui/pages/profile_page/view_profile/bloc/profile_event.dart';
import 'package:bounty_hub_client/ui/pages/profile_page/view_profile/bloc/profile_state.dart';
import 'package:logger/logger.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc(this._profileRepository, this._profileLocalRepository)
      : super(ProfileState());

  final ProfileRepository _profileRepository;
  final ProfileLocalRepository _profileLocalRepository;

  final log = Logger();

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    if (event is FetchProfileEvent) {
      loadUserProfile();
    }

    if (event is UserProfileReceivedEvent) {
      yield ProfileState(
          user: event.user, selectedSocial: state.selectedSocial);
    }

    if (event is SocialsReceivedEvent) {
      yield state.copyWith(socials: event.socials);
    }

    if (event is SelectSocialProfileEvent) {
      yield state.copyWith(selectedSocial: event.socialNetworkType);
    }

    if (event is OnNextBtnPresEvent) {
      var newMap = Map.of(state.nextBtnWasPressed);
      newMap[event.socialNetworkType] = true;
      yield state.copyWith(nextBtnWasPressed: newMap);
    }

    if (event is AddSocialProfileEvent) {
      await _profileRepository.setSocial(
          event.socialNetworkType, event.profileUrl);
      var socials = await _profileRepository.getMySocialAccounts();
      add(SocialsReceivedEvent(socials));
    }

    if (event is RemoveSocialProfileEvent) {
      await _profileRepository.removeSocial(event.id);

      var socials = await _profileRepository.getMySocialAccounts();
      add(SocialsReceivedEvent(socials));
    }

    if (event is UpdateTronWalletEvent) {
      var newUser = User.fromJson(state.user.toJson());
      newUser.tronWallet = event.wallet;
      try {
        await _profileRepository.putUser(newUser);
        yield state.copyWith(user: newUser);
      } catch (e) {
        print(e);
        //TBz7AzxhpHhpYv8xwUnkipSovVDGiUf7d9
      }
    }

    if(event is ErrorWasShown){
      yield state.copyWith(errorText: '',errorType: null);
    }
  }

  void loadUserProfile() async {
    var localUser = await _profileLocalRepository.getUser();
    if (localUser != null) {
      add(UserProfileReceivedEvent(localUser));
    }
    var apiUser = await _profileRepository.getUser();
    if (apiUser != null) {
      add(UserProfileReceivedEvent(apiUser));
      _profileLocalRepository.putUser(apiUser);
    }

    var socials = await _profileRepository.getMySocialAccounts();

    add(SocialsReceivedEvent(socials));
  }
}
