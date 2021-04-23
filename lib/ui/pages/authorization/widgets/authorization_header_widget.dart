import 'package:flutter_starter/bloc/auth/authentication_event.dart';
import 'package:flutter_starter/bloc/auth/authorization_bloc.dart';
import 'package:flutter_starter/ui/pages/authorization/cubit/authorization_cubit.dart';
import 'package:flutter_starter/ui/pages/authorization/cubit/authorization_state.dart';
import 'package:flutter_starter/utils/ui/dimens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HeaderWidget extends StatelessWidget {
  final AuthorizationState state;

  const HeaderWidget({Key key, this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.only(top: 36.0),
          height: (MediaQuery.of(context).size.height / 2) - 120,
          child: Center(
            child: Image.asset(
              'assets/images/bountyhub.png',
              width: Dimens.login_logo_width,
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            if(state.status != AuthorizationStatus.email) {
              context.bloc<AuthorizationCubit>().onBack();
            } else {
              BlocProvider.of<AuthenticationBloc>(context).add(SelectAuthenticationType(type: AuthenticationType.uninitialized));
            }
          },
          child: Opacity(
            opacity: state.status == AuthorizationStatus.email
                ? 1.0
                : 0.0,
            child: Container(
              margin: const EdgeInsets.only(left: 35.0, top: 70.0),
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                size: 22.0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}