import 'package:bloc/bloc.dart';
import 'package:bounty_hub_client/data/repositories/auth_repository.dart';
import 'package:bounty_hub_client/data/repositories/user_repository.dart';
import 'package:bounty_hub_client/ui/pages/template/cubit/template_state.dart';

class TemplateCubit extends Cubit<TemplateState> {

  final AuthRepository _loginRepository;

  final UserRepository _userRepository;

  TemplateCubit(this._loginRepository, this._userRepository) : super(TemplateState());
}