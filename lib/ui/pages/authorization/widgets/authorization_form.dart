import 'package:bounty_hub_client/ui/pages/authorization/cubit/authorization_cubit.dart';
import 'package:bounty_hub_client/ui/pages/authorization/cubit/authorization_state.dart';
import 'package:bounty_hub_client/ui/widgets/app_button.dart';
import 'package:bounty_hub_client/ui/widgets/app_text_field.dart';
import 'package:bounty_hub_client/utils/localization/localization.res.dart';
import 'package:bounty_hub_client/utils/ui/colors.dart';
import 'package:bounty_hub_client/utils/ui/dimens.dart';
import 'package:bounty_hub_client/utils/ui/styles.dart';
import 'package:bounty_hub_client/utils/validation/form_validation.dart';
import 'package:bounty_hub_client/utils/validation/upper_case_text_formatter.dart';
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

    context.bloc<AuthorizationCubit>().emailIsValid(FormValidation.email(context, _emailTextController.text) == null);

    _emailTextController.addListener(() {
      context.bloc<AuthorizationCubit>().emailIsValid(
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
            const EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0, bottom: Dimens.content_padding),
            child: Text(
              widget.state.status == AuthorizationStatus.email ||
                  widget.state.status == AuthorizationStatus.emailError
                  ? AppStrings.sendAuthorizationCode
                  : AppStrings.checkToConfirmAuthorization,
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
                Visibility(
                  visible: widget.state.status == AuthorizationStatus.email || widget.state.status == AuthorizationStatus.emailError,
                  child: AppTextField(
                    controller: _emailTextController,
                    textInputType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.done,
                    validator: (value) => FormValidation.email(context, value),
                    decoration: WidgetsDecoration.appTextFormStyle(
                        AppStrings.email,
                        'assets/images/email.png',
                        widget.state.email != null
                            ? 'assets/images/complete.png'
                            : null,
                        true),
                  ),
                ),
                SizedBox(
                  height: Dimens.content_internal_padding,
                ),
                Visibility(
                  visible: widget.state.status == AuthorizationStatus.confirmCode || widget.state.status == AuthorizationStatus.confirmCodeError,
                  child: AppTextField(
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
                        true),
                  ),
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
                disableOnlyUI: widget.state.status == AuthorizationStatus.email && !widget.state.emailIsValid,
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    if (widget.state.status == AuthorizationStatus.email ||
                        widget.state.status == AuthorizationStatus.emailError) {
                      context
                          .bloc<AuthorizationCubit>()
                          .onEmailSubmitted(_emailTextController.value.text);
                    } else {
                      context
                          .bloc<AuthorizationCubit>()
                          .confirmCode(_confirmCodeTextController.value.text);
                    }
                  }
                },
                textColor: AppColors.white,

                text: widget.state.status == AuthorizationStatus.email ||
                    widget.state.status == AuthorizationStatus.emailError
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