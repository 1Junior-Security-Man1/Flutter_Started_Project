import 'package:bounty_hub_client/bloc/auth/authentication_event.dart';
import 'package:bounty_hub_client/bloc/auth/authorization_bloc.dart';
import 'package:bounty_hub_client/ui/pages/my_tasks/cubit/my_tasks_cubit.dart';
import 'package:bounty_hub_client/ui/pages/profile_page/view_profile/bloc/profile_bloc.dart';
import 'package:bounty_hub_client/ui/pages/profile_page/view_profile/profile_page.dart';
import 'package:bounty_hub_client/ui/pages/task_details/widgets/add_dialogs.dart';
import 'package:bounty_hub_client/ui/pages/tasks_list/cubit/tasks_list_cubit.dart';
import 'package:bounty_hub_client/ui/widgets/custom_appbar.dart';
import 'package:bounty_hub_client/ui/widgets/top_sheet_widget.dart';
import 'package:bounty_hub_client/utils/ui/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

    height = 200,  // высота не динамическая, нужно задать руками. Динамическая высота возможна но это дешевле
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
  _SettingsDialogState createState() => _SettingsDialogState();
}

class _SettingsDialogState extends State<SettingsMenuDialog> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomAppBar(
          title: 'Settings',
          rightIcon: 'assets/images/reject.png',
          onRightIconClick: () {
            TopSheetState.close(context);
          },
          color: Colors.white,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: ListTile(
            leading: Image.asset(
              'assets/images/key.png',
              width: 36,
              height: 36,
            ),
            title: Text('Log Out', style: AppTextStyles.settingsTextStyle),
            onTap: () {
              showConfirmActionDialog(context, 'Are you sure you want to Log Out from your account?', () {
                  TopSheetState.close(context);
                  BlocProvider.of<TasksListCubit>(context).destroy();
                  BlocProvider.of<MyTasksCubit>(context).destroy();
                  BlocProvider.of<ProfileBloc>(context).destroy();
                  BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
                }, () {
                  Navigator.of(context).pop();
              });
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: ListTile(
            leading: Image.asset(
              'assets/images/edit_icon.png',
              width: 28,
              height: 28,
            ),
            title: Text('Edit Account Data', style: AppTextStyles.settingsTextStyle),
            onTap: () {
              TopSheetState.close(context);
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => ProfilePage())
              );
            },
          ),
        ),
      ],
    );
  }
}