import 'package:bloc/bloc.dart';
import 'package:flutter_starter/ui/pages/splash/cubit/splash_state.dart';
import 'package:logger/logger.dart';

class SplashCubit extends Cubit<SplashState> {

  var logger = Logger();

  SplashCubit() : super(InitialState());
}