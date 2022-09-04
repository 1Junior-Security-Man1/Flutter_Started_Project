import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTextField extends StatefulWidget {

  final TextEditingController? controller;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final FormFieldValidator<String>? validator;
  final InputDecoration? decoration;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLines;
  final bool? withShadow;

  const AppTextField(
      {Key? key,
        this.maxLines = 1,
        this.controller,
        this.textInputType,
        this.textInputAction,
        this.validator,
        this.decoration,
        this.inputFormatters,
        this.withShadow = true,
      })
      : super(key: key);

  @override
  _AppTextFieldState createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: widget.withShadow! ? BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 1),
            ),
          ]
      ) : null,
      child: TextFormField(
        maxLines: widget.maxLines,
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