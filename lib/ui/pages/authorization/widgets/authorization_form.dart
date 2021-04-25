import 'package:flutter_starter/ui/pages/authorization/cubit/authorization_cubit.dart';
import 'package:flutter_starter/ui/pages/authorization/cubit/authorization_state.dart';
import 'package:flutter_starter/ui/widgets/app_button.dart';
import 'package:flutter_starter/ui/widgets/app_text_field.dart';
import 'package:flutter_starter/utils/localization/localization.res.dart';
import 'package:flutter_starter/utils/ui/colors.dart';
import 'package:flutter_starter/utils/ui/dimens.dart';
import 'package:flutter_starter/utils/ui/styles.dart';
import 'package:flutter_starter/utils/validation/form_validation.dart';
import 'package:flutter_starter/utils/validation/upper_case_text_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthorizationFormWidget extends StatefulWidget {
  final AuthorizationState state;

  AuthorizationFormWidget(this.state);

  @override
  _AuthorizationFormWidgetState createState() =>
      _AuthorizationFormWidgetState();
}

class _AuthorizationFormWidgetState extends State<AuthorizationFormWidget> {
  final _formKey = GlobalKey<FormState>();
  final _emailTextController = TextEditingController();
  final _confirmCodeTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _emailTextController.text = widget.state.email;
    _confirmCodeTextController.text = widget.state.confirmCode;

    context
        .bloc<AuthorizationCubit>()
        .emailIsValid(FormValidation.email(_emailTextController.text) == null);

    _emailTextController.addListener(() {
      context.bloc<AuthorizationCubit>().emailIsValid(
          FormValidation.email(_emailTextController.text) == null);
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
            padding: const EdgeInsets.only(
                top: 8.0,
                left: 16.0,
                right: 16.0,
                bottom: Dimens.content_padding),
            child: Text(
              AppStrings.sendAuthorizationCode,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                  color: Colors.white,
                  height: 1.5),
              textAlign: TextAlign.center,
            ),
          ),
          Form(
            key: _formKey,
            child: Column(
              children: [
                AppTextField(
                  controller: _emailTextController,
                  textInputType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.done,
                  validator: (value) => FormValidation.email(value),
                  decoration: WidgetsDecoration.appTextFormStyle(
                      AppStrings.email,
                      'assets/images/email.png',
                      widget.state.email != null
                          ? 'assets/images/complete.png'
                          : null,
                      true),
                ),
                SizedBox(
                  height: Dimens.content_internal_padding,
                ),
                AppTextField(
                  controller: _confirmCodeTextController,
                  inputFormatters: [UpperCaseTextFormatter()],
                  textInputType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  decoration: WidgetsDecoration.appTextFormStyle(
                      AppStrings.confirmationCode,
                      'assets/images/confirm_code_key.png',
                      null,
                      true),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 8.0, right: 8.0, top: 32.0, bottom: 8.0),
            child: Padding(
              padding: const EdgeInsets.only(left: 42.0, right: 42.0),
              child: AppButton(
                disableOnlyUI: !widget.state.emailIsValid,
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    context.bloc<AuthorizationCubit>().authenticate(
                        _emailTextController.value.text,
                        _confirmCodeTextController.value.text);
                  }
                },
                textColor: AppColors.white,
                text: AppStrings.confirm,
                height: Dimens.app_button_height,
              ),
            ),
          )
        ],
      ),
    );
  }
}
