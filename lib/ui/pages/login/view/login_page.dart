
import 'package:bounty_hub_client/bloc/authentication_event.dart';
import 'package:bounty_hub_client/bloc/authorization_bloc.dart';
import 'package:bounty_hub_client/data/repositories/authentication_repository.dart';
import 'package:bounty_hub_client/data/repositories/user_repository.dart';
import 'package:bounty_hub_client/ui/pages/login/login_cubit.dart';
import 'package:bounty_hub_client/ui/pages/login/login_state.dart';
import 'package:bounty_hub_client/utils/ui/colors.dart';
import 'package:bounty_hub_client/utils/ui/styles.dart';
import 'package:bounty_hub_client/utils/validation/captcha.dart';
import 'package:bounty_hub_client/utils/validation/form_validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_entry_text_field/pin_entry_text_field.dart';

class LoginPage extends StatelessWidget {
  final UserRepository userRepository;
  final LoginRepository loginRepository;

  LoginPage({Key key, @required this.userRepository, @required this.loginRepository})
      : assert(userRepository != null), assert(loginRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginCubit>(
      create: (context) => LoginCubit(userRepository: userRepository, loginRepository: loginRepository),
      child: Scaffold(
        body: LoginForm(),
      ),
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
      listener: (context, loginState) {
        String message;
        if (loginState is ExceptionState) {
          message = loginState.message;
        }
        Scaffold.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text(message), Icon(Icons.error)],
              ),
              backgroundColor: Colors.red,
            ),
          );
      },
      child: BlocBuilder<LoginCubit, LoginState>(
        builder: (context, state) {
          return Scaffold(
              backgroundColor: AppColors.backgroundColor,
              body: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Header(),
                    getContent(state)
                  ]
              ),
            )
          );
        },
      ),
    );
  }

  getContent(LoginState state) {
    if (state is InitialState) {
      return EmailInput();
    } else if (state is ConfirmCodeState) {
      return ConfirmationCodeInput();
    } else if (state is LoadingState) {
      return LoadingIndicator();
    } else if (state is LoginCompleteState) {
      BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());
    } else if (state is CaptchaSentState) {
      return CaptchaInput();
    } else {
      return EmailInput();
    }
  }
}

class CaptchaInput extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 1000,
        child: Captcha((String secret) {
          context.bloc<LoginCubit>().captchaSecret(secret);
        }),
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
              child: Image(image: AssetImage('assets/icons/logo.png'),
                width: 200,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 36.0, bottom: 8.0),
              child: Text(
                "Sign in to",
                style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16, color: AppColors.textColor),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 4.0, bottom: 8.0),
              child: Text(
                "Bountyhub Platform",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
    );
  }
}

class LoadingIndicator extends StatelessWidget {
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
                  textInputAction: TextInputAction.next,
                  validator: (value) => FormValidation.validateEmail(value),
                  decoration: WidgetsStyle.textFieldStyle('E-Mail', 'E-Mail', Icons.email),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 20.0, bottom: 8.0),
            child: RaisedButton(
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  context.bloc<LoginCubit>().authorize(_emailTextController.value.text);
                }
              },
              color: Theme.of(context).primaryColor,
              child: Text(
                "GET AUTHORIZATION CODE",
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ConfirmationCodeInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      child: Padding(
        padding: const EdgeInsets.only(
            top: 48, bottom: 16.0, left: 16.0, right: 16.0),
        child: Column(
          children: <Widget>[
            PinEntryTextField(
                fields: 6,
                onSubmit: (String code) {
                  context.bloc<LoginCubit>().confirmCode(code);
                }),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                onPressed: () {
                  context.bloc<LoginCubit>().appStart();
                },
                color: Colors.orange,
                child: Text(
                  "Back",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
      constraints: BoxConstraints.tight(Size.fromHeight(250)),
    );
  }
}