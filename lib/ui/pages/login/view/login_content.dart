import 'package:bounty_hub_client/ui/pages/login/login_cubit.dart';
import 'package:bounty_hub_client/ui/pages/login/login_state.dart';
import 'package:bounty_hub_client/ui/pages/main/view/main_page.dart';
import 'package:bounty_hub_client/ui/widgets/app_alert.dart';
import 'package:bounty_hub_client/ui/widgets/app_button.dart';
import 'package:bounty_hub_client/ui/widgets/app_check_box.dart';
import 'package:bounty_hub_client/ui/widgets/app_progress_bar.dart';
import 'package:bounty_hub_client/ui/widgets/app_text_field.dart';
import 'package:bounty_hub_client/utils/localization/localization.res.dart';
import 'package:bounty_hub_client/utils/ui/colors.dart';
import 'package:bounty_hub_client/utils/ui/dimens.dart';
import 'package:bounty_hub_client/utils/ui/styles.dart';
import 'package:bounty_hub_client/utils/validation/captcha.dart';
import 'package:bounty_hub_client/utils/validation/form_validation.dart';
import 'package:bounty_hub_client/utils/validation/upper_case_text_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.status == LoginStatus.complete) {
          navigateToApp(state);
          return;
        }

        if (state.status == LoginStatus.emailError ||
            state.status == LoginStatus.confirmCodeError) {
          showDialog(
            context: context,
            builder: (_) => AnimatedAlertBuilder(
                message: state.errorMessage != null
                    ? state.errorMessage
                    : AppStrings.defaultErrorMessage),
          );
        }
      },
      child: BlocBuilder<LoginCubit, LoginState>(
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
                      Header(state: state),
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

  _buildContent(BuildContext context, LoginState state) {
    if (state.status == LoginStatus.loading) {
      return Loading();
    } else if (state.status == LoginStatus.captcha) {
      return CaptchaInput();
    } else {
      return Login(state);
    }
  }

  navigateToApp(LoginState state) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => MainPage(),
      ),
      (route) => false,
    );
  }
}

class Header extends StatelessWidget {
  final LoginState state;

  const Header({Key key, this.state}) : super(key: key);

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
            context.bloc<LoginCubit>().onBackButtonClick();
          },
          child: Opacity(
            opacity: state.status == LoginStatus.captcha ||
                    state.status == LoginStatus.confirmCode ||
                    state.status == LoginStatus.confirmCodeError
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

class CaptchaInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
          child: Text(
            AppStrings.completeCaptcha,
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: Colors.white,
                height: 1.3),
            textAlign: TextAlign.center,
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 80),
          height: 800,
          child: Captcha((String captchaCode) {
            context.bloc<LoginCubit>().authenticate(captchaCode);
          }),
        ),
      ],
    );
  }
}

class Login extends StatefulWidget {
  final LoginState state;

  Login(this.state);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final _emailTextController = TextEditingController();
  final _confirmCodeTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.state.status == LoginStatus.confirmCode ||
        widget.state.status == LoginStatus.confirmCodeError) {
      _emailTextController.text = widget.state.email;
      _confirmCodeTextController.text = widget.state.confirmCode;
    }

    _emailTextController.addListener(() {
      context.bloc<LoginCubit>().emailIsValid(
          FormValidation.email(context, _emailTextController.text) == null);
    });
  }

  @override
  void dispose() {
    _emailTextController.dispose();
    _confirmCodeTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          left: Dimens.content_padding, right: Dimens.content_padding),
      child: Column(
        children: <Widget>[
          Padding(
            padding:
                const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
            child: Text(
              widget.state.status == LoginStatus.email ||
                      widget.state.status == LoginStatus.emailError
                  ? AppStrings.sendAuthorizationCode
                  : AppStrings.checkToConfirmAuthorization,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: Colors.white,
                  height: 1.3),
              textAlign: TextAlign.center,
            ),
          ),
          Form(
            key: _formKey,
            child: Column(
              children: [
                AppTextField(
                  controller: _emailTextController,
                  textInputType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  validator: (value) => FormValidation.email(context, value),
                  decoration: WidgetsDecoration.appTextFormStyle(
                    AppStrings.email,
                      'assets/images/email.png',
                      widget.state.email != null
                          ? 'assets/images/input_completed.png'
                          : null,
                      widget.state.status == LoginStatus.email ||
                          widget.state.status == LoginStatus.emailError),
                ),
                SizedBox(
                  height: Dimens.content_padding,
                ),
                AppTextField(
                  controller: _confirmCodeTextController,
                  inputFormatters: [UpperCaseTextFormatter()],
                  textInputType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  validator: (value) =>
                      FormValidation.confirmCode(context, value, widget.state),
                  decoration: WidgetsDecoration.appTextFormStyle(
                    AppStrings.confirmationCode,
                      'assets/images/confirm_code_key.png',
                      null,
                      widget.state.status == LoginStatus.confirmCode ||
                          widget.state.status == LoginStatus.confirmCodeError),
                ),
                SizedBox(
                  height: 26.0,
                ),
                Row(
                  children: [
                    AppCheckBox(
                      width: 36,
                      height: 36,
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Flexible(
                      child: Text(
                        AppStrings.emailUsedNextTime,
                        style: TextStyle(
                          color: AppColors.textColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 8.0, right: 8.0, top: 26.0, bottom: 8.0),
            child: Padding(
              padding: const EdgeInsets.only(left: 42.0, right: 42.0),
              child: AppButton(
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    if (widget.state.status == LoginStatus.email ||
                        widget.state.status == LoginStatus.emailError) {
                      context
                          .bloc<LoginCubit>()
                          .onEmailSubmitted(_emailTextController.value.text);
                    } else {
                      context
                          .bloc<LoginCubit>()
                          .confirmCode(_confirmCodeTextController.value.text);
                    }
                  }
                },
                textColor: AppColors.buttonDefaultTextColorSecondary,
                enable: widget.state.emailIsValid,
                decoration: WidgetsDecoration.appButtonStyle(),
                text:
                    widget.state.status == LoginStatus.email ||
                            widget.state.status == LoginStatus.emailError
                        ? AppStrings.getAuthorizationCode
                        : AppStrings.confirm,
                height: Dimens.app_button_height,
              ),
            ),
          )
        ],
      ),
    );
  }
}