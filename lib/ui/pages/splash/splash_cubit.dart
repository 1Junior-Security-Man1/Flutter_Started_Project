import 'package:bloc/bloc.dart';
import 'package:bounty_hub_client/ui/pages/splash/splash_state.dart';
import 'package:logger/logger.dart';

class SplashCubit extends Cubit<SplashState> {

  var logger = Logger();

  SplashCubit() : super(InitialState());
}