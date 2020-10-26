import 'package:flutter/material.dart';

class AppCheckBox extends StatefulWidget {

  final double width;
  final double height;

  const AppCheckBox({Key key,
    this.width,
    this.height}) : super(key: key);

  @override
  _AppCheckBoxState createState() => _AppCheckBoxState();
}

class _AppCheckBoxState extends State<AppCheckBox> {
  bool _isChecked = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => setState(() {
          _isChecked = !_isChecked;
        }),
        child: Container(
          height: widget.height,
          width: widget.width,
          child: Image.asset(_isChecked? 'assets/images/check_box_selected.png': 'assets/images/check_box_normal.png'),
        ),
      );
  }
}