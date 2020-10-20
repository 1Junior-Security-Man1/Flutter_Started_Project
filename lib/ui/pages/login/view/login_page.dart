
import 'package:bounty_hub_client/bloc/authentication_event.dart';
import 'package:bounty_hub_client/bloc/authorization_bloc.dart';
import 'package:bounty_hub_client/bloc/authorization_state.dart';
import 'package:bounty_hub_client/data/repositories/user_repository.dart';
import 'package:bounty_hub_client/ui/pages/login/login_cubit.dart';
import 'package:bounty_hub_client/ui/pages/login/login_state.dart';
import 'package:bounty_hub_client/utils/edit_text_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_entry_text_field/pin_entry_text_field.dart';

class LoginPage extends StatelessWidget {
  final UserRepository userRepository;

  LoginPage({Key key, @required this.userRepository})
      : assert(userRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginCubit>(
      create: (context) => LoginCubit(userRepository: userRepository),
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
            body: Container(
              child: SingleChildScrollView(
                child: Row(
                  children: <Widget>[
                    Container(
                      child: Container(
                        color: Theme.of(context).primaryColor,
                        child: Column(
                          children: <Widget>[
                            Header(),
                            getContent(state),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
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
    } else {
      return EmailInput();
    }
  }
}

class Header extends StatelessWidget {
  const Header({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(padding: const EdgeInsets.all(8.0),
              child: Image(image: AssetImage('icons/logo.png'),
                width: 120,
                height: 120,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 40.0, bottom: 8.0),
              child: Text(
                "BountyHub is the place for implementing your business ideas",
                style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16, color: Colors.white),
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
      const EdgeInsets.only(top: 48, bottom: 16.0, left: 16.0, right: 16.0),
      child: Column(
        children: <Widget>[
          Form(
            key: _formKey,
            child: Container(
              width: 200,
              child: EditTextUtils().getCustomEditTextArea(
                  labelValue: "E-mail",
                  hintValue: "E-mail",
                  controller: _emailTextController,
                  keyboardType: TextInputType.number,
                  icon: Icons.email,
                  validator: (value) {
                    return validateEmail(value);
                  }),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RaisedButton(
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  context.bloc<LoginCubit>().authorize(_emailTextController.value.text);
                }
              },
              color: Theme.of(context).primaryColor,
              child: Text(
                "Submit",
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }

  String validateEmail(String value) {
    if (!value.contains('@'))
      return 'Invalid email';
    else
      return null;
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