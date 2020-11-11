import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

typedef CountdownTimerWidgetBuilder = Widget Function(
    BuildContext context, CurrentRemainingTime time);

class CountdownTimer extends StatefulWidget {
  final int endTime;
  final Widget hoursSymbol;
  final Widget minSymbol;
  final Widget secSymbol;
  final TextStyle textStyle;
  final VoidCallback onEnd;
  final Widget emptyWidget;
  final Widget textBefore;
  final CountdownTimerWidgetBuilder widgetBuilder;

  CountdownTimer({
    Key key,
    this.endTime,
    this.hoursSymbol = const Text(':'),
    this.minSymbol = const Text(':'),
    this.secSymbol = const Text(''),
    this.textStyle = const TextStyle(fontSize: 14, color: Colors.white),
    this.onEnd,
    this.emptyWidget = const Center(
      child: SizedBox(),
    ),
    this.widgetBuilder,
    this.textBefore = const Text(''),
  }) : super(key: key);

  @override
  _CountDownState createState() => _CountDownState();
}

class _CountDownState extends State<CountdownTimer> {
  CurrentRemainingTime currentRemainingTime = CurrentRemainingTime();

  Timer _diffTimer;

  VoidCallback get onEnd => widget.onEnd;

  TextStyle get textStyle => widget.textStyle;

  Widget get emptyWidget => widget.emptyWidget;

  Widget get hoursSymbol => widget.hoursSymbol;

  Widget get minSymbol => widget.minSymbol;

  Widget get secSymbol => widget.secSymbol;

  CountdownTimerWidgetBuilder get widgetBuilder =>
      widget.widgetBuilder ?? builderCountdownTimer;

  @override
  void initState() {
    timerDiffDate();
    super.initState();
  }

  @override
  void didUpdateWidget(CountdownTimer oldWidget) {
    if (oldWidget.endTime != widget.endTime) {
      timerDiffDate();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return widgetBuilder(context, currentRemainingTime);
  }

  Widget builderCountdownTimer(
      BuildContext context, CurrentRemainingTime time) {
    return DefaultTextStyle(
      style: textStyle,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: timeListBuild(time),
      ),
    );
  }

  timeListBuild(CurrentRemainingTime time) {
    List<Widget> list = [];
    if (time == null) {
      list.add(emptyWidget);
      return list;
    }
    list.add(widget.textBefore);

    var hours = _getNumberAddZero(time.hours ?? 0);
    list.add(Text(
      hours,
    ));
    list.add(hoursSymbol);
    var min = _getNumberAddZero(time.min ?? 0);
    list.add(Text(min));
    list.add(minSymbol);
    var sec = _getNumberAddZero(time.sec??0);
    list.add(Text(sec));
    list.add(secSymbol);
    return list;
  }

  String _getNumberAddZero(int number) {
    assert(number != null);
    if (number < 10) {
      return "0" + number.toString();
    }
    return number.toString();
  }

  void checkDateEnd(CurrentRemainingTime data) {
    if (data == null) {
      onEnd?.call();
      disposeDiffTimer();
    }
  }

  CurrentRemainingTime getDateData() {
    if (widget.endTime == null) return null;
    int diff = ((widget.endTime - DateTime.now().millisecondsSinceEpoch) / 1000).floor();
    if (diff <= 0) {
      return null;
    }
    int days = 0, hours = 0, min = 0, sec = 0;

    if (diff >= 86400) {
      days = (diff / 86400).floor();
      diff -= days * 86400;
    }
    if (diff >= 3600) {
      hours = (diff / 3600).floor();
      diff -= hours * 3600;

      if(days != null) {
        hours = hours + Duration(days: days).inHours;
      }
    }
    if (diff >= 60) {
      min = (diff / 60).floor();
      diff -= min * 60;
    }
    sec = diff.toInt();
    return CurrentRemainingTime(hours: hours, min: min, sec: sec);
  }

  timerDiffDate() {
    CurrentRemainingTime data = getDateData();
    setState(() {
      currentRemainingTime = data;
    });
    disposeDiffTimer();
    if (data == null) {
      return null;
    }
    const period = const Duration(seconds: 1);
    _diffTimer = Timer.periodic(period, (timer) {
      //到时回调
      CurrentRemainingTime data = getDateData();
      setState(() {
        currentRemainingTime = data;
      });
      checkDateEnd(data);
      if (data == null) {
        disposeDiffTimer();
      }
    });
  }

  @override
  void dispose() {
    disposeDiffTimer();
    super.dispose();
  }

  disposeDiffTimer() {
    _diffTimer?.cancel();
    _diffTimer = null;
  }
}

class CurrentRemainingTime {
  final int hours;
  final int min;
  final int sec;

  CurrentRemainingTime({this.hours, this.min, this.sec});

  @override
  String toString() {
    return 'CurrentRemainingTime{hours: $hours, min: $min, sec: $sec}';
  }
}