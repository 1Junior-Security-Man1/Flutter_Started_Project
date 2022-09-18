import 'package:flutter_starter/ui/pages/authorization/cubit/authorization_cubit.dart';
import 'package:flutter_starter/ui/pages/authorization/cubit/authorization_state.dart';
import 'package:flutter_starter/ui/widgets/app_button.dart';
import 'package:flutter_starter/ui/widgets/app_text_field.dart';
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
  _AuthorizationFormWidgetState createState() => _AuthorizationFormWidgetState();
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
            child: Text('Authorization Page'),
          ),
          Form(
            key: _formKey,
            child: Column(
              children: [
                AppTextField(
                  controller: _emailTextController,
                  textInputType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.done,
                  // validator: (value) => FormValidation.email(value!) ? null : "You didn't put @",
                  validator: (value) => FormValidation.email1(value!),
                  decoration: Styles.appTextFormStyle(
                      hint: 'Email',
                      prefixIcon: Icons.email,
                      enabled: true),
                ),
                SizedBox(
                  height: Dimens.content_internal_padding,
                ),
                AppTextField(
                  controller: _confirmCodeTextController,
                  inputFormatters: [UpperCaseTextFormatter()],
                  textInputType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  decoration: Styles.appTextFormStyle(
                      hint: 'Password',
                      prefixIcon: Icons.lock,
                      enabled: true),
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
                disableOnlyUI: widget.state.emailIsValid,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    BlocProvider.of<AuthorizationCubit>(context).authenticate(
                        _emailTextController.value.text,
                        _confirmCodeTextController.value.text);
                  }
                },
                textColor: AppColors.backgroundColor,
                text: 'AppStrings.confirm',
                height: Dimens.app_button_height,
              ),
            ),
          )
        ],
      ),
    );
  }
}