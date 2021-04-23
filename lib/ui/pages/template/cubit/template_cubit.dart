import 'package:bloc/bloc.dart';
import 'package:flutter_starter/data/repositories/auth_repository.dart';
import 'package:flutter_starter/data/repositories/user_repository.dart';
import 'package:flutter_starter/ui/pages/template/cubit/template_state.dart';

class TemplateCubit extends Cubit<TemplateState> {

  final AuthRepository _loginRepository;

  final UserRepository _userRepository;

  TemplateCubit(this._loginRepository, this._userRepository) : super(TemplateState());
}