import 'package:bounty_hub_client/bloc/auth/authentication_event.dart';
import 'package:bounty_hub_client/bloc/auth/authorization_bloc.dart';
import 'package:bounty_hub_client/ui/pages/authorization/cubit/authorization_cubit.dart';
import 'package:bounty_hub_client/ui/pages/authorization/cubit/authorization_state.dart';
import 'package:bounty_hub_client/ui/widgets/app_alert.dart';
import 'package:bounty_hub_client/ui/widgets/app_progress_bar.dart';
import 'package:bounty_hub_client/utils/localization/localization.res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bounty_hub_client/ui/pages/authorization/widgets/authorization_form.dart';
import 'package:bounty_hub_client/ui/pages/authorization/widgets/authorization_header_widget.dart';
import 'package:bounty_hub_client/ui/pages/authorization/widgets/authorization_captcha_widget.dart';

class AuthorizationWidget extends StatefulWidget {
  @override
  _AuthorizationWidgetState createState() => _AuthorizationWidgetState();
}

class _AuthorizationWidgetState extends State<AuthorizationWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthorizationCubit, AuthorizationState>(
      listener: (context, state) {
        if (state.status == AuthorizationStatus.complete) {
          BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());
          return;
        }

        if (state.status == AuthorizationStatus.emailError ||
            state.status == AuthorizationStatus.confirmCodeError) {
          showDialog(
            context: context,
            builder: (_) => AnimatedAlertBuilder(
                message: state.errorMessage != null
                    ? state.errorMessage
                    : AppStrings.defaultErrorMessage),
          );
        }
      },
      child: BlocBuilder<AuthorizationCubit, AuthorizationState>(
        builder: (context, state) {
          return Container(
            child: Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height / 2,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage('assets/images/page_bg.png'),
                    ),
                  ),
                ),
                Container(
                  child: SingleChildScrollView(
                    child: Column(children: <Widget>[
                      HeaderWidget(state: state),
                      Container(
                        child: _buildContent(context, state),
                      )
                    ]),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  _buildContent(BuildContext context, AuthorizationState state) {
    if (state.status == AuthorizationStatus.loading) {
      return Loading();
    } else if (state.status == AuthorizationStatus.captcha) {
      return CaptchaWidget();
    } else {
      return AuthorizationFormWidget(state);
    }
  }
}
