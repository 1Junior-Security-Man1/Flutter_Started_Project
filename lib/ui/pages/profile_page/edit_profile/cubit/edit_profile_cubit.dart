import 'package:bloc/bloc.dart';
import 'package:bounty_hub_client/data/models/entity/user/user.dart';
import 'package:bounty_hub_client/data/repositories/profile_local_repository.dart';
import 'package:bounty_hub_client/data/repositories/profile_repository.dart';
import 'package:bounty_hub_client/network/server_api.dart';

part 'edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  EditProfileCubit(User user) : super(EditProfileState(user));

  Future<bool> updateUser()async {
    await ProfileRepository(RestClient()).putUser(state.user);
    await ProfileLocalRepository().putUser(state.user);
    return true;
  }
}
