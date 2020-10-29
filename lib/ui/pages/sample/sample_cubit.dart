import 'package:bloc/bloc.dart';
import 'package:bounty_hub_client/data/repositories/user_repository.dart';
import 'package:bounty_hub_client/ui/pages/sample/sample_state.dart';
import 'package:logger/logger.dart';

class SampleCubit extends Cubit<SampleState> {

  final log = Logger();

  final UserRepository _userRepository;

  SampleCubit(this._userRepository) : super(SampleState());


}