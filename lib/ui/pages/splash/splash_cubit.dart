import 'package:bloc/bloc.dart';
import 'package:bounty_hub_client/data/repositories/user_repository.dart';
import 'package:bounty_hub_client/ui/pages/splash/splash_state.dart';
import 'package:logger/logger.dart';

class SplashCubit extends Cubit<SplashState> {

  final UserRepository _userRepository;

  var logger = Logger();

  SplashCubit(this._userRepository) : super(InitialState());
}