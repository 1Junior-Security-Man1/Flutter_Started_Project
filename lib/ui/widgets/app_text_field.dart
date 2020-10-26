import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTextField extends StatefulWidget {

  final TextEditingController controller;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final FormFieldValidator<String> validator;
  final InputDecoration decoration;
  final List<TextInputFormatter> inputFormatters;

  const AppTextField(
      {Key key,
        this.controller,
        this.textInputType,
        this.textInputAction,
        this.validator,
        this.decoration,
        this.inputFormatters,
      })
      : super(key: key);

  @override
  _AppTextFieldState createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 1),
            ),
          ]
      ),
      child: TextFormField(
        inputFormatters: widget.inputFormatters,
        controller: widget.controller,
        keyboardType: widget.textInputType,
        textInputAction: widget.textInputAction,
        validator: widget.validator,
        decoration: widget.decoration,
      ),
    );
  }
}