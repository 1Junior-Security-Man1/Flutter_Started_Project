import 'package:flutter_starter/utils/ui/colors.dart';
import 'package:flutter/material.dart';

enum AppButtonType { WHITE, BLUE, OUTLINE }

class AppButton extends StatefulWidget {
  final double? width;
  final double? height;
  final String? text;
  final Function? onPressed;
  final Color? textColor;
  final bool? enable;
  final AppButtonType? type;
  final bool? withShadow;
  final Widget? child;
  final BorderRadius? borderRadius;

  final bool disableOnlyUI;

  const AppButton({
    Key? key,
    this.width = double.infinity,
    this.height = 40,
    this.onPressed,
    this.text,
    this.textColor,
    this.enable = true,
    this.type = AppButtonType.BLUE,
    this.withShadow = true,
    this.child,
    this.borderRadius,
    this.disableOnlyUI = false,
  })  : assert(
            (child != null && text == null) || (child == null && text != null)),
        super(key: key);

  @override
  _AppButtonState createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  @override
  Widget build(BuildContext context) {
    BoxDecoration decoration = BoxDecoration(
      color: widget.type != AppButtonType.BLUE ? Colors.white : null,
      gradient: widget.type == AppButtonType.BLUE
          ? LinearGradient(
              colors: <Color>[
                AppColors.primaryColor,
                AppColors.buttonBorderColor
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            )
          : null,
      boxShadow: widget.withShadow!
          ? [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 7,
                blurRadius: 7,
                offset: Offset(2, 4),
              )
            ]
          : null,
      border: widget.type == AppButtonType.OUTLINE
          ? Border.all(width: 2, color: AppColors.buttonOutline)
          : Border.all(color: Colors.transparent),
      borderRadius: widget.borderRadius ?? BorderRadius.circular(12),
    );

    return Stack(
      children: [
        Container(
          constraints: const BoxConstraints(minWidth: 50.0, minHeight: 42.0),
          alignment: Alignment.center,
          decoration: decoration,
          width: widget.width,
          height: widget.height,
          child: Stack(
            alignment: Alignment.center,
            children: [
              widget.child != null
                  ? widget.child!
                  : Text(
                      widget.text!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: (widget.enable! && !widget.disableOnlyUI)
                            ? (widget.textColor ??
                                (widget.type == AppButtonType.BLUE
                                    ? Colors.white
                                    : AppColors.buttonOutline))
                            : AppColors.buttonDisabledTextColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  //onTap: widget.enable! ? widget.onPressed : () {},
                  borderRadius:
                      widget.borderRadius ?? BorderRadius.circular(12),
                  splashColor: (widget.enable! || widget.disableOnlyUI)?Colors.transparent:widget.type == AppButtonType.BLUE
                      ? Colors.white24
                      : AppColors.buttonBorderColor.withOpacity(0.2),
                  highlightColor:(widget.enable! || widget.disableOnlyUI)?Colors.transparent: widget.type == AppButtonType.BLUE
                      ? Colors.white24
                      : AppColors.buttonBorderColor.withOpacity(0.2),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
