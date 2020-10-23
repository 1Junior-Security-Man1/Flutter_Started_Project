import 'package:bounty_hub_client/ui/pages/dashboard/dashboard.dart';
import 'package:bounty_hub_client/ui/pages/login/login_cubit.dart';
import 'package:bounty_hub_client/ui/pages/login/login_state.dart';
import 'package:bounty_hub_client/ui/widgets/entry_code_text_field.dart';
import 'package:bounty_hub_client/utils/localization/app_localizations.dart';
import 'package:bounty_hub_client/utils/ui/colors.dart';
import 'package:bounty_hub_client/utils/ui/styles.dart';
import 'package:bounty_hub_client/utils/validation/captcha.dart';
import 'package:bounty_hub_client/utils/validation/form_validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginForm(),
    );
  }
}

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if(state is LoginCompleteState) {
          navigateToApp(state);
          return;
        }

        if (state is EmailExceptionState || state is ConfirmCodeExceptionState) {
          showSnackBar(state);
        }
      },
      child: BlocBuilder<LoginCubit, LoginState>(
        builder: (context, state) {
          return Scaffold(
              backgroundColor: AppColors.backgroundColor,
              body: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Header(),
                    buildContent(context, state)
                  ]
              ),
            )
          );
        },
      ),
    );
  }

  buildContent(BuildContext context, LoginState state) {
    if (state is InitialState || state is EmailExceptionState) {
      return EmailInput();
    } else if (state is ConfirmCodeInputState || state is ConfirmCodeExceptionState) {
      return ConfirmCodeInput();
    } else if (state is LoadingState) {
      return Loading();
    } else if (state is CaptchaInputState) {
      return CaptchaInput();
    } else if(state is LoginCompleteState) {
      return ConfirmCodeInput();
    } else {
      return EmailInput();
    }
  }

  navigateToApp(LoginCompleteState state) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => DashboardPage(),
      ), (route) => false,
    );
  }

  showSnackBar(LoginState state) {
    String message;
    if (state is EmailExceptionState) {
      message = state.message;
    } else if (state is ConfirmCodeExceptionState) {
      message = state.message;
    }

    Scaffold.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(message, style: TextStyle(color: Colors.white),),
              Icon(Icons.error)
            ],
          ),
          backgroundColor: Colors.red,
        ),
      );
  }
}

class Header extends StatelessWidget {
  const Header({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 42),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(padding: const EdgeInsets.all(80.0),
              child: Image(image: AssetImage('assets/images/logo.png'),
                width: 200,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 36.0, bottom: 8.0),
              child: Text(
                AppLocalizations.of(context).get('sign_in_to'),
                style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16, color: AppColors.textColor),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 4.0, bottom: 8.0),
              child: Text(
                AppLocalizations.of(context).get('app_name'),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
    );
  }
}

class CaptchaInput extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 48.0),
              child: RaisedButton(
                onPressed: () {
                  context.bloc<LoginCubit>().resetState();
                },
                color: Theme.of(context).primaryColor,
                child: Text(
                  AppLocalizations.of(context).get('back'),
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0),
              child: Text(
                AppLocalizations.of(context).get('complete_captcha'),
                style: TextStyle(fontSize: 16, color: AppColors.textColor),
                textAlign: TextAlign.center,),
            ),
            Container(
              height: 800,
              child: Captcha((String captchaCode) {
                context.bloc<LoginCubit>().authenticate(captchaCode);
              }),
            ),
          ],
        ),
    );
  }
}

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Center(
    child: CircularProgressIndicator(),
  );
}

class EmailInput extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _emailTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
      const EdgeInsets.only(top: 16.0, bottom: 16.0, left: 16.0, right: 16.0),
      child: Column(
        children: <Widget>[
          Form(
            key: _formKey,
            child: Center(
              child: Container(
                constraints: BoxConstraints(maxWidth: 300),
                child: TextFormField(
                  controller: _emailTextController,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  validator: (value) => FormValidation.validateEmail(value),
                  decoration: WidgetsStyle.textFieldStyle(AppLocalizations.of(context).get('email'), AppLocalizations.of(context).get('email'), Icons.email),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 20.0, bottom: 8.0),
            child: RaisedButton(
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  context.bloc<LoginCubit>().onEmailSubmitted(_emailTextController.value.text);
                }
              },
              color: Theme.of(context).primaryColor,
              child: Text(
                AppLocalizations.of(context).get('get_authorization_code'),
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ConfirmCodeInput extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      child: Padding(
        padding: const EdgeInsets.only(
            top: 48, bottom: 16.0, left: 16.0, right: 16.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0),
              child: Text(
                AppLocalizations.of(context).get('check_to_confirm_authorization'),
                style: TextStyle(fontSize: 16, color: AppColors.textColor),
                textAlign: TextAlign.center,),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: PinEntryTextField(
                textInputType: TextInputType.text,
                  fields: 5,
                  onSubmit: (String code) {
                    context.bloc<LoginCubit>().onConfirmCodeSubmitted(code);
                  }),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: RaisedButton(
                      onPressed: () {
                        context.bloc<LoginCubit>().resetState();
                        },
                      color: Theme.of(context).primaryColor,
                      child: Text(
                        AppLocalizations.of(context).get('back_to_login'),
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(width: 10,),
                  Expanded(
                    flex: 1,
                    child: RaisedButton(
                      onPressed: () {
                        context.bloc<LoginCubit>().confirmCode();
                        },
                      color: Theme.of(context).primaryColor,
                      child: Text(
                        AppLocalizations.of(context).get('confirm'),
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      constraints: BoxConstraints.tight(Size.fromHeight(250)),
    );
  }
}