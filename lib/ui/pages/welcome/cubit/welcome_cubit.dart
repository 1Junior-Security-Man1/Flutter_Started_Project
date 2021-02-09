import 'package:bloc/bloc.dart';
import 'package:bounty_hub_client/data/repositories/auth_repository.dart';
import 'package:bounty_hub_client/data/repositories/user_repository.dart';
import 'package:bounty_hub_client/ui/pages/welcome/cubit/welcome_state.dart';

class WelcomeCubit extends Cubit<WelcomeState> {

  final AuthRepository _loginRepository;

  final UserRepository _userRepository;

  WelcomeCubit(this._loginRepository, this._userRepository) : super(WelcomeState());
}