import 'package:bloc/bloc.dart';
import 'file:///D:/Code/Code/Flutter/BountyHub/bounty_hub_client/lib/ui/pages/splash/cubit/splash_state.dart';
import 'package:logger/logger.dart';

class SplashCubit extends Cubit<SplashState> {

  var logger = Logger();

  SplashCubit() : super(InitialState());
}