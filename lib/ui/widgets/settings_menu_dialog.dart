import 'package:bounty_hub_client/ui/widgets/custom_appbar.dart';
import 'package:bounty_hub_client/ui/widgets/top_sheet_widget.dart';
import 'package:flutter/material.dart';

typedef void OnSelect();  // калбек без параметров, как воидкалбек
// typedef void OnSelect(EnumType itemType);   // это тип коллбека в который можно передать параметры

class SettingsMenuDialog extends StatefulWidget {
  final OnSelect onSelect;

  SettingsMenuDialog._(
    this.onSelect,
  );

  /// onSelect это каллбек, ты можешь передать в него енам,
  /// а в месте вызова сделать свитч по енаму и обрабатывать клики.
  /// Или же можешь сделать для каждой кнопки свой каллбек.
  /// Или можешь вовсе не делать каллбеки, а прям здесь описать всю логику, а это свой кубит и тд.
  static Future<void> show(
    BuildContext context,
    void onSelect(), {

    height = 400,  // высота не динамическая, нужно задать руками. Динамическая высота возможна но это дешевле
  }) async {
    return showDialog(
        context: context,
        builder: (context) => TopSheet(
            SettingsMenuDialog._(
              onSelect,
            ),
            height: double.tryParse(height.toString())),
        barrierColor: Colors.transparent);
  }

  @override
  _FilterDialogState createState() => _FilterDialogState();
}

class _FilterDialogState extends State<SettingsMenuDialog> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomAppBar(
          title: 'Settings',
          leftIcon: 'assets/images/reject.png',
          onLeftIconClick: () {
            TopSheetState.close(context);
          },
          color: Colors.white,
        ),
      ],
    );
  }
}
