import 'package:bounty_hub_client/utils/ui/colors.dart';
import 'package:flutter/material.dart';

class AppButton extends StatefulWidget {

  final double width;
  final double height;
  final String text;
  final Function onPressed;
  final BoxDecoration decoration;

  const AppButton(
      {Key key,
        this.width = double.infinity,
        this.height,
        this.onPressed,
        this.decoration,
        this.text,
      })
      : super(key: key);

  @override
  _AppButtonState createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      child: RaisedButton(
        onPressed: widget.onPressed,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        padding: const EdgeInsets.all(0.0),
        child: Ink(
          decoration: widget.decoration,
          child: Container(
            constraints: const BoxConstraints(minWidth: 88.0, minHeight: 36.0), // min sizes for Material buttons
            alignment: Alignment.center,
            child: Text(
              widget.text,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: AppColors.buttonTextColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}