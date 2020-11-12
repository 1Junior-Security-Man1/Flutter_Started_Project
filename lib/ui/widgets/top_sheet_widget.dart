import 'package:bounty_hub_client/utils/ui/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TopSheet extends StatefulWidget {
  final Widget child;

  final double height;

  const TopSheet(this.child, {this.height = 300});

  @override
  TopSheetState createState() => TopSheetState();
}

class TopSheetState extends State<TopSheet>
    with SingleTickerProviderStateMixin {
  static AnimationController controller;
  Animation<Offset> _slideAnimation;
  Animation<double> _fadeAnimation;

  double _dragStartPosition = 0;
  double _dragEndPosition = 0;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.0, -1.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: controller,
      curve: Curves.linear,
    ));

    _fadeAnimation = CurvedAnimation(parent: controller, curve: Curves.linear);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  static void close(context)async{
    await controller.reverse();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return _buildSwipeDetector(
      onTapEnable: true,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Container(
          color: AppColors.filterBarrierAnimation,
          child: Align(
            alignment: Alignment.topCenter,
            child: Material(
              color: Colors.transparent,
              child: SlideTransition(
                position: _slideAnimation,
                child: _buildSwipeDetector(
                  child: Container(
                    height: widget.height,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(61),
                            bottomLeft: Radius.circular(61))),
                    child: Container(
                      child: widget.child,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _buildSwipeDetector({Widget child, bool onTapEnable = false}) {
    return GestureDetector(
      child: child,
      onTap: onTapEnable
          ? () async {
              await controller.reverse();
              Navigator.pop(context);
            }
          : () {},
      onVerticalDragStart: (detail) {
        _dragStartPosition = detail.globalPosition.dy;
      },
      onVerticalDragEnd: (detail) async {
        print(detail.primaryVelocity);
        if (_dragEndPosition <= 0.5 || detail.primaryVelocity < -1000) {
          await controller.reverse();
          Navigator.pop(context);
        } else {
          controller.animateTo(1);
        }
        _dragStartPosition = 0;
        _dragEndPosition = 0;
      },
      onVerticalDragCancel: () {
        controller.animateTo(1);
      },
      onVerticalDragUpdate: (detail) {
        _dragEndPosition = 1 -
            ((_dragStartPosition - detail.globalPosition.dy) / widget.height);
        setState(() {
          controller.animateTo(1 -
              ((_dragStartPosition - detail.globalPosition.dy) /
                  widget.height));
        });
      },
    );
  }
}
